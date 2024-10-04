import 'package:dio/dio.dart';
import 'package:hotspot_host_app/models/experience.dart';

class ExperienceRepository {
  final Dio _dio = Dio();

  Future<List<Experience>> fetchExperiences() async {
    try {
      final response = await _dio.get('https://staging.cos.8club.co/experiences');
      if (response.statusCode == 200) {
        final List<dynamic> experiencesData = response.data['data']['experiences'];
        return experiencesData.map((json) => Experience.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load experiences');
      }
    } catch (error) {
      throw Exception('Error fetching experiences: $error');
    }
  }
}
