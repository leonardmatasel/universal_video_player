import 'package:flutter/material.dart';

/// An inherited widget that provides consistent theming for
/// [UniversalVideoPlayer] instances within its widget subtree.
///
/// Wrap the parts of your widget tree that should share the same
/// [UniversalVideoPlayerThemeData] with this widget.
///
/// Example usage:
/// ```dart
/// UniversalVideoPlayerTheme(
///   data: UniversalVideoPlayerThemeData(
///     colors: VideoPlayerColorScheme(active: Colors.blueAccent),
///   ),
///   child: UniversalVideoPlayer(),
/// )
/// ```
class UniversalVideoPlayerTheme extends InheritedTheme {
  /// The theme data that defines the visual appearance of the video player.
  final UniversalVideoPlayerThemeData data;

  const UniversalVideoPlayerTheme({
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(covariant UniversalVideoPlayerTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return UniversalVideoPlayerTheme(data: data, child: child);
  }

  /// Retrieves the nearest [UniversalVideoPlayerThemeData] from
  /// the widget tree that encloses the given [context].
  ///
  /// Returns null if no [UniversalVideoPlayerTheme] ancestor is found.
  static UniversalVideoPlayerThemeData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniversalVideoPlayerTheme>()
        ?.data;
  }
}

/// A container for all theme-related data used by
/// [UniversalVideoPlayer], divided into modular sub-themes.
class UniversalVideoPlayerThemeData {
  /// Color scheme for all colors used in the video player.
  final VideoPlayerColorScheme colors;

  /// Label theme data, including default strings and messages.
  final VideoPlayerLabelTheme labels;

  /// Icon data theme used for player controls and status indicators.
  final VideoPlayerIconTheme icons;

  /// Shape-related styling such as border radius.
  final VideoPlayerShapeTheme shapes;

  /// Theme data for overlays like background shading.
  final VideoPlayerOverlayTheme overlays;

  const UniversalVideoPlayerThemeData({
    this.colors = const VideoPlayerColorScheme(),
    this.labels = const VideoPlayerLabelTheme(),
    this.icons = const VideoPlayerIconTheme(),
    this.shapes = const VideoPlayerShapeTheme(),
    this.overlays = const VideoPlayerOverlayTheme(),
  });

  /// Returns a copy of this theme data, overriding only the
  /// specified properties.
  UniversalVideoPlayerThemeData copyWith({
    VideoPlayerColorScheme? colors,
    VideoPlayerLabelTheme? labels,
    VideoPlayerIconTheme? icons,
    VideoPlayerShapeTheme? shapes,
    VideoPlayerOverlayTheme? overlays,
  }) {
    return UniversalVideoPlayerThemeData(
      colors: colors ?? this.colors,
      labels: labels ?? this.labels,
      icons: icons ?? this.icons,
      shapes: shapes ?? this.shapes,
      overlays: overlays ?? this.overlays,
    );
  }
}

/// Defines color properties for various UI elements of the video player.
@immutable
class VideoPlayerColorScheme {
  /// Color for active UI elements like the progress bar fill.
  final Color active;

  /// Color for the draggable thumb on the progress bar.
  final Color? thumb;

  /// Color for inactive or disabled UI elements.
  final Color inactive;

  /// Background color of the video thumbnail display.
  final Color backgroundThumbnail;

  /// Color of the play/pause icon.
  final Color? playPauseIcon;

  /// Background color behind the play/pause icon.
  final Color playPauseBackground;

  /// Color of the live indicator badge (optional).
  final Color? liveIndicator;

  /// General icon color for controls (optional).
  final Color? icon;

  /// Background color for the error screen.
  final Color backgroundError;

  /// Text color for error messages.
  final Color textError;

  /// Default text color for labels and messages.
  final Color? textDefault;

  const VideoPlayerColorScheme({
    this.active = Colors.redAccent,
    this.thumb,
    this.inactive = Colors.grey,
    this.backgroundThumbnail = Colors.transparent,
    this.playPauseIcon = Colors.white,
    this.playPauseBackground = Colors.black,
    this.liveIndicator = Colors.red,
    this.icon = Colors.white,
    this.backgroundError = Colors.black,
    this.textError = Colors.white,
    this.textDefault = Colors.white,
  });

