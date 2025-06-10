import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class YTLive extends StatelessWidget {
  const YTLive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: UniversalVideoPlayer(
          callbacks: VideoPlayerCallbacks(),
          options: VideoPlayerOptions(
            playbackConfig: PlaybackConfig(
              videoUrl: Uri.parse(
                'https://www.youtube.com/watch?v=Cp4RRAEgpeU',
              ),
              videoSourceType: VideoSourceType.youtube,
            ),
            customWidgets: CustomWidgets().copyWith(
              loadingWidget: CircularProgressIndicator(color: Colors.white),
              thumbnailFit: BoxFit.contain,
            ),
            uiOptions: VideoPlayerUIOptions(
              showLiveIndicator: true,
              showFullScreenButton: true,
              showGradientBottomControl: true,
              useSafeAreaForBottomControls: true,
            ),
            liveLabel: 'LIVE SANTA CLAUS VILLAGE',
            playerTheme: PlayerThemeData().copyWith(
              liveIndicatorColor: Colors.white,
              backgroundOverlayColor: Colors.black,
              backgroundOverlayAlpha: 100,
            ),
          ),
        ),
      ),
    );
  }
}
