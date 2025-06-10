import 'package:flutter/material.dart';
import 'package:universal_video_player/src/video_player_initializer/video_player_initializer.dart';
import 'package:universal_video_player/universal_video_player/models/custom_widgets.dart';
import 'package:universal_video_player/universal_video_player/models/global_playback_behavior.dart';
import 'package:universal_video_player/universal_video_player/models/playback_config.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_ui_options.dart';
import 'package:universal_video_player/universal_video_player/models/video_source_type.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';

/// Configuration options for customizing the appearance and behavior of a video player.
///
/// [VideoPlayerOptions] provides a flexible way to define the playback logic, theming,
/// interaction modes, and UI components of the `UniversalVideoPlayer`.
///
/// This class is immutable and can be safely reused or cloned via [copyWith].
@immutable
class VideoPlayerOptions {
  /// Creates a new set of configuration options for a video player instance.
  VideoPlayerOptions({
    required this.playbackConfig,
    this.globalBehavior = const GlobalPlaybackBehavior(),
    this.uiOptions = const VideoPlayerUIOptions(),
    this.playerTheme = const PlayerThemeData(),
    this.customWidgets = const CustomWidgets(),
    this.liveLabel = "LIVE",
    this.enableBackgroundOverlayClip = true,
    globalKeyInitializer,
  }) {
    globalKeyPlayer = GlobalKey();
    this.globalKeyInitializer = globalKeyInitializer ?? GlobalKey();
  }

  late final GlobalKey globalKeyPlayer;

  /// Use it for refresh if have same errors (it is used in ErrorPlaceholder default): final GlobalKey`<`VideoPlayerInitializerState`>` playerGlobalKey; globalKeyInitializer.currentState?.refresh();
  late final GlobalKey<VideoPlayerInitializerState> globalKeyInitializer;

  /// Defines how the video is loaded and played (URL, autoplay, volume, etc).
  final PlaybackConfig playbackConfig;

  /// Controls global playback interactions like exclusive playback and mute sync.
  final GlobalPlaybackBehavior globalBehavior;

  /// Flags that toggle visibility of player UI elements like seek bar, buttons, etc.
  final VideoPlayerUIOptions uiOptions;

  /// Provides custom widget overrides like loading indicators, error placeholders, etc.
  final CustomWidgets customWidgets;

  /// Custom theming options for the video player controls and appearance.
  final PlayerThemeData playerTheme;

  /// Label displayed for live streams.
  final String liveLabel;

  /// Flag to enable or disable clipping of the background overlay using a rounded rectangle.
  ///
  /// To have effect, this, [backgroundOverlayColor], and [backgroundOverlayAlpha]
  /// must all be non-null and properly set into playerTheme.
  final bool? enableBackgroundOverlayClip; // checked

  /// Returns a new [VideoPlayerOptions] instance with specified fields overridden.
  ///
  /// This allows for immutability while supporting customization.
  /// Use this method to derive a new configuration by modifying only the required parts.
  ///
  /// Parameters:
  ///
  /// - [playbackConfig]: Defines how the video is loaded and played (URL, autoplay, volume, etc).
  ///
  /// - [globalBehavior]: Controls global playback interactions like exclusive playback and mute sync.
  ///
  /// - [uiOptions]: Flags that toggle visibility of player UI elements like seek bar, buttons, etc.
  ///
  /// - [playerTheme]: Theming configuration for colors, padding, typography, and overlays.
  ///
  /// - [customWidgets]: Provides custom widget overrides like loading indicators, error placeholders, etc.
  ///
  /// - [liveLabel]: Text displayed when the video is a live stream.
  ///
  /// - [enableBackgroundOverlayClip]: Whether to clip background overlays using a rounded rectangle.
  ///
  /// Returns a new [VideoPlayerOptions] with the specified fields replaced.
  ///
  /// Example usage:
  /// ```dart
  /// final newOptions = oldOptions.copyWith(
  ///   liveLabel: "LIVE NOW",
  ///   uiOptions: oldOptions.uiOptions.copyWith(showMuteUnMuteButton: false),
  /// );
  /// ```
  VideoPlayerOptions copyWith({
    PlaybackConfig? playbackConfig,
    GlobalPlaybackBehavior? globalBehavior,
    VideoPlayerUIOptions? uiOptions,
    PlayerThemeData? playerTheme,
    CustomWidgets? customWidgets,
    String? liveLabel,
    bool? enableBackgroundOverlayClip,
  }) {
    return VideoPlayerOptions(
      playbackConfig: playbackConfig ?? this.playbackConfig,
      globalBehavior: globalBehavior ?? this.globalBehavior,
      uiOptions: uiOptions ?? this.uiOptions,
      playerTheme: playerTheme ?? this.playerTheme,
      customWidgets: customWidgets ?? this.customWidgets,
      liveLabel: liveLabel ?? this.liveLabel,
      enableBackgroundOverlayClip:
          enableBackgroundOverlayClip ?? this.enableBackgroundOverlayClip,
    );
  }

  VideoPlayerOptions.simple({
    required Uri videoUrl,
    required VideoSourceType videoSourceType,
  }) : this(
         playbackConfig: PlaybackConfig(
           videoUrl: videoUrl,
           videoSourceType: videoSourceType,
         ),
       );
}
