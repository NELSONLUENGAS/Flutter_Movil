class VideoPost {
  final String caption;
  final String url;
  final int likes;
  final int views;

  VideoPost({
    required this.caption,
    required this.url,
    this.likes = 0,
    this.views = 0,
  });
}
