import 'package:g_json/g_json.dart';

abstract class BaseModel {
  BaseModel();
  BaseModel.fromJson(JSON json);
  JSON toJson();
}
