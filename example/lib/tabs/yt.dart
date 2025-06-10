import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class YT extends StatelessWidget {
  const YT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: UniversalVideoPlayer(
          callbacks: VideoPlayerCallbacks(
            onSeekStart: (position) {
              print('UNIVERSAL PLAYER: Seek started at: $position');
            },
            onSeekEnd: (position) {
              print('UNIVERSAL PLAYER: Seek ended at: $position');
            },
          ),
          options: VideoPlayerOptions(
            playbackConfig: PlaybackConfig(
              videoUrl: Uri.parse(
                'https://www.youtube.com/watch?v=QN1odfjtMoo',
              ),
              videoSourceType: VideoSourceType.youtube,
            ),
            uiOptions: VideoPlayerUIOptions().copyWith(
              useSafeAreaForBottomControls: true,
            ),
            customWidgets: CustomWidgets().copyWith(
              thumbnailFit: BoxFit.contain,
            ),
            playerTheme: PlayerThemeData().copyWith(
              icons: VideoPlayerIcons().copyWith(error: Icons.warning),
              backgroundOverlayColor: Colors.white,
              backgroundOverlayAlpha: 100,
            ),
          ),
        ),
      ),
    );
  }
}
