import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';
import 'package:video_player/video_player.dart';

/// An abstract interface for controlling video playback across multiple source types.
///
/// [UniversalPlaybackController] defines a unified API for managing video playback,
/// supporting various sources such as network streams, local files, or third-party platforms
/// (e.g., YouTube, Vimeo). It includes methods for controlling playback, volume, seek,
/// fullscreen, and other media-related properties.
abstract class UniversalPlaybackController with ChangeNotifier {
  /// Starts or resumes playback.
  ///
  /// If [useGlobalController] is `true`, a shared global instance is used for coordinated
  /// playback management (e.g., pausing other videos when this one plays).
  Future<void> play({bool useGlobalController = true});

  /// Pauses the current playback.
  ///
  /// If [useGlobalController] is `true`, affects the shared controller.
  Future<void> pause({bool useGlobalController = true});

  /// Restarts the video from the beginning.
  Future<void> replay({bool useGlobalController = true});

  /// Toggles the mute state between muted and unmuted.
  void toggleMute();

  /// Mutes the video.
  void mute();

  /// Unmutes the video.
  void unMute();

  /// Seeks the playback to the given [position].
  void seekTo(Duration position);

  /// Switches fullscreen mode for the video player.
  ///
  /// - [context] is the build context.
  /// - [pageBuilder] returns the widget to display in fullscreen.
  /// - [onToggle] is called with `true` when entering and `false` when exiting fullscreen.
  Future<void> switchFullScreenMode(
    BuildContext context, {
    required Widget Function(BuildContext) pageBuilder,
    void Function(bool)? onToggle,
  });

  // ──────────────── Playback Metadata and State ────────────────

  /// Whether the current video is a live stream.
  bool get isLive;

  /// The resolved video URL, if available.
  Uri? get videoUrl;

  /// The raw data source of the video, such as a URL or asset path.
  String? get videoDataSource;

  /// A unique video identifier (e.g., YouTube/Vimeo video ID).
  String? get videoId;

  /// The type of video source (e.g., asset, network, YouTube, etc.).
  VideoSourceType get videoSourceType;

  /// A notifier containing the shared video player widget.
  ///
  /// This can be used to transfer the player across widget trees (e.g., fullscreen transitions).
  ValueNotifier<Widget?> get sharedPlayerNotifier;

  // ──────────────── Playback Status ────────────────

  /// Whether the video is fully initialized and ready to play.
  bool get isReady;

  /// Whether playback is currently active.
  bool get isPlaying;

  /// Whether an error occurred during initialization or playback.
  bool get hasError;

  /// Whether the video is currently buffering.
  bool get isBuffering;

  /// The current audio volume, from 0.0 (mute) to 1.0 (max).
  double get volume;

  /// Whether the video is currently muted.
  bool get isMuted;

  /// Whether the player is actively seeking to a position.
  bool get isSeeking;

  /// Whether playback has started at least once.
  bool get hasStarted;

  /// Whether the player is currently in fullscreen mode.
  bool get isFullScreen;

  /// The current playback position.
  Duration get currentPosition;

  /// Whether playback has reached the end of the video.
  bool get isFinished;

  /// The total duration of the video.
  Duration get duration;

  /// Degrees of rotation to apply for video orientation correction.
  int get rotationCorrection;

  /// The intrinsic size (width and height) of the video.
  Size get size;

  /// A list of buffered video ranges.
  List<DurationRange> get buffered;

  // ──────────────── Setters ────────────────

  /// Sets the audio volume, clamped between 0.0 and 1.0.
  set volume(double value);

  /// Sets whether the video is currently in a seeking state.
  ///
  /// Useful for suppressing UI updates during manual seeks.
  set isSeeking(bool value);

  /// Whether playback was active prior to a seek operation.
  bool get wasPlayingBeforeSeek;

  /// Updates the flag tracking playback state before seeking.
  set wasPlayingBeforeSeek(bool value);
}
