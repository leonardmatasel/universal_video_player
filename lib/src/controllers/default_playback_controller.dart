import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:universal_video_player/universal_video_player.dart';
import 'package:video_player/video_player.dart';

import 'audio_playback_controller.dart';
import 'video_playback_controller.dart';

/// A controller that manages synchronized video and optional audio playback.
///
/// Supports features like global player coordination, mute handling,
/// fullscreen transitions, and real-time state updates.
class DefaultPlaybackController extends UniversalPlaybackController {
  late VideoPlaybackController videoController;
  late AudioPlaybackController? audioController;

  final VideoPlayerCallbacks callbacks;

  @override
  late final Uri? videoUrl;

  @override
  late final String? videoDataSource;

  @override
  late final bool isLive;

  @override
  final VideoSourceType videoSourceType = VideoSourceType.youtube;

  @override
  final ValueNotifier<Widget?> sharedPlayerNotifier = ValueNotifier(null);

  @override
  final String? videoId = null;

  Duration _lastPosition = Duration.zero;
  Timer? _positionWatcher;
  bool _wasPlayingBeforeSeek = false;

  bool _isSeeking = false;
  bool _isFullScreen = false;
  bool _hasStarted = false;
  final GlobalPlaybackController? _globalController;
  double _previousVolume = 1.0;
  bool _isNotifyPending = false;

  DefaultPlaybackController._(
    this.videoController,
    this.audioController,
    this.videoUrl,
    this.videoDataSource,
    this.isLive,
    this._globalController,
    initialPosition,
    initialVolume,
    autoPlay,
    this.callbacks,
  ) {
    seekTo(initialPosition, skipHasPlaybackStarted: true);
    if (initialVolume != null) {
      volume = initialVolume;
    }
    if (autoPlay) {
      play();
    }
    videoController.addListener(_onControllerUpdate);
    audioController?.addListener(_onControllerUpdate);
    _startPositionWatcher();
  }

  /// Creates and initializes a new [UniversalPlaybackController] instance.
  static Future<DefaultPlaybackController> create({
    required Uri? videoUrl,
    required String? dataSource,
    Uri? audioUrl,
    bool isLive = false,
    GlobalPlaybackController? globalController,
    initialPosition = Duration.zero,
    initialVolume,
    autoPlay = false,
    required VideoPlayerCallbacks callbacks,
    required VideoSourceType type,
  }) async {
    final videoController =
        (type == VideoSourceType.asset && dataSource != null)
            ? VideoPlaybackController.asset(dataSource)
            : VideoPlaybackController.uri(videoUrl!, isLive: isLive);
    await videoController.initialize();

    AudioPlaybackController? audioController;
    if (audioUrl != null) {
      audioController = AudioPlaybackController.uri(audioUrl, isLive: isLive);
      await audioController.initialize();
    }

    return DefaultPlaybackController._(
      videoController,
      audioController,
      videoUrl,
      dataSource,
      isLive,
      globalController,
      initialPosition,
      initialVolume,
      autoPlay,
      callbacks,
    );
  }

