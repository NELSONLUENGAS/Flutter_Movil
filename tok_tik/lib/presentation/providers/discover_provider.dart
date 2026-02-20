import 'package:flutter/material.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/domain/repositories/video_post_repository.dart';

class DiscoverProvider
    extends ChangeNotifier {
  final VideoPostRepository
  videoPostRepository;
  bool initialLoading = true;
  List<VideoPost> videos = [];

  DiscoverProvider({
    required this.videoPostRepository,
  });

  Future<void> loadNextPage({
    int page = 1,
  }) async {
    final newVideos =
        await videoPostRepository
            .getTrendingVideosByPage(
              page,
            );

    videos.addAll(newVideos);
    initialLoading = false;
    notifyListeners();
  }
}
