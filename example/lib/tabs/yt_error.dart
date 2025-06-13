import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player.dart';

class YTError extends StatelessWidget {
  const YTError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UniversalVideoPlayer(
        callbacks: VideoPlayerCallbacks(),
        options: VideoPlayerConfiguration(
          videoSourceConfiguration: VideoSourceConfiguration.youtube(
            videoUrl: Uri.parse('https://www.youtube.com/watch?v=ysz5S6PUM-U'),
          ),
          playerTheme: UniversalVideoPlayerThemeData().copyWith(
            colors: VideoPlayerColorScheme().copyWith(
              backgroundError: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
