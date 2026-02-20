import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tok_tik/config/theme/app_theme.dart';
import 'package:tok_tik/domain/datasources/video_post_datasource.dart';
import 'package:tok_tik/infrastructure/datasources/local_video_datasource_impl.dart';
import 'package:tok_tik/infrastructure/repositories/video_post_repository_impl.dart';
import 'package:tok_tik/presentation/providers/discover_provider.dart';
import 'package:tok_tik/presentation/screens/discover/discover_screen.dart';
import 'package:fvp/fvp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerWith();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository =
        VideoPostRepositoryImpl(
          videosDatasource:
              LocalVideoDatasourceImpl(),
        );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) =>
              DiscoverProvider(
                videoPostRepository:
                    videoPostRepository,
              )..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Tok Tik',
        debugShowCheckedModeBanner:
            false,
        theme: AppTheme().theme,
        home: const DiscoverScreen(),
      ),
    );
  }
}
