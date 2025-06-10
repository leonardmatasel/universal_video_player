import 'package:flutter/foundation.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';

/// A configuration class that provides callback hooks for responding to video player events.
///
/// [VideoPlayerCallbacks] allows developers to attach custom logic
/// to lifecycle events, UI changes, and error handling during playback.
///
/// These callbacks are completely optional and non-intrusive.
@immutable
class VideoPlayerCallbacks {
  /// Creates a new set of callback hooks for [UniversalVideoPlayer] and related widgets.
  const VideoPlayerCallbacks({
    this.onControllerCreated,
    this.onFullScreenToggled,
    this.onOverlayControlsVisibilityChanged,
    this.onCenterControlsVisibilityChanged,
    this.onMuteToggled,
    this.onSeekStart,
    this.onSeekEnd,
  });

  /// Called once when the internal [UniversalPlaybackController] is created and ready.
  ///
  /// This is the ideal place to auto-start playback or set up listeners.
  final void Function(UniversalPlaybackController controller)?
  onControllerCreated;

  /// Called when the player enters or exits fullscreen mode.
  ///
  /// [isGoingFullScreen] is `true` if entering fullscreen, `false` if exiting.
  final void Function(bool isGoingFullScreen)? onFullScreenToggled;

  /// Called when overlay controls (e.g. seek bar, volume/mute, fullscreen) are shown or hidden.
  final void Function(bool areVisible)? onOverlayControlsVisibilityChanged;

  /// Called when central controls (e.g. play/pause icon in the center) are shown or hidden.
  final void Function(bool areVisible)? onCenterControlsVisibilityChanged;

  /// Called when the mute state is toggled.
  ///
  /// [isMute] is `true` if the video is now muted.
  final void Function(bool isMute)? onMuteToggled;

  /// Called when the user starts seeking.
  ///
  /// [currentPosition] is the time where the seek started.
  final void Function(Duration currentPosition)? onSeekStart;

  /// Called when the user ends a seek operation.
  ///
  /// [currentPosition] is the final position after seeking.
  final void Function(Duration currentPosition)? onSeekEnd;
}
