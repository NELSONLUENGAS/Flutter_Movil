import 'package:flutter/material.dart';
import 'package:tok_tik/presentation/widgets/video/fullscreen_player/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer
    extends StatefulWidget {
  final String videoSource;
  final String caption;
  final bool isAsset;
  final bool isActive;
  final Map<String, String>?
  httpHeaders;
  final bool autoPlay;
  final bool looping;

  const FullScreenPlayer({
    super.key,
    required this.videoSource,
    required this.caption,
    this.isAsset = false,
    this.httpHeaders,
    this.autoPlay = true,
    this.isActive = false,
    this.looping = true,
  });

  factory FullScreenPlayer.network({
    Key? key,
    required String videoUrl,
    required String caption,
    Map<String, String>? httpHeaders,
    bool autoPlay = true,
    bool looping = true,
    bool isActive = false,
  }) {
    return FullScreenPlayer(
      key: key,
      videoSource: videoUrl,
      caption: caption,
      httpHeaders: httpHeaders,
      autoPlay: autoPlay,
      isActive: isActive,
      looping: looping,
    );
  }

  factory FullScreenPlayer.asset({
    Key? key,
    required String assetPath,
    required String caption,
    bool autoPlay = true,
    bool looping = true,
    bool isActive = false,
  }) {
    return FullScreenPlayer(
      key: key,
      videoSource: assetPath,
      caption: caption,
      isAsset: true,
      isActive: isActive,
      autoPlay: autoPlay,
      looping: looping,
    );
  }

  @override
  State<FullScreenPlayer>
  createState() =>
      _FullScreenPlayerState();
}

class _FullScreenPlayerState
    extends State<FullScreenPlayer> {
  late final VideoPlayerController
  _controller;
  bool _initialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void didUpdateWidget(
    covariant FullScreenPlayer
    oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (!_initialized) return;

    if (widget.isActive) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  Future<void> _initVideo() async {
    try {
      _controller = widget.isAsset
          ? VideoPlayerController.asset(
              widget.videoSource,
            )
          : VideoPlayerController.networkUrl(
              Uri.parse(
                widget.videoSource,
              ),
              httpHeaders:
                  widget.httpHeaders ??
                  const {},
            );

      await _controller.initialize();

      await _controller.setVolume(0);
      await _controller.setLooping(
        widget.looping,
      );

      if (widget.autoPlay &&
          widget.isActive) {
        await _controller.play();
      }

      if (mounted) {
        setState(
          () => _initialized = true,
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _hasError = true,
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    _controller.value.isPlaying
        ? _controller.pause()
        : _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Icon(
          Icons.error_outline,
          size: 40,
        ),
      );
    }

    if (!_initialized) {
      return const Center(
        child:
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
      );
    }

    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(_controller),

          VideoBackground(
            stops: [0.7, 1.0],
          ),

          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: _VideoCaption(
              caption: widget.caption,
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCaption
    extends StatelessWidget {
  final String caption;

  const _VideoCaption({
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          MediaQuery.of(
            context,
          ).size.width *
          0.6,
      child: Text(
        caption,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.titleLarge,
      ),
    );
  }
}
