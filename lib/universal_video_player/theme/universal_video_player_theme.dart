import 'package:flutter/material.dart';

/// An inherited widget to provide consistent theming for [UniversalVideoPlayer] instances.
///
/// Use this widget to wrap parts of your widget tree that should use the same [VideoPlayerThemeData].
class UniversalVideoPlayerTheme extends InheritedTheme {
  /// The data defining the visual appearance of the video player.
  final PlayerThemeData data;

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

  /// Retrieves the current theme data from the closest ancestor [UniversalVideoPlayerTheme].
  static PlayerThemeData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniversalVideoPlayerTheme>()
        ?.data;
  }
}

class PlayerThemeData {
  // === Colors ===

  /// Color used for active elements (e.g., seek bar).
  final Color activeColor; //checked

  /// Color of the draggable thumb in the seek bar.
  final Color? thumbColor; //checked

  /// Color for inactive controls (e.g., unplayed portion of progress bar).
  final Color inactiveColor; //checked

  /// Default background color of the thumbnail.
  final Color backgroundThumbnailColor; //checked

  /// Color of the play/pause icon.
  final Color? playPauseIconColor; //checked

  /// Background color behind the play/pause icon.
  final Color playPauseBackgroundColor; //checked

  /// Text color used across the player (optional override).
  final Color? textColor; //checked

  /// Color of the live indicator badge.
  final Color? liveIndicatorColor; //checked

  /// General icon color (used for controls).
  final Color? iconColor; //checked

  // === Error UI ===

  /// Background color of the error screen.
  final Color backgroundErrorColor; //checked

  /// Text color used in the error message.
  final Color textErrorColor; //checked

  /// Default error message displayed on playback failure.
  final String errorMessage; //checked

  /// Label for opening the video in an external player.
  final String openExternalPlayerLabel; //checked

  /// Label for opening the video in an external player.
  final String refreshPlayerLabel;

  // === UI/UX ===

  /// Border radius applied to the video player.
  final double borderRadius; //checked

  /// Background color overlay placed behind the video player.
  ///
  /// To have effect, this, [backgroundOverlayAlpha], and [enableBackgroundOverlayClip]
  /// must all be non-null and properly set.
  final Color? backgroundOverlayColor; //checked

  /// Alpha value (0-255) applied to [backgroundOverlayColor], controlling its transparency.
  ///
  /// To have effect, this, [backgroundOverlayColor], and [enableBackgroundOverlayClip]
  /// must all be non-null and properly set.
  final int? backgroundOverlayAlpha; //checked

  /// Icons used throughout the video player UI.
  final VideoPlayerIcons icons;

  const PlayerThemeData({
    this.activeColor = Colors.redAccent,
    this.thumbColor,
    this.inactiveColor = Colors.grey,
    this.playPauseIconColor = Colors.white,
    this.playPauseBackgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.liveIndicatorColor = Colors.red,
    this.iconColor = Colors.white,
    this.backgroundErrorColor = Colors.black,
    this.textErrorColor = Colors.white,
    this.errorMessage = 'An error occurred while loading the video.',
    this.openExternalPlayerLabel = 'Open with external player',
    this.refreshPlayerLabel = 'Refresh',
    this.borderRadius = 0,
    this.backgroundOverlayColor,
    this.backgroundOverlayAlpha = 150,
    this.backgroundThumbnailColor = Colors.transparent,
    this.icons = const VideoPlayerIcons(),
  });

