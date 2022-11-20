import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';

class TipModel {
  final String? postKey;
  final String? name;
  final String? writer;
  final String? url;
  final String? description;
  final DateTime? postTime;
  final DocumentReference? reference;

  TipModel.fromMap(Map<String, dynamic>? map, this.postKey,
      {required this.reference})
      : name = map?[KEY_TIP_NAME],
        writer = map?[KEY_TIP_WRITER],
        url = map?[KEY_TIP_URL],
        description = map?[KEY_TIP_DESCRIPTION],
        postTime = map?[KEY_TIP_DATE] == null
            ?DateTime.now().toUtc()
            :(map?[KEY_TIP_DATE] as Timestamp).toDate();

  TipModel.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data(), snapshot.id, reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreate({required String name, String? writer,String? url, String? description, DateTime? postTime}) {
    Map<String, dynamic> map = Map();
    map[KEY_TIP_NAME] = name;
    map[KEY_TIP_WRITER] = writer;
    map[KEY_TIP_URL] = url;
    map[KEY_TIP_DESCRIPTION] = description;
    map[KEY_TIP_DATE] = postTime!.toUtc();
    return map;
  }
  TipModel({this.postKey, this.name, this.writer, this.url, this.description, this.postTime, this.reference});
}