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
          options: VideoPlayerConfiguration(
            videoSourceConfiguration: VideoSourceConfiguration(
              videoUrl: Uri.parse(
                'https://www.youtube.com/watch?v=Cp4RRAEgpeU',
              ),
              videoSourceType: VideoSourceType.youtube,
            ),
            customPlayerWidgets: CustomPlayerWidgets().copyWith(
              loadingWidget: CircularProgressIndicator(color: Colors.white),
              thumbnailFit: BoxFit.contain,
            ),
            playerUIVisibilityOptions: PlayerUIVisibilityOptions(
              showLiveIndicator: true,
              showFullScreenButton: true,
              showGradientBottomControl: true,
              useSafeAreaForBottomControls: true,
            ),
            liveLabel: 'LIVE SANTA CLAUS VILLAGE',
            playerTheme: UniversalVideoPlayerThemeData().copyWith(
              colors: VideoPlayerColorScheme().copyWith(
                liveIndicator: Colors.white,
              ),
              overlays: VideoPlayerOverlayTheme().copyWith(
                backgroundColor: Colors.black,
                alpha: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
