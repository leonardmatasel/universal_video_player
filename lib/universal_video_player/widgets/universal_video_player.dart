import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_video_player/src/video_player_initializer/video_player_initializer.dart';
import 'package:universal_video_player/src/widgets/video_player_renderer.dart';
import 'package:universal_video_player/universal_video_player/controllers/global_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_callbacks.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_configuration.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';

/// A universal and configurable video player widget supporting multiple video sources.
///
/// The [UniversalVideoPlayer] is a stateless widget that integrates
/// video playback capabilities from various content types such as:
/// - YouTube
/// - Vimeo
/// - Twitch *(planned)*
/// - TikTok *(planned)*
/// - Dailymotion *(planned)*
/// - Streamable *(planned)*
/// — Online/direct URLs
/// - Local videos
///
/// This widget acts as a façade, orchestrating theming, controller
/// initialization, global playback coordination, and UI rendering.
///
/// It also supports thumbnail previews, custom callback hooks, and
/// automatic theme injection.
///
/// Example usage:
/// ```dart
/// UniversalVideoPlayer(
///   options: VideoPlayerOptions(
///     videoUrl: Uri.parse("https://example.com/video.mp4"),
///     videoSourceType: VideoSourceType.network,
///     playerTheme: const UniversalVideoPlayerThemeData.dark(),
///     useGlobalController: true,
///   ),
///   callbacks: VideoPlayerCallbacks(
///     onControllerCreated: (controller) {
///       controller.play();
///     },
///   ),
/// )
/// `
class UniversalVideoPlayer extends StatelessWidget {
  /// Creates a new instance of [UniversalVideoPlayer].
  ///
  /// The [options] parameter defines how the video player should behave
  /// and what kind of video content to load. The [callbacks] parameter
  /// allows hooking into player lifecycle events.
  const UniversalVideoPlayer({
    super.key,
    required this.options,
    required this.callbacks,
  });

  /// The playback configuration and source definition.
  final VideoPlayerConfiguration options;

  /// Callback hooks for reacting to controller state changes and events.
  final VideoPlayerCallbacks callbacks;

  @override
  Widget build(BuildContext context) {
    final globalController =
        options.globalPlaybackControlSettings.useGlobalPlaybackController
            ? context.watch<GlobalPlaybackController>()
            : null;

    return UniversalVideoPlayerTheme(
      data: options.playerTheme,
      child: VideoPlayerInitializer(
        key: options.globalKeyInitializer,
        options: options,
        callbacks: callbacks,
        globalController: globalController,
        buildPlayer:
            (context, controller, thumbnail) => Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  if (options.playerUIVisibilityOptions.showLoadingWidget &&
                      !controller.isReady)
                    Center(child: options.customPlayerWidgets.loadingWidget),
                  VideoPlayerRenderer(
                    options: options.copyWith(
                      customPlayerWidgets: options.customPlayerWidgets.copyWith(
                        thumbnail:
                            options.customPlayerWidgets.thumbnail ?? thumbnail,
                      ),
                    ),
                    callbacks: callbacks,
                    controller: controller,
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
