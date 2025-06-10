import 'package:flutter/cupertino.dart';
import 'package:universal_video_player/src/controllers/default_playback_controller.dart';
import 'package:universal_video_player/src/video_player_initializer/video_player_initializer_factory.dart';
import 'package:universal_video_player/universal_video_player.dart';
import 'package:video_player/video_player.dart' show VideoPlayer;

class NetworkInitializer implements IVideoPlayerInitializerStrategy {
  final VideoPlayerOptions options;
  final VideoPlayerCallbacks callbacks;
  final GlobalPlaybackController? globalController;
  final void Function()? onErrorCallback;

  NetworkInitializer({
    required this.options,
    required this.callbacks,
    this.globalController,
    this.onErrorCallback,
  });

  @override
  Future<UniversalPlaybackController?> initialize() async {
    try {
      final controller = await DefaultPlaybackController.create(
        videoUrl: options.playbackConfig.videoUrl!,
        dataSource: null,
        audioUrl: null,
        isLive: false,
        globalController: globalController,
        initialPosition: options.playbackConfig.initialPosition,
        initialVolume: options.playbackConfig.initialVolume,
        autoPlay: options.playbackConfig.autoPlay,
        callbacks: callbacks,
        type: options.playbackConfig.videoSourceType,
      );

      controller.sharedPlayerNotifier.value = Hero(
        tag: options.globalKeyPlayer,
        child: VideoPlayer(
          key: options.globalKeyPlayer,
          controller.videoController,
        ),
      );

      callbacks.onControllerCreated?.call(controller);
      return controller;
    } catch (e) {
      onErrorCallback?.call();
      return null;
    }
  }
}
