import 'package:flutter/material.dart';

@immutable
class CustomWidgets {
  /// A widget displayed while the player is initializing or buffering.
  final Widget loadingWidget;

  /// A custom widget to display when an error occurs.
  final Widget? errorPlaceholder;

  /// Custom widget for the bottom control bar.
  final Widget? bottomControlsBar;

  /// Widgets to place on the leading side of the bottom control bar.
  final List<Widget> leadingBottomButtons;

  /// Widgets to place on the trailing side of the bottom control bar.
  final List<Widget> trailingBottomButtons;

  /// Custom widget to replace the default seek/progress bar.
  final Widget? customSeekBar;

  /// Custom widget to replace the default current/duration indicator.
  final Widget? customDurationDisplay;

  /// Custom widget to replace the default remaining time indicator.
  final Widget? customRemainingTimeDisplay;

  /// An optional thumbnail to show before playback starts.
  ///
  /// This image is displayed as a placeholder before the video begins playing,
  /// typically used to give users a preview of the content.
  ///
  /// To customize the background color behind the thumbnail,
  /// use the `backgroundColor` property in [playerTheme].
  final ImageProvider<Object>? thumbnail;

  /// How the thumbnail should be fitted inside its container.
  final BoxFit thumbnailFit;

  const CustomWidgets({
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.errorPlaceholder,
    this.bottomControlsBar,
    this.leadingBottomButtons = const [],
    this.trailingBottomButtons = const [],
    this.customSeekBar,
    this.customDurationDisplay,
    this.customRemainingTimeDisplay,
    this.thumbnail,
    this.thumbnailFit = BoxFit.cover,
  });

  /// Returns a new [CustomWidgets] instance with specified fields overridden.
  ///
  /// Parameters:
  ///
  /// - [loadingWidget]: A widget displayed while the player is initializing or buffering.
  ///
  /// - [errorPlaceholder]: A custom widget to display when an error occurs.
  ///
  /// - [bottomControlsBar]: A custom widget for the bottom control bar.
  ///
  /// - [leadingBottomButtons]: Widgets to place on the leading side of the bottom control bar.
  ///
  /// - [trailingBottomButtons]: Widgets to place on the trailing side of the bottom control bar.
  ///
  /// - [customSeekBar]: Custom widget to replace the default seek/progress bar.
  ///
  /// - [customDurationDisplay]: Custom widget to replace the default current/duration indicator.
  ///
  /// - [customRemainingTimeDisplay]: Custom widget to replace the default remaining time indicator.
  ///
  /// - [thumbnail]: An optional thumbnail to show before playback starts.
  ///   Typically used as a preview image. Background color can be customized via `playerTheme`.
  ///
  /// - [thumbnailFit]: How the thumbnail should be fitted inside its container.
  CustomWidgets copyWith({
    Widget? loadingWidget,
    Widget? errorPlaceholder,
    Widget? bottomControlsBar,
    List<Widget>? leadingBottomButtons,
    List<Widget>? trailingBottomButtons,
    Widget? customSeekBar,
    Widget? customDurationDisplay,
    Widget? customRemainingTimeDisplay,
    ImageProvider<Object>? thumbnail,
    BoxFit? thumbnailFit,
  }) {
    return CustomWidgets(
      loadingWidget: loadingWidget ?? this.loadingWidget,
      errorPlaceholder: errorPlaceholder ?? this.errorPlaceholder,
      bottomControlsBar: bottomControlsBar ?? this.bottomControlsBar,
      leadingBottomButtons: leadingBottomButtons ?? this.leadingBottomButtons,
      trailingBottomButtons:
          trailingBottomButtons ?? this.trailingBottomButtons,
      customSeekBar: customSeekBar ?? this.customSeekBar,
      customDurationDisplay:
          customDurationDisplay ?? this.customDurationDisplay,
      customRemainingTimeDisplay:
          customRemainingTimeDisplay ?? this.customRemainingTimeDisplay,
      thumbnail: thumbnail ?? this.thumbnail,
      thumbnailFit: thumbnailFit ?? this.thumbnailFit,
    );
  }
}
