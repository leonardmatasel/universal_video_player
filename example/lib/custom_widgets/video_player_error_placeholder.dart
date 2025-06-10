import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

/// A default error placeholder widget for the video player.
///
/// [VideoPlayerErrorPlaceholder] is shown when video playback fails due to an error.
/// It displays a themed icon, error message, and optionally provides a button
/// to open the video URL in an external video player app.
///
/// The appearance and text are styled based on the current [UniversalVideoPlayerTheme].
class VideoPlayerErrorPlaceholder extends StatelessWidget {
  /// Creates the error placeholder widget.
  ///
  /// If [videoUrlToOpenExternally] is provided, a button is shown
  /// that allows the user to open the video in an external app.
  const VideoPlayerErrorPlaceholder({
    super.key,
    required this.playerGlobalKey,
    required this.videoUrlToOpenExternally,
    required this.showRefreshButton,
  });

  /// The video URL to open in an external player, if applicable.
  final String? videoUrlToOpenExternally;

  final bool? showRefreshButton;

  final GlobalKey<VideoPlayerInitializerState> playerGlobalKey;

  @override
  Widget build(BuildContext context) {
    final theme = UniversalVideoPlayerTheme.of(context)!;

    return Container(
      color: theme.backgroundErrorColor,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(theme.icons.error, color: theme.textErrorColor, size: 42),
            const SizedBox(height: 16),
            Text(
              theme.errorMessage,
              style: TextStyle(color: theme.textErrorColor),
              textAlign: TextAlign.center,
            ),
            if (videoUrlToOpenExternally != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (defaultTargetPlatform == TargetPlatform.android) {
                      final AndroidIntent intent = AndroidIntent(
                        action: 'action_view',
                        data: videoUrlToOpenExternally!,
                      );
                      await intent.launch();
                    } else {
                      await launchUrl(Uri.parse(videoUrlToOpenExternally!));
                    }
                  },
                  child: Text(theme.openExternalPlayerLabel),
                ),
              ),
            if (showRefreshButton != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    playerGlobalKey.currentState?.refresh();
                  },
                  child: Text(theme.refreshPlayerLabel),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
