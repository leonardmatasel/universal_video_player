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
/// ### Factory Constructors:
///
/// **Vimeo**
/// ```dart
/// VideoSourceConfiguration.vimeo(
///   videoId: "123456789",
/// )
/// ```
///
/// **YouTube**
/// ```dart
/// VideoSourceConfiguration.youtube(
///   videoUrl: Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
/// )
/// ```
///
/// **Network**
/// ```dart
/// VideoSourceConfiguration.network(
///   videoUrl: Uri.parse("https://example.com/video.mp4"),
/// )
/// ```
///
/// **Asset**
/// ```dart
/// VideoSourceConfiguration.asset(
///   videoDataSource: 'assets/videos/video.mp4',
/// )
/// ```
///
/// ---
///
/// ### Common playback options (modifiable with [copyWith]):
///
/// - [autoPlay]: Whether playback should start automatically (default: false).
/// - [initialPosition]: The initial playback position (default: Duration.zero).
/// - [initialVolume]: Initial volume level between 0.0 and 1.0 (default: 1.0).
/// - [autoMuteOnStart]: Whether playback should start muted (default: false).
/// - [preferredQualities]: Preferred video quality levels (default: [720]).
/// - [allowSeeking]: Whether seeking is allowed (default: true).
/// - [timeoutDuration]: Maximum wait time before considering playback failed (default: 30 seconds).
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
  ///
  /// Common values include:
  /// - 144 (144p, molto bassa qualità)
  /// - 240 (240p)
  /// - 360 (360p)
  /// - 480 (480p, qualità SD)
  /// - 720 (720p, HD)
  /// - 1080 (1080p, Full HD)
  /// - 1440 (1440p, 2K)
  /// - 2160 (2160p, 4K UHD)
  ///
  /// The player will try to select the best available quality from this list
  /// according to the order provided.
  final List<int> preferredQualities;

  /// Whether the user is allowed to seek the video.
  final bool allowSeeking;

  /// Maximum wait time before considering playback failed.
  final Duration timeoutDuration;

  /// Private constructor used by factory constructors and [copyWith].
  const VideoSourceConfiguration._({
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
  });

  /// Factory constructor for Vimeo videos.
  ///
  /// Example:
  /// ```dart
  /// VideoSourceConfiguration.vimeo(
  ///   videoId: "123456789",
  ///   preferredQualities: [720, 480], // Optional
  /// )
  /// ```
  ///
  /// - [videoId]: the numeric ID from a Vimeo URL (e.g., https://vimeo.com/123456789).
  /// - [preferredQualities]: optional list of preferred video resolutions.
  ///   Only used for Vimeo sources. Default is [480].
  factory VideoSourceConfiguration.vimeo({
    required String videoId,
    List<int> preferredQualities = const [480],
  }) {
    return VideoSourceConfiguration._(
      videoId: videoId,
      videoSourceType: VideoSourceType.vimeo,
      preferredQualities: preferredQualities,
    );
  }

  /// Factory constructor for YouTube videos.
  ///
  /// Example:
  /// ```dart
  /// VideoSourceConfiguration.youtube(
  ///   videoUrl: Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ"),
  ///   preferredQualities: [1080, 720], // Optional
  /// )
  /// ```
  ///
  /// - [videoUrl]: the full URL of a YouTube video.
  /// - [preferredQualities]: optional list of preferred video resolutions.
  ///   Only used for YouTube sources. Default is [480].
  factory VideoSourceConfiguration.youtube({
    required Uri videoUrl,
    List<int> preferredQualities = const [480],
  }) {
    return VideoSourceConfiguration._(
      videoUrl: videoUrl,
      videoSourceType: VideoSourceType.youtube,
      preferredQualities: preferredQualities,
    );
  }

  /// Factory constructor for network videos.
  ///
  /// Requires a [videoUrl].
  factory VideoSourceConfiguration.network({required Uri videoUrl}) {
    return VideoSourceConfiguration._(
      videoUrl: videoUrl,
      videoSourceType: VideoSourceType.network,
    );
  }

  /// Factory constructor for asset or local file videos.
  ///
  /// Requires a [videoDataSource].
  factory VideoSourceConfiguration.asset({required String videoDataSource}) {
    return VideoSourceConfiguration._(
      videoDataSource: videoDataSource,
      videoSourceType: VideoSourceType.asset,
    );
  }

  /// Returns a new instance of [VideoSourceConfiguration] with updated common playback fields.
  ///
  /// The parameters that distinguish the video source ([videoUrl], [videoId], [videoDataSource], [videoSourceType])
  /// **cannot be modified** here to maintain consistency.
  VideoSourceConfiguration copyWith({
    bool? autoPlay,
    Duration? initialPosition,
    double? initialVolume,
    bool? autoMuteOnStart,
    bool? allowSeeking,
    Duration? timeoutDuration,
  }) {
    return VideoSourceConfiguration._(
      videoUrl: videoUrl,
      videoId: videoId,
      videoDataSource: videoDataSource,
      videoSourceType: videoSourceType,
      autoPlay: autoPlay ?? this.autoPlay,
      initialPosition: initialPosition ?? this.initialPosition,
      initialVolume: initialVolume ?? this.initialVolume,
      autoMuteOnStart: autoMuteOnStart ?? this.autoMuteOnStart,
      preferredQualities: preferredQualities,
      allowSeeking: allowSeeking ?? this.allowSeeking,
      timeoutDuration: timeoutDuration ?? this.timeoutDuration,
    );
  }
}
