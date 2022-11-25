import 'package:music_app/models/models.dart';

convertToNameList(List<Artist> artists) => artists.map((e) => e.name);

Map<String, dynamic> convertToJson(data) => Map<String, dynamic>.from(data);

Iterable cleanDataFromCloudFunction(data) => data.map((e) => convertToJson(e));
