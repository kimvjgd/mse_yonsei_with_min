import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';

class UserModel {
  final String userKey;
  final String email;
  final String stu_num;
  final String access;
  final DocumentReference? reference;

  UserModel.fromMap(Map<String, dynamic>? map, this.userKey, {required this.reference})
      : email = map![KEY_EMAIL],
        stu_num = map[KEY_STU_NUMBER],
        access = map[KEY_ACCESS];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
      reference: snapshot.reference);


  static Map<String, dynamic> getMapForCreateUser(String email) {        // return type은 Map<String, dynamic>
    Map<String, dynamic> map = Map();
    map[KEY_EMAIL] = email;
    map[KEY_STU_NUMBER] = '';
    map[KEY_ACCESS] = 'n';
    return map;
  }
  UserModel({required this.userKey, required this.email, required this.access, required this.stu_num, this.reference});
}
