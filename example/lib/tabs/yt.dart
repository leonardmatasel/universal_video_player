import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class YT extends StatelessWidget {
  const YT({super.key});

  @override
  Widget build(BuildContext context) {
    // you can use it for everything you need
    late UniversalPlaybackController myController;

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
            onControllerCreated: (controller) {
              myController = controller;
            },
          ),
          options: VideoPlayerConfiguration(
            videoSourceConfiguration: VideoSourceConfiguration.youtube(
              videoUrl: Uri.parse(
                'https://www.youtube.com/watch?v=QN1odfjtMoo',
              ),
              preferredQualities: [720, 480],
            ),
            playerUIVisibilityOptions: PlayerUIVisibilityOptions().copyWith(
              useSafeAreaForBottomControls: true,
            ),
            customPlayerWidgets: CustomPlayerWidgets().copyWith(
              thumbnailFit: BoxFit.contain,
            ),
            playerTheme: UniversalVideoPlayerThemeData().copyWith(
              icons: VideoPlayerIconTheme().copyWith(error: Icons.warning),
              overlays: VideoPlayerOverlayTheme().copyWith(
                backgroundColor: Colors.white,
                alpha: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