  void _onControllerUpdate() {
    if (_isNotifyPending) return;
    _isNotifyPending = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _isNotifyPending = false;
      notifyListeners();
    });
  }

  // because currentPosition is not correctly notify
  void _startPositionWatcher() {
    _positionWatcher?.cancel();
    _positionWatcher = Timer.periodic(const Duration(milliseconds: 250), (_) {
      final current = currentPosition;

      // Notifica solo se la posizione è cambiata
      if (current != _lastPosition) {
        _lastPosition = current;
        notifyListeners();
      }
    });
  }

  @override
  bool get wasPlayingBeforeSeek => _wasPlayingBeforeSeek;

  @override
  set wasPlayingBeforeSeek(bool value) {
    _wasPlayingBeforeSeek = value;
    notifyListeners();
  }

  /// Returns true if both video and audio (if present) are initialized.
  @override
  bool get isReady =>
      videoController.value.isInitialized &&
      (audioController?.value.isInitialized ?? true);

  /// Returns true if both video and audio (if present) are currently playing.
  @override
  bool get isPlaying =>
      videoController.value.isPlaying &&
      (audioController?.value.isPlaying ?? true);

  /// Returns true if the video is buffering.
  @override
  bool get isBuffering => videoController.isActuallyBuffering;

  /// Returns true if an error occurred during video playback.
  @override
  bool get hasError => videoController.value.hasError;

  /// Returns true if the video is muted.
  @override
  bool get isMuted => videoController.value.volume == 0;

  /// Whether a seek operation is currently in progress.
  @override
  bool get isSeeking => _isSeeking;

  /// Whether playback has started at least once.
  @override
  bool get hasStarted => _hasStarted;

  @override
  set isSeeking(bool value) {
    _isSeeking = value;
    if (!value) callbacks.onSeekEnd?.call(currentPosition);
    notifyListeners();
  }

  /// Whether the video is currently in fullscreen mode.
  @override
  bool get isFullScreen => _isFullScreen;

  /// Returns the current playback position of the video.
  @override
  Duration get currentPosition => videoController.value.position;

  /// Returns true if the video playback has reached the end.
  @override
  bool get isFinished =>
      (currentPosition.inSeconds >= duration.inSeconds) && !isLive;

  /// Returns the total duration of the video.
  @override
  Duration get duration => videoController.value.duration;

  /// Returns the rotation correction to be applied to the video.
  @override
  int get rotationCorrection => videoController.value.rotationCorrection;

  /// Returns the resolution size of the video.
  @override
  Size get size => videoController.value.size;

  /// Returns the buffered ranges of the video.
  @override
  List<DurationRange> get buffered => videoController.value.buffered;

  /// Starts or resumes playback.
  ///
  /// If [useGlobalController] is true and a global controller is provided,
  /// playback requests will be routed through it.
  @override
  Future<void> play({bool useGlobalController = true}) async {
    _hasStarted = true;
    if (useGlobalController && _globalController != null) {
      return await _globalController.requestPlay(this);
    } else {
      await Future.wait([
        videoController.play(),
        if (audioController != null) audioController!.play(),
      ]);
    }
  }

  /// Pauses playback.
  ///
  /// If [useGlobalController] is true and a global controller is provided,
  /// pause requests will be routed through it.
  @override
  Future<void> pause({bool useGlobalController = true}) async {
    if (useGlobalController && _globalController != null) {
      return await _globalController.requestPause();
    } else {
      await Future.wait([
        videoController.pause(),
        if (audioController != null) audioController!.pause(),
      ]);
    }
  }

  /// Restarts playback from the beginning.
  @override
  Future<void> replay({bool useGlobalController = true}) async {
    await Future.wait([
      pause(useGlobalController: useGlobalController),
      seekTo(Duration.zero),
      play(useGlobalController: useGlobalController),
    ]);
  }

  /// Returns the current volume (0.0 to 1.0).
  @override
  double get volume => videoController.value.volume;

  /// Sets the volume for both video and audio (if present).
  @override
  set volume(double value) {
    videoController.setVolume(value);
    audioController?.setVolume(value);
  }

  /// Toggles mute on or off based on current state.
  @override
  void toggleMute() => isMuted ? unMute() : mute();

  /// Mutes the playback
  @override
  void mute() {
    _previousVolume = videoController.value.volume;
    videoController.setVolume(0);
    audioController?.setVolume(0);
    _globalController?.setCurrentVolume(0);
  }

  /// Restores the previous volume level.
  @override
  void unMute() {
    videoController.setVolume(_previousVolume);
    audioController?.setVolume(_previousVolume);
    _globalController?.setCurrentVolume(_previousVolume);
  }

  /// Seeks playback to a specific [position] in the video.
  ///
  /// Throws [ArgumentError] if the position exceeds the video duration.
  @override
  Future<void> seekTo(
    Duration position, {
    skipHasPlaybackStarted = false,
  }) async {
    if (position <= duration) {
      wasPlayingBeforeSeek = isPlaying;
      if (position.inMicroseconds != 0 && !skipHasPlaybackStarted) {
        _hasStarted = true;
      }
      await Future.wait([
        videoController.seekTo(position),
        if (audioController != null) audioController!.seekTo(position),
      ]);
    } else {
      throw ArgumentError('Seek position exceeds duration');
    }
    isSeeking = false;
  }

  /// Opens or closes the fullscreen playback mode.
  ///
  /// Requires a [BuildContext], a [pageBuilder] to render the fullscreen view,
  /// and an optional [onToggle] callback to react to fullscreen state changes.
  @override
  Future<void> switchFullScreenMode(
    BuildContext context, {
    required Widget Function(BuildContext)? pageBuilder,
    Widget? playerAlreadyBuilt,
    void Function(bool)? onToggle,
  }) async {
    if (_isFullScreen) {
      Navigator.of(context).pop();
    } else {
      _isFullScreen = true;
      notifyListeners();
      onToggle?.call(true);

      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) {
            return pageBuilder!(context);
          },
          transitionsBuilder: (_, animation, __, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );

      _isFullScreen = false;
      notifyListeners();
      onToggle?.call(false);
    }
  }

  /// Disposes the controller and its resources.
  @override
  void dispose() {
    _positionWatcher?.cancel();

    videoController.removeListener(_onControllerUpdate);
    audioController?.removeListener(_onControllerUpdate);
    // If this controller is still playing according to the global manager,
    // ensure we pause it before disposing.
    if (_globalController?.state.currentVideoPlaying == this) {
      _globalController?.requestPause();
    }
    videoController.dispose();
    audioController?.dispose();
    super.dispose();
  }
}
