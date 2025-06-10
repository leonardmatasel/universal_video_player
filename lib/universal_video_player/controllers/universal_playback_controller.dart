import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';
import 'package:video_player/video_player.dart';

/// Abstract controller for managing video playback.
///
/// This class must be implemented to support different types of video sources
/// (local assets, network streams, YouTube, Vimeo, etc.). It provides a unified
/// interface for playback control and player state tracking.
abstract class UniversalPlaybackController with ChangeNotifier {
  /// Starts or resumes video playback.
  ///
  /// If [useGlobalController] is true, a shared global controller is used
  /// to manage playback across multiple video instances.
  Future<void> play({bool useGlobalController = true});

  /// Pauses the video playback.
  ///
  /// See [useGlobalController] for global playback behavior.
  Future<void> pause({bool useGlobalController = true});

  /// Restarts the video from the beginning.
  Future<void> replay({bool useGlobalController = true});

  /// Toggles the mute state of the video.
  void toggleMute();

  /// Mutes the video audio.
  void mute();

  /// Unmutes the video audio.
  void unMute();

  /// Seeks the video to a specific position.
  ///
  /// [position] defines the new playback position.
  void seekTo(Duration position);

  /// Toggles fullscreen mode for the video player.
  ///
  /// [context] is the current build context.
  /// [pageBuilder] is a function that returns the fullscreen page widget.
  /// [onToggle] is an optional callback triggered when fullscreen mode changes.
  Future<void> switchFullScreenMode(
    BuildContext context, {
    required Widget Function(BuildContext) pageBuilder,
    void Function(bool)? onToggle,
  });

  /// Whether the video is a live stream.
  bool get isLive;

  /// The video URL, if available (e.g., for network or file sources).
  Uri? get videoUrl;

  /// The video URL, if available (e.g., for network or file sources).
  String? get videoDataSource;

  /// The video ID, typically used for platforms like YouTube or Vimeo.
  String? get videoId;

  /// The source type of the video (e.g., network, asset, YouTube, etc.).
  VideoSourceType get videoSourceType;

  /// A shared notifier holding the video player widget.
  ///
  /// Useful for synchronizing player instances across different screens
  /// (e.g., when entering/exiting fullscreen).
  ValueNotifier<Widget?> get sharedPlayerNotifier;

  /// Whether the player is ready for playback (fully initialized and buffered).
  bool get isReady;

  /// Whether the video is currently playing.
  bool get isPlaying;

  /// Whether an error occurred during video initialization or playback.
  bool get hasError;

  /// Whether the video is currently buffering.
  bool get isBuffering;

  /// The current audio volume, ranging from 0.0 to 1.0.
  double get volume;

  /// Whether the video is currently muted.
  bool get isMuted;

  /// Whether the player is actively seeking to a new position.
  bool get isSeeking;

  /// Whether playback has started at least once.
  bool get hasStarted;

  /// Whether the player is currently in fullscreen mode.
  bool get isFullScreen;

  /// The current playback position.
  Duration get currentPosition;

  /// Whether the video has reached its end.
  bool get isFinished;

  /// The total duration of the video.
  Duration get duration;

  /// Degrees of rotation correction to apply to the video.
  int get rotationCorrection;

  /// The original size (width and height) of the video.
  Size get size;

  /// A list of video ranges that have been buffered.
  List<DurationRange> get buffered;

  /// Sets the audio volume of the video.
  set volume(double value);

  /// Manually sets the seeking state.
  ///
  /// Useful to indicate that the user or system is actively seeking,
  /// which can temporarily pause auto-progress updates.
  set isSeeking(bool value);

  bool get wasPlayingBeforeSeek;
  set wasPlayingBeforeSeek(bool value);
}
