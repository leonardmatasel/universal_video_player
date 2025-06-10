import 'package:flutter/material.dart';
import 'package:universal_video_player/src/navigation/route_aware_listener.dart';
import 'package:universal_video_player/src/widgets/adaptive_video_player_display.dart';
import 'package:universal_video_player/src/widgets/fade_overlay_switcher.dart';
import 'package:universal_video_player/src/widgets/player/video_player_thumbnail_preview.dart';
import 'package:universal_video_player/src/widgets/video_overlay_controls.dart';
import 'package:universal_video_player/universal_video_player/controllers/universal_playback_controller.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_callbacks.dart';
import 'package:universal_video_player/universal_video_player/models/video_player_configuration.dart';
import 'package:universal_video_player/universal_video_player/theme/universal_video_player_theme.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A comprehensive video player widget that manages video rendering,
/// overlay controls, visibility detection, and thumbnail preview.
///
/// This widget combines multiple functionalities:
/// - Displays a blurred circular background overlay with configurable color and opacity.
/// - Shows adaptive video player display for responsive video rendering.
/// - Integrates overlay controls for playback interaction.
/// - Detects widget visibility to automatically pause playback when the video is out of view.
/// - Displays video thumbnail preview at the start or end of playback based on configuration.
///
/// This widget is designed to be used within apps that require
/// full-featured video playback with smooth transitions and state management.
class VideoPlayerRenderer extends StatefulWidget {
  /// Configuration options for the video player (theme, thumbnail, behavior).
  final VideoPlayerConfiguration options;

  /// Callback handlers for video player events.
  final VideoPlayerCallbacks callbacks;

  /// Controller managing video playback state and commands.
  final UniversalPlaybackController controller;

  const VideoPlayerRenderer({
    super.key,
    required this.controller,
    required this.options,
    required this.callbacks,
  });

  @override
  VideoPlayerRendererState createState() => VideoPlayerRendererState();
}

class VideoPlayerRendererState extends State<VideoPlayerRenderer> {
  @override
  Widget build(BuildContext context) {
    final theme = UniversalVideoPlayerTheme.of(context)!;

    return VideoOverlayControls(
      controller: widget.controller,
      options: widget.options,
      callbacks: widget.callbacks,
      child: Stack(
        children: [
          // Blurred circular background overlay
          if (theme.overlays.backgroundColor != null &&
              theme.overlays.alpha != null)
            Positioned.fill(
              child:
                  widget.options.enableBackgroundOverlayClip == true
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                          theme.shapes.borderRadius,
                        ),
                        child: MovingBlurredCircleBackground(
                          color:
                              widget
                                  .options
                                  .playerTheme
                                  .overlays
                                  .backgroundColor!,
                          alpha: theme.overlays.alpha!,
                        ),
                      )
                      : MovingBlurredCircleBackground(
                        color:
                            widget
                                .options
                                .playerTheme
                                .overlays
                                .backgroundColor!,
                        alpha: theme.overlays.alpha!,
                      ),
            ),
          // Video player with fade transition and visibility detection
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(theme.shapes.borderRadius),
              child: FadeOverlaySwitcher(
                duration: const Duration(milliseconds: 400),
                child: VisibilityDetector(
                  key: Key(hashCode.toString()),
                  onVisibilityChanged: (visibilityInfo) {
                    // Automatically pause video when not visible and not fullscreen
                    if (visibilityInfo.visibleFraction == 0.0 &&
                        widget.controller.isPlaying &&
                        !widget.controller.isFullScreen) {
                      widget.controller.pause();
                    }
                  },
                  child: RouteAwareListener(
                    onPopNext: (route) {
                      // Optionally restore orientation or other state on returning to this route
                    },
                    child: AdaptiveVideoPlayerDisplay(
                      controller: widget.controller,
                      isFullScreenDisplay: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Conditionally show thumbnail preview at start or end of playback
          if (widget.options.customPlayerWidgets.thumbnail != null &&
              widget.options.playerUIVisibilityOptions.showThumbnailAtStart &&
              !widget.controller.hasStarted)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(theme.shapes.borderRadius),
                child: VideoPlayerThumbnailPreview(
                  imageProvider: widget.options.customPlayerWidgets.thumbnail!,
                  fit: widget.options.customPlayerWidgets.thumbnailFit,
                  backgroundColor: theme.colors.backgroundThumbnail,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Custom painter that draws a blurred circular overlay with configurable color and transparency.
class _BlurredCirclePainter extends CustomPainter {
  final Color color;
  final int alpha;
  final Offset center;

  _BlurredCirclePainter({
    required this.color,
    required this.alpha,
    required this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withAlpha(alpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    canvas.drawCircle(center, size.width * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant _BlurredCirclePainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.alpha != alpha ||
        oldDelegate.color != color;
  }
}

/// Widget that paints a moving blurred circle as a background effect.
class MovingBlurredCircleBackground extends StatefulWidget {
  final Color color;
  final int alpha;
  final Duration animationDuration;

  const MovingBlurredCircleBackground({
    super.key,
    this.color = Colors.red,
    this.alpha = 100,
    this.animationDuration = const Duration(seconds: 10),
  });

  @override
  State<MovingBlurredCircleBackground> createState() =>
      _MovingBlurredCircleBackgroundState();
}

class _MovingBlurredCircleBackgroundState
    extends State<MovingBlurredCircleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);

    // Animations for center X and Y to move the blurred circle smoothly
    _animationX = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationY = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final center = Offset(
              constraints.maxWidth * _animationX.value,
              constraints.maxHeight * _animationY.value,
            );
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: _BlurredCirclePainter(
                color: widget.color,
                alpha: widget.alpha,
                center: center,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
