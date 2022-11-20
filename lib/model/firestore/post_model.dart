import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';

class PostModel {
  final String? postKey;
  final String? userKey;
  final String? name;
  final String? phone_number;
  final String? url;
  final String? lab_url;
  final String? lab_name;
  final String? professor_url;
  final String? professor_name;
  final String? new_trigger;
  final String? category;
  final DocumentReference? reference;

  PostModel.fromMap(Map<String, dynamic>? map, this.postKey,
      {required this.reference})
      : name = map?[KEY_NAME],
        userKey = map?[KEY_USERKEY],
        phone_number = map?[KEY_PHONE_NUMBER],
        new_trigger = map?[KEY_NEW_TRIGGER],
        url = map?[KEY_URL],
        lab_url = map?[KEY_LAB_URL],
        lab_name = map?[KEY_LAB_NAME],
        professor_url = map?[KEY_PROFESSOR_URL],
        professor_name = map?[KEY_PROFESSOR_NAME],
        category = map?[KEY_CATEGORY];

  PostModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
      reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreate({required String name, String? phone_number, String? url, required String category, String? userKey}) {
    // return type은 Map<String, dynamic>
    Map<String, dynamic> map = Map();
    map[KEY_NAME] = name;
    map[KEY_USERKEY] = userKey;
    map[KEY_PHONE_NUMBER] = phone_number;
    map[KEY_URL] = url;
    map[KEY_LAB_URL] = '';
    map[KEY_LAB_NAME] = '';
    map[KEY_PROFESSOR_URL] = '';
    map[KEY_PROFESSOR_NAME] = '';
    map[KEY_CATEGORY] = category;
    return map;
  }

  PostModel({this.postKey, this.name, this.userKey,this.phone_number,this.new_trigger, this.url, this.lab_url, this.lab_name, this.professor_url, this.professor_name, this.category, this.reference});       // for make internal example...
}
