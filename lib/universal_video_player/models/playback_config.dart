import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player/models/video_source_type.dart';

/// Configuration object used to initialize video playback.
///
/// Depending on the [videoSourceType], provide:
///
/// - [videoUrl] → for YouTube or network videos.
/// - [videoId] → for Vimeo.
/// - [videoDataSource] → for asset or local file.
///
/// ⚠️ **Rules:**
/// - Provide **only one** among [videoUrl], [videoId], or [videoDataSource].
/// - `videoId` is only for Vimeo.
/// - `videoUrl` is for YouTube or network streams.
/// - `videoDataSource` is for assets or local files.
///
/// ---
///
/// ### Examples:
///
/// **Vimeo**
/// ```dart
/// PlaybackConfig(
///   videoId: "123456789",
///   videoSourceType: VideoSourceType.vimeo,
/// )
/// ```
///
/// **YouTube**
/// ```dart
/// PlaybackConfig(
///   videoUrl: Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
///   videoSourceType: VideoSourceType.youtube,
/// )
/// ```
///
/// **Network**
/// ```dart
/// PlaybackConfig(
///   videoUrl: Uri.parse("https://example.com/video.mp4"),
///   videoSourceType: VideoSourceType.network,
/// )
/// ```
///
/// **Asset**
/// ```dart
/// PlaybackConfig(
///   videoDataSource: 'assets/videos/video.mp4',
///   videoSourceType: VideoSourceType.asset,
/// )
/// ```
@immutable
class PlaybackConfig {
  /// The video URL (for YouTube or network-based videos).
  final Uri? videoUrl;

  /// The video ID (for Vimeo).
  final String? videoId;

  /// The asset or file path.
  final String? videoDataSource;

  /// Defines the source type.
  final VideoSourceType videoSourceType;

  /// Whether playback should auto-start.
  final bool autoPlay;

  /// Start position.
  final Duration initialPosition;

  /// Initial volume (0.0 to 1.0).
  final double initialVolume;

  /// Whether to start playback muted.
  final bool autoMuteOnStart;

  /// Preferred quality levels.
  final List<int> preferredQualities;

  /// Whether user can seek.
  final bool allowSeeking;

  /// Max wait time before considering playback failed.
  final Duration timeoutDuration;

  PlaybackConfig({
    this.videoUrl,
    this.videoId,
    this.videoDataSource,
    required this.videoSourceType,
    this.autoPlay = false,
    this.initialPosition = Duration.zero,
    this.initialVolume = 1.0,
    this.autoMuteOnStart = false,
    this.preferredQualities = const [720],
    this.allowSeeking = true,
    this.timeoutDuration = const Duration(seconds: 30),
  }) : assert(
         _validateSource(videoUrl, videoId, videoDataSource, videoSourceType),
         'Invalid config:\n'
         '- Vimeo → use videoId\n'
         '- YouTube / Network → use videoUrl\n'
         '- Asset / File → use videoDataSource\n'
         'Provide only the appropriate field for the selected source type.',
       );

  static bool _validateSource(
    Uri? url,
    String? id,
    String? dataSource,
    VideoSourceType type,
  ) {
    switch (type) {
      case VideoSourceType.vimeo:
        return id != null && url == null && dataSource == null;
      case VideoSourceType.youtube:
      case VideoSourceType.network:
        return url != null && id == null && dataSource == null;
      case VideoSourceType.asset:
        return dataSource != null && url == null && id == null;
    }
  }

  PlaybackConfig copyWith({
    Uri? videoUrl,
    String? videoId,
    String? videoDataSource,
    VideoSourceType? videoSourceType,
    bool? autoPlay,
    Duration? initialPosition,
    double? initialVolume,
    bool? autoMuteOnStart,
    List<int>? preferredQualities,
    bool? allowSeeking,
    Duration? timeoutDuration,
  }) {
    return PlaybackConfig(
      videoUrl: videoUrl ?? this.videoUrl,
      videoId: videoId ?? this.videoId,
      videoDataSource: videoDataSource ?? this.videoDataSource,
      videoSourceType: videoSourceType ?? this.videoSourceType,
      autoPlay: autoPlay ?? this.autoPlay,
      initialPosition: initialPosition ?? this.initialPosition,
      initialVolume: initialVolume ?? this.initialVolume,
      autoMuteOnStart: autoMuteOnStart ?? this.autoMuteOnStart,
      preferredQualities: preferredQualities ?? this.preferredQualities,
      allowSeeking: allowSeeking ?? this.allowSeeking,
      timeoutDuration: timeoutDuration ?? this.timeoutDuration,
    );
  }
}
