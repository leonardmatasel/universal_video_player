import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_video_player/universal_video_player.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => GlobalPlaybackController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universal Video Player Demo',
      theme: ThemeData.dark(),
      home: const VideoPlayerExample(),
    );
  }
}

class VideoPlayerExample extends StatefulWidget {
  const VideoPlayerExample({super.key});

  @override
  State<VideoPlayerExample> createState() => _VideoPlayerExampleState();
}

class _VideoPlayerExampleState extends State<VideoPlayerExample> {
  late UniversalPlaybackController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universal Video Player')),
      body: Center(
        child: UniversalVideoPlayer(
          callbacks: VideoPlayerCallbacks(
            onControllerCreated: (controller) {
              _controller = controller;
              _controller.play();
            },
          ),
          options: VideoPlayerConfiguration(
            videoSourceConfiguration: VideoSourceConfiguration.youtube(
              videoUrl: Uri.parse(
                'https://www.youtube.com/watch?v=QN1odfjtMoo',
              ),
              preferredQualities: [720, 480],
            ),
            playerTheme: UniversalVideoPlayerThemeData().copyWith(
              icons: VideoPlayerIconTheme().copyWith(error: Icons.warning),
              overlays: VideoPlayerOverlayTheme().copyWith(
                backgroundColor: Colors.black,
                alpha: 150,
              ),
            ),
            playerUIVisibilityOptions: PlayerUIVisibilityOptions().copyWith(
              showMuteUnMuteButton: true,
              showFullScreenButton: true,
              useSafeAreaForBottomControls: true,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.toggleMute();
        },
        child: const Icon(Icons.volume_up),
      ),
    );
  }
}
