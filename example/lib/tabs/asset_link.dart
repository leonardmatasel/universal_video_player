import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class AssetLink extends StatelessWidget {
  const AssetLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        child: Center(
          child: UniversalVideoPlayer(
            callbacks: VideoPlayerCallbacks(),
            options: VideoPlayerOptions(
              playbackConfig: PlaybackConfig(
                videoDataSource: 'assets/sample.mp4',
                videoSourceType: VideoSourceType.asset,
              ),
              uiOptions: VideoPlayerUIOptions(
                useSafeAreaForBottomControls: true,
              ),
              globalBehavior: GlobalPlaybackBehavior().copyWith(
                useGlobalPlaybackController: true,
              ),
              customWidgets: CustomWidgets().copyWith(
                loadingWidget: const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                ),
              ),
              playerTheme: PlayerThemeData().copyWith(
                borderRadius: 0,
                activeColor: Colors.blueAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
