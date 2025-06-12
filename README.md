
<h1 align="center">
  <img src="https://user-images.githubusercontent.com/85326522/159757765-db86f850-fea8-4dc2-bd86-0a27648b24e5.png" alt="universal_video_player" width="200"/>
</h1>

<p align="center">
  <strong>Universal video player for Flutter – supporting YouTube, Vimeo, network streams, assets, and local files.</strong>
</p>

<p align="center">
  <a href="https://pub.dev/packages/universal_video_player">
    <img src="https://img.shields.io/pub/v/universal_video_player.svg" alt="pub version">
  </a>
  <a href="https://pub.dev/packages/universal_video_player/score">
    <img src="https://img.shields.io/pub/points/universal_video_player" alt="pub points">
  </a>
  <a href="https://pub.dev/packages/universal_video_player/score">
    <img src="https://img.shields.io/badge/popularity-high-brightgreen" alt="pub popularity">
  </a>
</p>

---

## ✅ Supported Video Types by Platform

| Video Source Type | Android | iOS | Web  |
|-------------------|---------|-----|------|
| YouTube           |   ✅    |  ✅  |  ❌   |
| Vimeo             |   ✅    |  ✅  |  ❌   |
| Network           |   ✅    |  ✅  |  ✅   |
| Asset             |   ✅    |  ✅  |  ✅   |

---

## ✨ Features

- ✅ Play videos from:
  - YouTube (support for live and regular videos)
  - Vimeo (public, private, and hashed videos)
  - Network video URLs
  - Flutter app assets
- 🎛 Customizable player UI (controls, theme, overlays, labels)
- 🔁 Autoplay, replay, mute/unmute, volume control
- ⏪ Seek bar & scrubbing
- 🖼 Thumbnail support (custom or auto-generated for YouTube and Vimeo)
- 🔊 Global playback & mute sync across players
- ⛶ Native fullscreen player
- ⚙️ Custom error and loading widgets

---

## 🧪 Demo

![](https://github.com/leonardmatasel/universal_video_player/blob/main/example/assets/showcase.gif?raw=true) 

## 🚀 Getting Started

### Installation

```yaml
dependencies:
  universal_video_player: <latest_version>
````

---

### Android Setup

```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET"/>
<application android:usesCleartextTraffic="true">
</application>
```

---

### iOS Setup

```xml
<!-- Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

## 📦 Usage Examples

### Basic Network Video

```dart
controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.network('https://example.com/video.mp4'),
)..initialise();
```

### YouTube Video

```dart
controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/A3ltMaM6noM'),
)..initialise();
```

### Vimeo Video

```dart
controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.vimeo('518228118'),
)..initialise();
```

### Vimeo with Hash

```dart
controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.vimeo('518228118', hash: '7cc595e1f8'),
)..initialise();
```

### Vimeo Private Video

```dart
final headers = {'Authorization': 'Bearer YOUR_TOKEN'};

controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.vimeoPrivateVideos(
    'YOUR_VIDEO_ID',
    httpHeaders: headers,
  ),
)..initialise();
```

---

### With Custom Config

```dart
controller = PodPlayerController(
  playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/xyz'),
  podPlayerConfig: const PodPlayerConfig(
    autoPlay: true,
    isLooping: false,
    videoQualityPriority: [720, 360],
  ),
)..initialise();
```

---

### Add Thumbnail

```dart
PodVideoPlayer(
  controller: controller,
  videoThumbnail: DecorationImage(
    image: NetworkImage('https://example.com/thumbnail.jpg'),
    fit: BoxFit.cover,
  ),
)
```

---

### Custom Labels

```dart
PodVideoPlayer(
  controller: controller,
  podPlayerLabels: const PodPlayerLabels(
    play: "Play video",
    pause: "Pause video",
    mute: "Silence",
    unMute: "Unmute",
  ),
)
```

---

## 🎯 Advanced Integration with AnimatedBuilder

To ensure full sync with internal state updates like `isFullScreen`, use:

```dart
AnimatedBuilder(
  animation: Listenable.merge([
    controller,
    controller.sharedPlayerNotifier,
  ]),
  builder: (context, _) {
    final player = controller.sharedPlayerNotifier.value;
    final shouldRender = isFullScreenDisplay == controller.isFullScreen;

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: shouldRender ? (player ?? const SizedBox.shrink()) : const SizedBox.shrink(),
      ),
    );
  },
);
```

---

## 🧩 Example App

Check out the full [`example/`](https://github.com/newtaDev/fl_video_player/tree/master/example) app in the repo.

---

## 🔮 Future Developments

### 📃 Playlist Support

* YouTube playlist playback
* Custom playlist of video URLs

### ⏩ Double Tap Seek

* Skip forward/backward by configurable duration

### 🧭 Header Bar

* Title, channel name, and action buttons

### 🖼 Picture-in-Picture Mode (PiP)

* Continue video in floating overlay window

### 📶 Video Quality Selection change during playing

* Let users choose between 360p, 720p, 1080p etc.

### ⏱ Playback Speed Control

* Change speed to 0.5x, 1.5x, 2x, etc.

### 🔁 Video Looping / Repeat

* Loop single video or full playlist

### ♿ Accessibility Enhancements

* Screen readers, keyboard navigation, ARIA, captions, high contrast, etc.

### ⬇️ Download / Offline Mode

* Save videos for temporary offline playback

### 📺 Chromecast & AirPlay Support

* Stream video to external displays

### 🔒 Parental Controls

* Filter sensitive or age-restricted content

### ⚙️ Settings Button

* Quick access to all playback preferences

---

### 🔧 Upcoming Platform Support

| Platform    | Status      |
| ----------- | ----------- |
| YouTube     | ✅ Supported |
| Vimeo       | ✅ Supported  |
| Twitch      | 🔜 Planned  |
| TikTok      | 🔜 Planned  |
| Dailymotion | 🔜 Planned  |

---

## 📄 License

BSD 3-Clause License – see [LICENSE](LICENSE)
