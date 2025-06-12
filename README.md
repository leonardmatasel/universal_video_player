
<h1 align="center">
  <img src="https://github.com/leonardmatasel/universal_video_player/blob/main/example/assets/logo_horizontal.png?raw=true" alt="universal_video_player" height="125"/>
</h1>

<p align="center">
  <strong>All-in-one Flutter video player – stream from YouTube, Vimeo, network, assets files</strong>
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


## Introduction

**universal_video_player** is a Flutter video player built on top of Flutter’s official `video_player` plugin. It supports YouTube (via `youtube_explode_dart`), network and asset videos.

🎨 Highly customizable — tweak UI, show/hide controls, and easily integrate your own widgets.  
🎮 The controller gives full control over video state and callbacks for smooth video management on mobile and web.

🎯 **Long-term goal:** to create a universal, flexible, and feature-rich video player that works flawlessly across all platforms and video sources, empowering developers with maximum control and customization options.

<br>

## Supported Platforms & Status

| Video Source Type | Android | iOS  |  Web  | Status        |
|-------------------|---------|------|-------|---------------|
| YouTube           |   ✅    |  ✅  |  ❌   | ✅ Supported  |
| Vimeo             |   ✅    |  ✅  |  ❌   | ✅ Supported  |
| Network           |   ✅    |  ✅  |  ✅   | ✅ Supported  |
| Asset             |   ✅    |  ✅  |  ✅   | ✅ Supported  |
| Twitch            |   -    |  -   |   -   | 🔜 Planned    |
| TikTok            |   -    |  -   |   -   | 🔜 Planned    |
| Dailymotion       |   -    |  -   |   -   | 🔜 Planned    |


<br>

## ✨ Features

- ✅ Play videos from:
  - YouTube (support for live and regular videos)
  - Vimeo (public)
  - Network video URLs
  - Flutter app assets
- 🎛 Customizable player UI (controls, theme, overlays, labels)
- 🔁 Autoplay, replay, mute/unmute, volume control
- ⏪ Seek bar & scrubbing
- 🖼 Thumbnail support (custom or auto-generated for YouTube and Vimeo)
- 🔊 Global playback & mute sync across players
- ⛶ Fullscreen player
- ⚙️ Custom error and loading widgets

<br>

## 🧪 Demo

<p align="center">
  <img src="https://github.com/leonardmatasel/universal_video_player/blob/main/example/assets/showcase.gif?raw=true" width="300"/>
</p>

## 🚀 Getting Started

### Installation

Check the latest version on: [![Pub Version](https://img.shields.io/pub/v/universal_video_player.svg)](https://pub.dev/packages/universal_video_player)

```yaml
dependencies:
  universal_video_player: <latest_version>
````


---

### 🛠️ Android Setup

In your Flutter project, open:

```
android/app/src/main/AndroidManifest.xml
```

```xml
<!-- Add inside <manifest> -->
<uses-permission android:name="android.permission.INTERNET"/>

<!-- Add inside <application> -->
<application
    android:usesCleartextTraffic="true"
    ... >
</application>
```

✅ The `INTERNET` permission is required for streaming videos.


⚠️ The `usesCleartextTraffic="true"` is only needed if you're using HTTP (not HTTPS) URLs.

---

### 🍎 iOS Setup

To allow video streaming over HTTP (especially for development or non-HTTPS sources), add the following to your `Info.plist` file:

```xml
<!-- ios/Runner/Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

<br>

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

<br>

## 🎯 Advanced Sync with `AnimatedBuilder`

If your UI does not automatically reflect changes to the controller's state (e.g. `isFullScreen`, widget updates), you can manually force re-rendering using `AnimatedBuilder`:

```dart
AnimatedBuilder(
  animation: Listenable.merge([
    controller, // listens to general controller changes
    controller.sharedPlayerNotifier, // listens to widget updates
  ]),
  builder: (context, _) {
    final player = controller.sharedPlayerNotifier.value;
    final shouldRender = isFullScreenDisplay == controller.isFullScreen;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: shouldRender ? (player ?? const SizedBox.shrink()) : const SizedBox.shrink(),
    );
  },
);
````

> 💡 Use this only if your app UI isn’t reflecting video controller state changes properly.

<br>

## 🧩 Example App

Check out the full [`example/`](https://github.com/newtaDev/fl_video_player/tree/master/example) app in the repo.

<br>

## 🔮 Future Developments

| Feature                      | Description                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| 📃 Playlist Support         | YouTube playlist playback and custom video URL lists                        |
| ⏩ Double Tap Seek           | Skip forward/backward by configurable duration                              |
| 📚 Side Command Bars          | Left and right customizable sidebars for placing user-defined widgets or controls.           |
| 🧭 Header Bar               | Custom header with title, channel info, and actions                         |
| 🖼 Picture-in-Picture (PiP) | Play video in floating overlay while multitasking                           |
| 📶 Quality Selection        | Switch between 360p, 720p, 1080p, etc. during playback                      |
| ⏱ Playback Speed Control   | Adjust speed: 0.5x, 1.5x, 2x, etc.                                           |
| 🔁 Looping / Repeat         | Loop a single video or an entire playlist                                   |
| ♿ Accessibility             | Screen reader support, keyboard nav, captions, ARIA, high contrast, etc.   |
| ⬇️ Download / Offline Mode | Save videos temporarily for offline playback                                |
| 📺 Chromecast & AirPlay     | Stream to external devices like TVs or smart displays                       |
| 🔒 Parental Controls        | Restrict age-inappropriate or sensitive content                             |
| ⚙️ Settings Button          | Easily access and configure playback preferences                            |

<br>

## 📄 License

BSD 3-Clause License – see [LICENSE](LICENSE)
