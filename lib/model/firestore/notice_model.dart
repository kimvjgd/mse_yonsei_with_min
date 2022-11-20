import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';

class NoticeModel {
  final String? postKey;
  final String? name;
  final String? writer;
  final String? url;
  final String? description;
  final DateTime? postTime;
  final DocumentReference? reference;

  NoticeModel.fromMap(Map<String, dynamic>? map, this.postKey,
      {required this.reference})
      : name = map?[KEY_NOTICE_NAME],
        writer = map?[KEY_NOTICE_WRITER],
        url = map?[KEY_NOTICE_URL],
        description = map?[KEY_NOTICE_DESCRIPTION],
        postTime = map?[KEY_NOTICE_DATE] == null
            ?DateTime.now().toUtc()
            :(map?[KEY_NOTICE_DATE] as Timestamp).toDate();

  NoticeModel.fromSnapshot(DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data(), snapshot.id, reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreate({required String name, String? writer,String? url, String? description, DateTime? postTime}) {
    Map<String, dynamic> map = Map();
    map[KEY_NOTICE_NAME] = name;
    map[KEY_NOTICE_WRITER] = writer;
    map[KEY_NOTICE_URL] = url;
    map[KEY_NOTICE_DESCRIPTION] = description;
    map[KEY_NOTICE_DATE] = postTime!.toUtc();
    return map;
  }
  NoticeModel({this.postKey, this.name, this.writer, this.url, this.description, this.postTime, this.reference});
}