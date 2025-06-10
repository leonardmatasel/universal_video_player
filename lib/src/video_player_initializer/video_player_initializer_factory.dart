import 'dart:ui';

import 'package:universal_video_player/src/video_player_initializer/asset_initializer.dart';
import 'package:universal_video_player/src/video_player_initializer/network_initializer.dart';
import 'package:universal_video_player/src/video_player_initializer/vimeo_initializer.dart';
import 'package:universal_video_player/src/video_player_initializer/youtube_initializer.dart';
import 'package:universal_video_player/universal_video_player/controllers/global_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_callbacks.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_options.dart';
import 'package:universal_video_player/universal_video_player/models/video_source_type.dart';

abstract class IVideoPlayerInitializerStrategy {
  Future<UniversalPlaybackController?> initialize();
}

class VideoPlayerInitializerFactory {
  static IVideoPlayerInitializerStrategy getStrategy(
    VideoSourceType sourceType,
    VideoPlayerOptions options,
    VideoPlayerCallbacks callbacks,
    GlobalPlaybackController? globalController,
    VoidCallback onErrorCallback,
  ) {
    switch (sourceType) {
      case VideoSourceType.youtube:
        return YouTubeInitializer(
          options: options,
          globalController: globalController,
          onErrorCallback: onErrorCallback,
          callbacks: callbacks,
        );
      case VideoSourceType.vimeo:
        return VimeoInitializer(
          options: options,
          globalController: globalController,
          onErrorCallback: onErrorCallback,
          callbacks: callbacks,
        );
      case VideoSourceType.network:
        return NetworkInitializer(
          options: options,
          globalController: globalController,
          onErrorCallback: onErrorCallback,
          callbacks: callbacks,
        );
      case VideoSourceType.asset:
        return AssetInitializer(
          options: options,
          globalController: globalController,
          onErrorCallback: onErrorCallback,
          callbacks: callbacks,
        );
    }
  }
}
