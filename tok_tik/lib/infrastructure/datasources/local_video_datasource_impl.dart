import 'package:tok_tik/domain/datasources/video_post_datasource.dart';
import 'package:tok_tik/domain/entities/video_post.dart';
import 'package:tok_tik/infrastructure/models/local_video_model.dart';
import 'package:tok_tik/shared/data/local_video_post.dart';

class LocalVideoDatasourceImpl
    implements VideoPostDatasource {
  @override
  Future<List<VideoPost>>
  getFavoriteVideosByUser(int userID) {
    // TODO: implement getFavoriteVideosByUser
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>>
  getTrendingVideosByPage(
    int page,
  ) async {
    final List<VideoPost>
    newVideos = videoPosts.map((video) {
      return LocalVideoModel.fromJson(
        video,
      ).toVideoPostEntity();
    }).toList();

    await Future.delayed(
      Duration(seconds: 2),
    );

    return newVideos;
  }
}