  /// Creates a copy of this color scheme overriding
  /// the specified color values.
  VideoPlayerColorScheme copyWith({
    Color? active,
    Color? thumb,
    Color? inactive,
    Color? backgroundThumbnail,
    Color? playPauseIcon,
    Color? playPauseBackground,
    Color? liveIndicator,
    Color? icon,
    Color? backgroundError,
    Color? textError,
    Color? textDefault,
  }) {
    return VideoPlayerColorScheme(
      active: active ?? this.active,
      thumb: thumb ?? this.thumb,
      inactive: inactive ?? this.inactive,
      backgroundThumbnail: backgroundThumbnail ?? this.backgroundThumbnail,
      playPauseIcon: playPauseIcon ?? this.playPauseIcon,
      playPauseBackground: playPauseBackground ?? this.playPauseBackground,
      liveIndicator: liveIndicator ?? this.liveIndicator,
      icon: icon ?? this.icon,
      backgroundError: backgroundError ?? this.backgroundError,
      textError: textError ?? this.textError,
      textDefault: textDefault ?? this.textDefault,
    );
  }
}

/// Defines default string labels used in the video player.
@immutable
class VideoPlayerLabelTheme {
  /// Default error message displayed on playback failure.
  final String errorMessage;

  /// Label for the action to open video in an external player.
  final String openExternalLabel;

  /// Label for the action to refresh/reload the player.
  final String refreshLabel;

  const VideoPlayerLabelTheme({
    this.errorMessage = 'An error occurred while loading the video.',
    this.openExternalLabel = 'Open with external player',
    this.refreshLabel = 'Refresh',
  });

  /// Returns a copy of this label theme overriding only the provided fields.
  VideoPlayerLabelTheme copyWith({
    String? errorMessage,
    String? openExternalLabel,
    String? refreshLabel,
  }) {
    return VideoPlayerLabelTheme(
      errorMessage: errorMessage ?? this.errorMessage,
      openExternalLabel: openExternalLabel ?? this.openExternalLabel,
      refreshLabel: refreshLabel ?? this.refreshLabel,
    );
  }
}

/// Defines icon data used for various player controls and status indicators.
@immutable
class VideoPlayerIconTheme {
  /// Icon for exiting fullscreen mode.
  final IconData exitFullScreen;

  /// Icon for entering fullscreen mode.
  final IconData fullScreen;

  /// Icon representing volume on (mute).
  final IconData mute;

  /// Icon representing volume off (unmute).
  final IconData unMute;

  /// Icon used for replaying the video.
  final IconData replay;

  /// Animated icon used to toggle play/pause.
  final AnimatedIconData playPause;

  /// Icon shown on playback error.
  final IconData error;

  const VideoPlayerIconTheme({
    this.exitFullScreen = Icons.fullscreen_exit,
    this.fullScreen = Icons.fullscreen,
    this.mute = Icons.volume_up,
    this.unMute = Icons.volume_off,
    this.replay = Icons.replay,
    this.playPause = AnimatedIcons.play_pause,
    this.error = Icons.error,
  });

  /// Creates a copy of this icon theme with selective overrides.
  VideoPlayerIconTheme copyWith({
    IconData? exitFullScreen,
    IconData? fullScreen,
    IconData? mute,
    IconData? unMute,
    IconData? replay,
    AnimatedIconData? playPause,
    IconData? error,
  }) {
    return VideoPlayerIconTheme(
      exitFullScreen: exitFullScreen ?? this.exitFullScreen,
      fullScreen: fullScreen ?? this.fullScreen,
      mute: mute ?? this.mute,
      unMute: unMute ?? this.unMute,
      replay: replay ?? this.replay,
      playPause: playPause ?? this.playPause,
      error: error ?? this.error,
    );
  }
}

/// Defines shape-related styling options such as border radius.
@immutable
class VideoPlayerShapeTheme {
  /// Border radius applied to the video player UI.
  final double borderRadius;

  const VideoPlayerShapeTheme({this.borderRadius = 0});

  /// Returns a copy with an updated border radius.
  VideoPlayerShapeTheme copyWith({double? borderRadius}) =>
      VideoPlayerShapeTheme(borderRadius: borderRadius ?? this.borderRadius);
}

/// Defines theming for overlays such as background shading behind the player.
@immutable
class VideoPlayerOverlayTheme {
  /// Background color used for overlays.
  final Color? backgroundColor;

  /// Alpha transparency value (0-255) applied to the background color.
  final int? alpha;

  const VideoPlayerOverlayTheme({this.backgroundColor, this.alpha = 150});

  /// Returns a copy overriding the background color and/or alpha.
  VideoPlayerOverlayTheme copyWith({Color? backgroundColor, int? alpha}) =>
      VideoPlayerOverlayTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        alpha: alpha ?? this.alpha,
      );
}
