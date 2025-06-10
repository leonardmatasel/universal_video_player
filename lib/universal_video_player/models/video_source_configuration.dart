import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player/models/video_source_type.dart';

/// Configuration object used to initialize video playback.
///
/// Depending on the [videoSourceType], provide exactly one of:
///
/// - [videoUrl] → for YouTube or network videos.
/// - [videoId] → for Vimeo videos.
/// - [videoDataSource] → for asset or local file videos.
///
/// ⚠️ **Rules:**
/// - Provide **only one** of [videoUrl], [videoId], or [videoDataSource].
/// - [videoId] is only valid for Vimeo.
/// - [videoUrl] is valid for YouTube and network streams.
/// - [videoDataSource] is valid for assets or local files.
///
/// ---
///
/// ### Examples:
///
/// **Vimeo**
/// ```dart
/// VideoSourceConfiguration(
///   videoId: "123456789",
///   videoSourceType: VideoSourceType.vimeo,
/// )
/// ```
///
/// **YouTube**
/// ```dart
/// VideoSourceConfiguration(
///   videoUrl: Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
///   videoSourceType: VideoSourceType.youtube,
/// )
/// ```
///
/// **Network**
/// ```dart
/// VideoSourceConfiguration(
///   videoUrl: Uri.parse("https://example.com/video.mp4"),
///   videoSourceType: VideoSourceType.network,
/// )
/// ```
///
/// **Asset**
/// ```dart
/// VideoSourceConfiguration(
///   videoDataSource: 'assets/videos/video.mp4',
///   videoSourceType: VideoSourceType.asset,
/// )
/// ```
@immutable
class VideoSourceConfiguration {
  /// The video URL (for YouTube or network-based videos).
  final Uri? videoUrl;

  /// The video ID (only for Vimeo videos).
  final String? videoId;

  /// The asset or file path (for asset or local file videos).
  final String? videoDataSource;

  /// Defines the source type, must match the appropriate data source field.
  final VideoSourceType videoSourceType;

  /// Whether playback should start automatically.
  final bool autoPlay;

  /// The initial playback position.
  final Duration initialPosition;

  /// Initial volume level (range 0.0 to 1.0).
  final double initialVolume;

  /// Whether playback should start muted.
  final bool autoMuteOnStart;

  /// Preferred video quality levels in order of preference.
  final List<int> preferredQualities;

  /// Whether the user is allowed to seek the video.
  final bool allowSeeking;

  /// Maximum wait time before considering playback failed.
  final Duration timeoutDuration;

  /// Creates a new video source configuration with validation based on source type.
  VideoSourceConfiguration({
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
         'Invalid configuration:\n'
         '- Vimeo → use videoId only\n'
         '- YouTube / Network → use videoUrl only\n'
         '- Asset / File → use videoDataSource only\n'
         'Please provide only the appropriate field for the selected source type.',
       );

  /// Internal helper to validate that only the correct data source field is set.
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

  /// Returns a new instance of [VideoSourceConfiguration] with updated fields.
  ///
  /// All parameters are optional and default to current instance values if null.
  VideoSourceConfiguration copyWith({
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
    return VideoSourceConfiguration(
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
