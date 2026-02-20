import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/presentation/widgets/shared/video_buttons.dart';
import 'package:tok_tik/presentation/widgets/video/fullscreen_player/fullscreen_player.dart';

class VideoScrollableView
    extends StatefulWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({
    super.key,
    required this.videos,
  });

  @override
  State<VideoScrollableView>
  createState() =>
      _VideoScrollableViewState();
}

class _VideoScrollableViewState
    extends State<VideoScrollableView> {
  final PageController _pageController =
      PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(),
      itemCount: widget.videos.length,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        final videoPost =
            widget.videos[index];

        return Stack(
          children: [
            SizedBox.expand(
              child:
                  FullScreenPlayer.asset(
                    assetPath:
                        videoPost.url,
                    caption: videoPost
                        .caption,
                    isActive:
                        index ==
                        currentPage,
                  ),
            ),
            const Positioned(
              bottom: 20,
              right: 10,
              child: VideoButtons(),
            ),
          ],
        );
      },
    );
  }
}
