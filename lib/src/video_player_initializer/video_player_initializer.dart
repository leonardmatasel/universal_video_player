import 'package:flutter/material.dart';
import 'package:universal_video_player/src/api/vimeo_video_api.dart';
import 'package:universal_video_player/src/controllers/global_volume_synchronizer.dart';
import 'package:universal_video_player/src/models/vimeo_video_info.dart';
import 'package:universal_video_player/src/video_player_initializer/video_player_initializer_factory.dart';
import 'package:universal_video_player/src/widgets/player/video_player_error_placeholder.dart';
import 'package:universal_video_player/universal_video_player/controllers/global_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_callbacks.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_options.dart';
import 'package:universal_video_player/universal_video_player/models/video_source_type.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:universal_video_player/src/utils/logger.dart';

class VideoPlayerInitializer extends StatefulWidget {
  const VideoPlayerInitializer({
    super.key,
    required this.options,
    required this.callbacks,
    required this.buildPlayer,
    this.globalController,
  });

  final VideoPlayerOptions options;
  final VideoPlayerCallbacks callbacks;

  final GlobalPlaybackController? globalController;
  final Widget Function(
    BuildContext context,
    UniversalPlaybackController controller,
    ImageProvider<Object>? thumbnail,
  )
  buildPlayer;

  @override
  State<VideoPlayerInitializer> createState() => VideoPlayerInitializerState();
}

class VideoPlayerInitializerState extends State<VideoPlayerInitializer>
    with AutomaticKeepAliveClientMixin<VideoPlayerInitializer> {
  @override
  bool get wantKeepAlive => true;

  UniversalPlaybackController? _controller;
  bool _isLoading = true;
  bool _hasError = false;
  VimeoVideoInfo? _vimeoVideoInfo;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> refresh() async {
    setState(() {
      _controller = null;
      _isLoading = true;
      _hasError = false;
    });
    await _initialize();
  }

  Future<void> _initialize() async {
    final type = widget.options.playbackConfig.videoSourceType;
    if (type == VideoSourceType.vimeo) {
      _vimeoVideoInfo = await VimeoVideoApi.fetchVimeoVideoInfo(
        widget.options.playbackConfig.videoId!,
      );

      if (_vimeoVideoInfo == null) {
        throw Exception('Failed to fetch Vimeo video info');
      }
    }

    final strategy = VideoPlayerInitializerFactory.getStrategy(
      type,
      widget.options,
      widget.callbacks,
      widget.globalController,
      () => setState(() => _hasError = true),
    );

    try {
      _controller = await strategy.initialize();
      _startReadyTimeout(_controller!);
    } catch (e, stack) {
      logger.e("Initialization failed", error: e, stackTrace: stack);
      _hasError = true;
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startReadyTimeout(UniversalPlaybackController controller) {
    Future.delayed(widget.options.playbackConfig.timeoutDuration, () {
      if (mounted && !controller.isReady) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoading) {
      return widget.options.uiOptions.showLoadingWidget
          ? widget.options.customWidgets.loadingWidget
          : const SizedBox.shrink();
    }

    if (_hasError || _controller == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(
          widget.options.playerTheme.borderRadius,
        ),
        child:
            widget.options.uiOptions.showErrorPlaceholder
                ? widget.options.customWidgets.errorPlaceholder ??
                    VideoPlayerErrorPlaceholder(
                      playerGlobalKey: widget.options.globalKeyInitializer,
                      showRefreshButton:
                          widget
                              .options
                              .uiOptions
                              .showRefreshButtonInErrorPlaceholder,
                      videoUrlToOpenExternally:
                          widget.options.playbackConfig.videoUrl.toString(),
                    )
                : const SizedBox.shrink(),
      );
    }

    final child = widget.buildPlayer(
      context,
      _controller!,
      widget.options.uiOptions.showThumbnailAtStart ? _getThumbnail() : null,
    );

    return widget.options.globalBehavior.synchronizeMuteAcrossPlayers &&
            widget.options.globalBehavior.useGlobalPlaybackController
        ? GlobalVolumeSynchronizer(controller: _controller!, child: child)
        : child;
  }

  ImageProvider<Object>? _getThumbnail() {
    if (!widget.options.uiOptions.showThumbnailAtStart) return null;

    switch (widget.options.playbackConfig.videoSourceType) {
      case VideoSourceType.youtube:
        final videoId =
            VideoId(widget.options.playbackConfig.videoUrl!.toString()).value;
        return NetworkImage("https://i3.ytimg.com/vi/$videoId/sddefault.jpg");

      case VideoSourceType.vimeo:
        return _vimeoVideoInfo != null
            ? NetworkImage(_vimeoVideoInfo!.thumbnailUrl)
            : null;

      case VideoSourceType.network:
        return widget.options.customWidgets.thumbnail;

      case VideoSourceType.asset:
        return widget.options.customWidgets.thumbnail;
    }
  }
}
