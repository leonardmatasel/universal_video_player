<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

## Future Developments
# Playlist Support
Support for YouTube playlists and custom playlists with a series of video URLs.

# Double Tap Seek
Double tap gestures to skip forward or backward by configurable seconds.

# Header Bar
A customizable header bar to show video title, channel info, or action buttons.

# Picture-in-Picture Mode (PiP)
Allow the video to continue playing in a small overlay window while user navigates away.

# Video Quality Selection
Let users switch between multiple video qualities (360p, 720p, 1080p, etc.).

# Playback Speed Control
Allow users to adjust playback speed (0.5x, 1.5x, 2x, etc.).

# Video Looping / Repeat
Option to loop a video or a playlist.

# Accessibility Enhancements
Implement accessibility features such as keyboard navigation, screen reader support (ARIA labels), captions/subtitles, high contrast mode, and support for users with visual, auditory, or motor impairments.

# Download/Offline Mode (where permitted)
Allow users to temporarily download videos for offline viewing.

# Chromecast & AirPlay Support
Enable streaming to external devices such as Chromecast or AirPlay-enabled displays.

# Parental Control / Restrictions
Implement filters to restrict access to sensitive or age-inappropriate content, ensuring a safer viewing experience for younger audiences.

# Settings Button
Include a dedicated settings button to allow users to easily access and customize preferences.

# Support for these platforms is planned and will be added in future updates:

YouTube ✅ (already supported)
Vimeo (planned)
Twitch (planned)
TikTok (planned)
Dailymotion (planned)

# per essere sicuro che risponde ai cambiamenti del controller usa:
```dart
AnimatedBuilder(
animation: Listenable.merge([
controller,
// ascolta isFullScreen o altri state update
controller.sharedPlayerNotifier,
// ascolta il cambiamento del widget video
]),
builder: (context, _) {
final player = controller.sharedPlayerNotifier.value;

        final shouldRender = isFullScreenDisplay == controller.isFullScreen;

        return Center(
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child:
                shouldRender
                    ? (player ?? const SizedBox.shrink())
                    : const SizedBox.shrink(),
          ),
        );
      },
    );
```# universal_video_player
