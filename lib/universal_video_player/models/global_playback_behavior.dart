import 'package:flutter/material.dart';

@immutable
class GlobalPlaybackBehavior {
  /// Whether to use a global playback controller to ensure exclusive video playback.
  ///
  /// When enabled, only one video can play at a time across the app.
  /// Playing a new video automatically pauses any currently playing video.
  ///
  /// Useful for feed-like interfaces (e.g., stories, reels).
  final bool useGlobalPlaybackController;

  /// Whether to synchronize mute state across all video players.
  ///
  /// When enabled, muting or unmuting one video will apply the same mute state
  /// to all other players using the global controller.
  ///
  /// **Note:** This option requires [useGlobalPlaybackController] to be `true`
  /// in order to function correctly.
  ///
  /// Useful when a consistent audio experience is required across videos.
  final bool synchronizeMuteAcrossPlayers;

  const GlobalPlaybackBehavior({
    this.useGlobalPlaybackController = true,
    this.synchronizeMuteAcrossPlayers = true,
  });

  /// Returns a new [GlobalPlaybackBehavior] with the specified fields overridden.
  ///
  /// @param useGlobalPlaybackController See [GlobalPlaybackBehavior.useGlobalPlaybackController].
  /// @param synchronizeMuteAcrossPlayers See [GlobalPlaybackBehavior.synchronizeMuteAcrossPlayers].
  GlobalPlaybackBehavior copyWith({
    bool? useGlobalPlaybackController,
    bool? synchronizeMuteAcrossPlayers,
  }) {
    return GlobalPlaybackBehavior(
      useGlobalPlaybackController:
          useGlobalPlaybackController ?? this.useGlobalPlaybackController,
      synchronizeMuteAcrossPlayers:
          synchronizeMuteAcrossPlayers ?? this.synchronizeMuteAcrossPlayers,
    );
  }
}
