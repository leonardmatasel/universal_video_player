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
            options: VideoPlayerConfiguration(
              videoSourceConfiguration: VideoSourceConfiguration(
                videoDataSource: 'assets/sample.mp4',
                videoSourceType: VideoSourceType.asset,
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
