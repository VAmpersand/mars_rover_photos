import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photo_from_the_rover/features/models/photo.dart';
import 'package:photo_from_the_rover/features/models/photo_manifest.dart';
import 'package:photo_from_the_rover/features/models/rover.dart';
import 'package:photo_from_the_rover/features/service/end_point.dart';

class NetworkService {
  final NasaEndpoint _endpoint = NasaEndpoint();

  Future<List<Photos>> getPhoto(Rover rover, int sol) async {
    final response =
        await http.get(Uri.parse("${_endpoint.getPhotoToSolUri(rover, sol)}"));
    if (response.statusCode == 200) {
      final List<dynamic> photoJson =
          (jsonDecode(response.body) as Map)['photos'];
      print(photoJson);
      return photoJson.map((json) => Photos.fromJson(json)).toList();
    } else {
      throw Exception("Error");
    }
  }

  Future<RoverManifest> getManifest(Rover rover) async {
    final response =
        await http.get(Uri.parse("${_endpoint.getManifestUri(rover)}"));
    if (response.statusCode == 200) {
      final dynamic manifestJson =
          (jsonDecode(response.body) as Map)['photo_manifest'];
      print(manifestJson);
      // RoverManifest manifest = RoverManifest.fromJson(manifestJson);
      return RoverManifest.fromJson(manifestJson);
    } else {
      throw Exception("Error");
    }
  }
}