  /// Creates a copy of this [PlayerThemeData] but with the given fields
  /// replaced by the new values.
  ///
  /// This method allows you to create a new [PlayerThemeData] instance
  /// by selectively overriding some properties, while keeping the rest
  /// unchanged from the current instance.
  ///
  /// Useful for modifying only certain theme aspects without
  /// redefining the entire theme.
  ///
  /// Parameters:
  /// - [activeColor]: Color for active UI elements (e.g., seek bar).
  /// - [thumbColor]: Color for the draggable thumb on the seek bar.
  /// - [inactiveColor]: Color for inactive UI elements (e.g., unplayed progress).
  /// - [playPauseIconColor]: Color of the play/pause icon.
  /// - [playPauseBackgroundColor]: Background color behind the play/pause icon.
  /// - [textColor]: General text color override.
  /// - [liveIndicatorColor]: Color of the live indicator badge.
  /// - [iconColor]: General icon color used in the controls.
  /// - [backgroundErrorColor]: Background color for error screens.
  /// - [textErrorColor]: Text color for error messages.
  /// - [errorMessage]: Default error message string.
  /// - [openExternalPlayerLabel]: Label for opening the video externally.
  /// - [borderRadius]: Border radius applied to the video player UI.
  /// - [backgroundOverlayColor]: Background overlay color behind the player.
  /// - [backgroundOverlayAlpha]: Transparency (alpha) of the overlay (0-255).
  /// - [backgroundThumbnailColor]: Default background color of video thumbnails.
  /// - [icons]: Custom set of icons used in the video player.
  ///
  /// Returns:
  /// A new [PlayerThemeData] instance with updated fields.
  ///
  /// Fields not provided will retain their current values.
  PlayerThemeData copyWith({
    Color? activeColor,
    Color? thumbColor,
    Color? inactiveColor,
    Color? playPauseIconColor,
    Color? playPauseBackgroundColor,
    Color? textColor,
    Color? liveIndicatorColor,
    Color? iconColor,
    Color? backgroundErrorColor,
    Color? textErrorColor,
    String? errorMessage,
    String? openExternalPlayerLabel,
    String? refreshPlayerLabel,
    double? borderRadius,
    Color? backgroundOverlayColor,
    int? backgroundOverlayAlpha,
    Color? backgroundThumbnailColor,
    VideoPlayerIcons? icons,
  }) {
    return PlayerThemeData(
      activeColor: activeColor ?? this.activeColor,
      thumbColor: thumbColor ?? this.thumbColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      playPauseIconColor: playPauseIconColor ?? this.playPauseIconColor,
      playPauseBackgroundColor:
          playPauseBackgroundColor ?? this.playPauseBackgroundColor,
      textColor: textColor ?? this.textColor,
      liveIndicatorColor: liveIndicatorColor ?? this.liveIndicatorColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundErrorColor: backgroundErrorColor ?? this.backgroundErrorColor,
      textErrorColor: textErrorColor ?? this.textErrorColor,
      errorMessage: errorMessage ?? this.errorMessage,
      openExternalPlayerLabel:
          openExternalPlayerLabel ?? this.openExternalPlayerLabel,
      refreshPlayerLabel: refreshPlayerLabel ?? this.refreshPlayerLabel,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundOverlayColor:
          backgroundOverlayColor ?? this.backgroundOverlayColor,
      backgroundOverlayAlpha:
          backgroundOverlayAlpha ?? this.backgroundOverlayAlpha,
      backgroundThumbnailColor:
          backgroundThumbnailColor ?? this.backgroundThumbnailColor,
      icons: icons ?? this.icons,
    );
  }
}

/// Icon set used throughout the video player for key UI elements.
class VideoPlayerIcons {
  /// Icon for exiting fullscreen mode.
  final IconData exitFullScreen;

  /// Icon for entering fullscreen mode.
  final IconData fullScreen;

  /// Icon for volume on (mute).
  final IconData mute;

  /// Icon for volume off (unmute).
  final IconData unMute;

  /// Icon for replaying the video.
  final IconData replay;

  /// Animated play/pause toggle icon.
  final AnimatedIconData playPause;

  /// Icon displayed on playback error.
  final IconData error;

  const VideoPlayerIcons({
    this.exitFullScreen = Icons.fullscreen_exit,
    this.fullScreen = Icons.fullscreen,
    this.mute = Icons.volume_up,
    this.unMute = Icons.volume_off,
    this.replay = Icons.replay,
    this.playPause = AnimatedIcons.play_pause,
    this.error = Icons.error,
  });

  /// Creates a copy of this [VideoPlayerIcons] with the given fields replaced.
  ///
  /// Allows selective overriding of individual icon data while preserving the rest.
  ///
  /// Example:
  /// ```dart
  /// final newIcons = oldIcons.copyWith(
  ///   fullScreen: Icons.fullscreen_sharp,
  ///   error: Icons.warning,
  /// );
  /// ```
  VideoPlayerIcons copyWith({
    IconData? exitFullScreen,
    IconData? fullScreen,
    IconData? mute,
    IconData? unMute,
    IconData? replay,
    AnimatedIconData? playPause,
    IconData? error,
  }) {
    return VideoPlayerIcons(
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
