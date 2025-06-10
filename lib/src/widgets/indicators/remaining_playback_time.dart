import 'package:flutter/material.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';

/// A widget that displays the remaining time of a video in `HH:MM:SS` or `MM:SS` format.
///
/// [RemainingPlaybackTime] is typically shown in the video player UI to indicate
/// how much time is left before the video ends.
class RemainingPlaybackTime extends StatelessWidget {
  /// Creates a widget to display the remaining video duration.
  const RemainingPlaybackTime({super.key, required this.duration});

  /// The remaining time to be displayed.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final theme = UniversalVideoPlayerTheme.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        _formatDuration(duration),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: theme.textColor?.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  /// Converts a [Duration] into a string like `HH:MM:SS` or `MM:SS`.
  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    if (hours > 0) {
      return '${hours.toTwoDigits()}:${minutes.toTwoDigits()}:${seconds.toTwoDigits()}';
    } else {
      return '${minutes.toTwoDigits()}:${seconds.toTwoDigits()}';
    }
  }
}

/// Extension method for formatting numbers as two-digit strings.
extension on int {
  String toTwoDigits() => this > 9 ? '$this' : '0$this';
}
