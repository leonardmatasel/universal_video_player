import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';

/// A play/pause toggle button with animated icon and optional replay support.
///
/// The [VideoPlayPauseButton] displays an animated play/pause icon that reflects the current
/// playback state of the provided [UniversalPlaybackController].
///
/// When the video is finished and is not a live stream, a replay icon is shown if [showReplayButton] is `true`.
/// Tapping the replay icon restarts playback and optionally triggers the [onReplay] callback.
///
/// This widget also supports automatically muting the video on the first play using [autoMuteOnStart].
///
/// ### Example usage:
/// ```dart
/// VideoPlayPauseButton(
///   controller: myController,
///   autoMuteOnStart: true,
///   onReplay: () => print("Video replayed"),
/// )
/// ```
class VideoPlayPauseButton extends StatefulWidget {
  /// Creates a toggle button for play, pause, and optionally replay.
  ///
  /// Requires a [UniversalPlaybackController] and whether to auto-mute on first play.
  const VideoPlayPauseButton({
    super.key,
    required this.controller,
    required this.autoMuteOnStart,
    required this.showReplayButton,
  });

  /// The controller that manages video playback and notifies state changes.
  ///
  /// This controller is listened to internally to update the button icon based on playback state.
  final UniversalPlaybackController controller;

  /// Whether the video should be automatically muted when it starts for the first time.
  ///
  /// This is typically used when auto-playing muted content is desired.
  final bool autoMuteOnStart;

  /// Whether to display a replay icon when the video has finished playing.
  ///
  /// If `false`, the button becomes inactive once playback ends.
  final bool showReplayButton;

  @override
  State<VideoPlayPauseButton> createState() => _VideoPlayPauseButtonState();
}

class _VideoPlayPauseButtonState extends State<VideoPlayPauseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _iconAnimationController;

  UniversalPlaybackController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      value: controller.isPlaying ? 1 : 0,
      duration: const Duration(milliseconds: 400),
    );
    controller.addListener(_updateIconAnimation);
  }

  /// Syncs the animation with the controller's playback state.
  void _updateIconAnimation() {
    if (!mounted) return;

    setState(() {
      if (controller.isPlaying) {
        _iconAnimationController.forward();
      } else {
        _iconAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    controller.removeListener(_updateIconAnimation);
    _iconAnimationController.dispose();
    super.dispose();
  }

  /// Handles user tap on the button.
  ///
  /// Depending on the state, it will:
  /// - Mute and start playback if it's the first time and [autoMuteOnStart] is true.
  /// - Replay the video if it is finished.
  /// - Toggle between play and pause.
  void _handleTap() {
    if (!controller.hasStarted && widget.autoMuteOnStart) {
      controller.mute();
      controller.play();
    } else if (controller.isFinished) {
      if (!widget.showReplayButton) return;
      controller.replay();
    } else {
      controller.isPlaying ? controller.pause() : controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = UniversalVideoPlayerTheme.of(context)!;

    return Center(
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(200),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colors.playPauseBackground.withAlpha(100),
            borderRadius: BorderRadius.circular(200),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.fastOutSlowIn,
            transitionBuilder:
                (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
            child:
                controller.isFinished
                    ? widget.showReplayButton
                        ? Icon(
                          theme.icons.replay,
                          key: const ValueKey('replay'),
                          color:
                              theme.colors.playPauseIcon ?? theme.colors.icon,
                          size: 32,
                        )
                        : null
                    : AnimatedIcon(
                      key: const ValueKey('play_pause'),
                      icon: theme.icons.playPause,
                      progress: _iconAnimationController,
                      color: theme.colors.playPauseIcon ?? theme.colors.icon,
                      size: 32,
                    ),
          ),
        ),
      ),
    );
  }
}
