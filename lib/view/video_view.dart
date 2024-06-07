import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http_vs_dio/view/video_item.dart';
import 'package:http_vs_dio/viewmodel/video_view_model.dart';
import 'package:provider/provider.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<String> videoUrls = [];
  Future<void> initialize = Future.value();
  String? savedFilePath;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  VideoViewModel videoViewModel = VideoViewModel();
  Future<void> loadVideos() async {
    await Provider.of<VideoViewModel>(context, listen: false).getVideos();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    videoViewModel = VideoViewModel();
    loadVideos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // setState(() {
    //   Provider.of<VideoViewModel>(context, listen: false).getVideos();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var video = Provider.of<VideoViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Shorts'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: video.videos.length,
        itemBuilder: (context, index) {
          return VideoItem(
            videoUrl: video.videos[index].submission.mediaUrl,
            imageUrl: video.videos[index].submission.thumbnail,
            title: video.videos[index].submission.title,
            description: video.videos[index].submission.description,
          );
        },
        onPageChanged: (index) {
          videoUrls.add(video.videos[index].submission.mediaUrl);

          // if (index + 1 < video.videos.length) {
          //   precacheImage(
          //     NetworkImage(video.videos[index + 1].submission.thumbnail),
          //     context,
          //   );
          // }
        },
      ),
    );
  }
}
