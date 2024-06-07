import 'package:flutter/material.dart';
import 'package:http_vs_dio/model/model.dart';
import 'package:http_vs_dio/service/dio_rest_api.dart';

class VideoViewModel extends ChangeNotifier {
  List<Post> _videos = [];
  List<Post> get videos => _videos;
  set videos(List<Post> videos) {
    _videos = videos;
    notifyListeners();
  }

  String? _errorMessage;
  

  Future<void> getVideos() async {
    try {
      _videos = await fetchVideos();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch videos: $e';
      notifyListeners();
    }
  }
}
