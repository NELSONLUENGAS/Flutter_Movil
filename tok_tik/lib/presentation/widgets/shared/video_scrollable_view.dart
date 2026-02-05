import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/presentation/widgets/shared/video_buttons.dart';
import 'package:tok_tik/presentation/widgets/video/fullscreen_player/fullscreen_player.dart';

class VideoScrollableView
    extends StatelessWidget {
  final List<VideoPost> videos;
  const VideoScrollableView({
    super.key,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics:
          const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final videoPost = videos[index];

        return Stack(
          children: [
            SizedBox.expand(
              child:
                  FullScreenPlayer.asset(
                    assetPath:
                        videoPost.url,
                    caption: videoPost
                        .caption,
                  ),
            ),
            Positioned(
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
