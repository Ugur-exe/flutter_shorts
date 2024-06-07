import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String videoUrl;
  final String imageUrl;
  final String title;
  final String description;
  const VideoItem(
      {super.key,
      required this.videoUrl,
      required this.imageUrl,
      required this.title,
      required this.description});

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  bool showIcon = false;
  late VideoPlayerController _controller;
  bool isInitializing = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setLooping(false);
        isInitializing = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool startedPlaying = false;
  Future<bool> started() async {
    await _controller.initialize();
    await _controller.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
          setState(() {
            showIcon = true;
          });
        } else {
          _controller.play();
          setState(() {
            showIcon = true;
          });
          Timer(const Duration(seconds: 1), () {
            if (_controller.value.isPlaying) {
              setState(() {
                showIcon = false;
              });
            }
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: isInitializing
                ? Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  )
                : AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
            ),
          ),
          Positioned(
              bottom: 20,
              right: 10,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              )),
          Positioned(
            bottom: 60,
            left: 20,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: 12,
              bottom: 320,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up,
                        color: Colors.white, size: 30),
                  ),
                  const Text(
                    '818 K',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
          Positioned(
              right: 12,
              bottom: 250,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_down,
                        color: Colors.white, size: 30),
                  ),
                  const Text(
                    'Disslike',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
          Positioned(
              right: 12,
              bottom: 180,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.comment, color: Colors.white, size: 30),
                  ),
                  Text('818', style: const TextStyle(color: Colors.white)),
                ],
              )),
          Positioned(
              right: 12,
              bottom: 100,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send, color: Colors.white, size: 30),
                  ),
                  Text('Share', style: const TextStyle(color: Colors.white)),
                ],
              )),
          Positioned(
            bottom: 15,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 80,
              ),
              child: Text(
                widget.description,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (showIcon)
            Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 64.0,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
