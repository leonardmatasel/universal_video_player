import 'package:flutter/material.dart';

@immutable
class VideoPlayerUIOptions {
  /// Whether to display the seek bar.
  final bool showSeekBar;

  /// Whether to show the current time of playback.
  final bool showCurrentTime;

  /// Whether to show the video duration.
  final bool showDurationTime;

  /// Whether to show the remaining playback time.
  final bool showRemainingTime;

  /// Whether to show a live indicator if the video is a livestream.
  final bool showLiveIndicator;

  /// Whether to show the loading widget during buffering.
  final bool showLoadingWidget;

  /// Whether to display the error placeholder on failure.
  final bool showErrorPlaceholder;

  /// Whether to show the replay button after the video ends.
  final bool showReplayButton;

  /// Whether to show the thumbnail before playback starts.
  final bool showThumbnailAtStart;

  /// Whether to display the bottom control bar.
  final bool showVideoBottomControlsBar;

  /// Whether to show the fullscreen toggle button.
  final bool showFullScreenButton;

  /// Whether to show the mute/unmute button.
  final bool showMuteUnMuteButton;

  final bool showRefreshButtonInErrorPlaceholder;

  /// Whether to wrap the bottom controls bar inside a [SafeArea] to avoid
  /// overlaps with system UI elements like gesture bars or notches.
  final bool useSafeAreaForBottomControls;

  /// Whether to display a gradient overlay behind the bottom control bar.
  final bool showGradientBottomControl;

  const VideoPlayerUIOptions({
    this.showSeekBar = true,
    this.showCurrentTime = true,
    this.showDurationTime = true,
    this.showRemainingTime = true,
    this.showLiveIndicator = true,
    this.showLoadingWidget = true,
    this.showErrorPlaceholder = true,
    this.showReplayButton = true,
    this.showThumbnailAtStart = true,
    this.showVideoBottomControlsBar = true,
    this.showFullScreenButton = true,
    this.showMuteUnMuteButton = true,
    this.useSafeAreaForBottomControls = false,
    this.showGradientBottomControl = true,
    this.showRefreshButtonInErrorPlaceholder = true,
  });

  /// Returns a new [VideoPlayerUIOptions] instance with specified fields overridden.
  ///
  /// Parameters:
  ///
  /// - [showSeekBar]: Whether to display the seek bar.
  ///
  /// - [showCurrentTime]: Whether to show the current time of playback.
  ///
  /// - [showDurationTime]: Whether to show the video duration.
  ///
  /// - [showRemainingTime]: Whether to show the remaining playback time.
  ///
  /// - [showLiveIndicator]: Whether to show a live indicator if the video is a livestream.
  ///
  /// - [showLoadingWidget]: Whether to show the loading widget during buffering.
  ///
  /// - [showErrorPlaceholder]: Whether to display the error placeholder on failure.
  ///
  /// - [showReplayButton]: Whether to show the replay button after the video ends.
  ///
  /// - [showThumbnailAtStart]: Whether to show the thumbnail before playback starts.
  ///
  /// - [showVideoBottomControlsBar]: Whether to display the bottom control bar.
  ///
  /// - [showFullScreenButton]: Whether to show the fullscreen toggle button.
  ///
  /// - [showMuteUnMuteButton]: Whether to show the mute/unmute button.
  ///
  /// - [useSafeAreaForBottomControls]: Whether to wrap the bottom controls bar inside a [SafeArea]
  ///   to avoid overlaps with system UI elements like gesture bars or notches.
  ///
  /// - [showGradientBottomControl]: Whether to display a gradient overlay behind the bottom control bar.
  VideoPlayerUIOptions copyWith({
    bool? showSeekBar,
    bool? showCurrentTime,
    bool? showDurationTime,
    bool? showRemainingTime,
    bool? showLiveIndicator,
    bool? showLoadingWidget,
    bool? showErrorPlaceholder,
    bool? showReplayButton,
    bool? showThumbnailAtStart,
    bool? showVideoBottomControlsBar,
    bool? showFullScreenButton,
    bool? showMuteUnMuteButton,
    bool? useSafeAreaForBottomControls,
    bool? showGradientBottomControl,
    bool? showRefreshButtonInErrorPlaceholder,
  }) {
    return VideoPlayerUIOptions(
      showSeekBar: showSeekBar ?? this.showSeekBar,
      showCurrentTime: showCurrentTime ?? this.showCurrentTime,
      showDurationTime: showDurationTime ?? this.showDurationTime,
      showRemainingTime: showRemainingTime ?? this.showRemainingTime,
      showLiveIndicator: showLiveIndicator ?? this.showLiveIndicator,
      showLoadingWidget: showLoadingWidget ?? this.showLoadingWidget,
      showErrorPlaceholder: showErrorPlaceholder ?? this.showErrorPlaceholder,
      showReplayButton: showReplayButton ?? this.showReplayButton,
      showThumbnailAtStart: showThumbnailAtStart ?? this.showThumbnailAtStart,
      showVideoBottomControlsBar:
          showVideoBottomControlsBar ?? this.showVideoBottomControlsBar,
      showFullScreenButton: showFullScreenButton ?? this.showFullScreenButton,
      showMuteUnMuteButton: showMuteUnMuteButton ?? this.showMuteUnMuteButton,
      useSafeAreaForBottomControls:
          useSafeAreaForBottomControls ?? this.useSafeAreaForBottomControls,
      showGradientBottomControl:
          showGradientBottomControl ?? this.showGradientBottomControl,
      showRefreshButtonInErrorPlaceholder:
          showRefreshButtonInErrorPlaceholder ??
          this.showRefreshButtonInErrorPlaceholder,
    );
  }
}
