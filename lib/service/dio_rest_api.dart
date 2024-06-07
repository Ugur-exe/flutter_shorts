import 'package:http_vs_dio/model/model.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchVideos() async {
  const baseUrl = "https://internship-service.onrender.com/videos";
  int currentPage = 0;
  int limit = 10;
  final Uri uri = Uri.parse("$baseUrl?page=$currentPage&limit=$limit");

  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final result = welcomeFromJson(response.body);
    print(result.data.posts);
    return result.data.posts;
  } else {
    print('Failed to load videos');
    throw Exception('Failed to load videos');
  }
}
