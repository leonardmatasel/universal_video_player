import 'package:flutter/material.dart';
import 'package:universal_video_player/src/widgets/bottom_control_bar/video_seek_bar.dart';
import 'package:universal_video_player/src/widgets/controls/audio_toggle_button.dart';
import 'package:universal_video_player/src/widgets/controls/fullscreen_toggle_button.dart';
import 'package:universal_video_player/src/widgets/player/fullscreen_video_player.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_callbacks.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_configuration.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';

/// A widget that displays the bottom bar of video player controls.
///
/// [VideoPlaybackControlBar] includes mute/unmute button, seek bar,
/// and full screen toggle button. It connects with the provided
/// [UniversalPlaybackController], [VideoPlayerConfiguration], and [VideoPlayerCallbacks]
/// to handle user interactions and playback configuration.
///
/// This widget is typically used as part of a video player UI.
class VideoPlaybackControlBar extends StatelessWidget {
  /// Creates a control bar widget for the bottom of a video player.
  const VideoPlaybackControlBar({
    super.key,
    required this.controller,
    required this.options,
    required this.callbacks,
  });

  /// Controls the video playback (e.g., play, pause, seek, mute).
  final UniversalPlaybackController controller;

  /// Configuration options that define how the controls behave and appear.
  final VideoPlayerConfiguration options;

  /// Callbacks to handle user interactions like mute and fullscreen toggle.
  final VideoPlayerCallbacks callbacks;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (options.playerUIVisibilityOptions.showMuteUnMuteButton)
          AudioToggleButton(
            controller: controller,
            onAudioToggled: callbacks.onMuteToggled,
          ),
        ...options.customPlayerWidgets.leadingBottomButtons,
        Expanded(
          child: VideoSeekBar(
            onSeekStart: callbacks.onSeekStart,
            controller: controller,
            liveLabel: options.liveLabel,
            showCurrentTime: options.playerUIVisibilityOptions.showCurrentTime,
            showDurationTime:
                options.playerUIVisibilityOptions.showDurationTime,
            showRemainingTime:
                options.playerUIVisibilityOptions.showRemainingTime,
            customSeekBar: options.customPlayerWidgets.customSeekBar,
            showLiveIndicator:
                options.playerUIVisibilityOptions.showLiveIndicator,
            showSeekBar: options.playerUIVisibilityOptions.showSeekBar,
            customTimeDisplay:
                options.customPlayerWidgets.customDurationDisplay,
            allowSeeking: options.videoSourceConfiguration.allowSeeking,
            customDurationDisplay:
                options.customPlayerWidgets.customDurationDisplay,
            customRemainingTimeDisplay:
                options.customPlayerWidgets.customRemainingTimeDisplay,
          ),
        ),
        ...options.customPlayerWidgets.trailingBottomButtons,
        if (options.playerUIVisibilityOptions.showFullScreenButton)
          FullscreenToggleButton(
            controller: controller,
            fullscreenPageBuilder:
                (context) => UniversalVideoPlayerTheme(
                  data: options.playerTheme,
                  child: FullscreenVideoPlayer(
                    controller: controller,
                    options: options,
                    callbacks: callbacks,
                  ),
                ),
            onFullscreenToggled: callbacks.onFullScreenToggled,
          ),
      ],
    );
  }
}
