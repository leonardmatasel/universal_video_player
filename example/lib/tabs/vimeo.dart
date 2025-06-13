import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class Vimeo extends StatefulWidget {
  const Vimeo({super.key});

  @override
  State<Vimeo> createState() => _VimeoState();
}

class _VimeoState extends State<Vimeo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: UniversalVideoPlayer(
          callbacks: VideoPlayerCallbacks(
            onControllerCreated: (controller) {
              print('UNIVERSAL PLAYER: Controller creato: $controller');
            },
            onFullScreenToggled: (isFullScreen) {
              print('UNIVERSAL PLAYER: Fullscreen toggled: $isFullScreen');
            },
            onMuteToggled: (isMuted) {
              print('UNIVERSAL PLAYER: Mute toggled: $isMuted');
            },
            onSeekStart: (position) {
              print('UNIVERSAL PLAYER: Seek started at: $position');
            },
            onSeekEnd: (position) {
              print('UNIVERSAL PLAYER: Seek ended at: $position');
            },
          ),
          options: VideoPlayerConfiguration(
            videoSourceConfiguration: VideoSourceConfiguration.vimeo(
              videoId: '1017406920',
            ).copyWith(initialVolume: 0.5),
            playerUIVisibilityOptions: PlayerUIVisibilityOptions(
              useSafeAreaForBottomControls: true,
            ),
            globalPlaybackControlSettings: GlobalPlaybackControlSettings()
                .copyWith(useGlobalPlaybackController: true),
            customPlayerWidgets: CustomPlayerWidgets().copyWith(
              loadingWidget: CircularProgressIndicator(color: Colors.red),
            ),
            playerTheme: UniversalVideoPlayerThemeData().copyWith(
              overlays: VideoPlayerOverlayTheme().copyWith(
                backgroundColor: Colors.white,
                alpha: 100,
              ),
              shapes: VideoPlayerShapeTheme().copyWith(borderRadius: 0),
            ),
          ),
        ),
      ),
    );
  }
}
