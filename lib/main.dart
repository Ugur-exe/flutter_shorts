import 'package:flutter/material.dart';
import 'package:http_vs_dio/service/dio_rest_api.dart';
import 'package:http_vs_dio/view/video_view.dart';
import 'package:http_vs_dio/viewmodel/video_view_model.dart';

import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    fetchVideos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoViewModel()),
      ],
      child: const MaterialApp(
          // initialRoute: '/bottomNavigationBar',
          // routes: {
          //   '/': (context) => const HomeView(),
          //   '/videoView': (context) => const VideoView(),
          //   '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
          // },
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: VideoView(),
          )),
    );
  }
}
