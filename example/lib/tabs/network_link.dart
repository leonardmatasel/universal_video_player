import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class NetworkLink extends StatelessWidget {
  const NetworkLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        child: Center(
          child: UniversalVideoPlayer(
            callbacks: VideoPlayerCallbacks(),
            options: VideoPlayerConfiguration(
              videoSourceConfiguration: VideoSourceConfiguration(
                videoUrl: Uri.parse(
                  'https://www.w3schools.com/tags/mov_bbb.mp4',
                ),
                videoSourceType: VideoSourceType.network,
              ),
              playerUIVisibilityOptions: PlayerUIVisibilityOptions(
                useSafeAreaForBottomControls: true,
              ),
              globalPlaybackControlSettings: GlobalPlaybackControlSettings()
                  .copyWith(useGlobalPlaybackController: true),
              customPlayerWidgets: CustomPlayerWidgets().copyWith(
                loadingWidget: const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                ),
              ),
              playerTheme: UniversalVideoPlayerThemeData().copyWith(
                shapes: VideoPlayerShapeTheme().copyWith(borderRadius: 0),
                colors: VideoPlayerColorScheme().copyWith(
                  active: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
