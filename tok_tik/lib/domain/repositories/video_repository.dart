import '../entities/video_post.dart';

abstract class VideoRepository {
  Future<List<VideoPost>>
  getTrendingVideos({
    required int page,
    required int limit,
  });

  Future<List<VideoPost>>
  getUserVideos({
    required String userId,
    required int page,
    required int limit,
  });

  Future<void> likeVideo(
    String videoId,
  );

  Future<void> unlikeVideo(
    String videoId,
  );

  Future<void> incrementViews(
    String videoId,
  );
}
