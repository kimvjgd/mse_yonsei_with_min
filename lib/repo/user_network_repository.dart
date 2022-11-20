import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/user_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';

class UserNetworkRepository extends Transformers {
  Future<void> attemptCreateUser({String? userKey, String? email}) async {

    final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if(!snapshot.exists) {
      return await userRef.set(UserModel.getMapForCreateUser(email!));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
    // .get() 한번만 갖고오면 안된다.
        .snapshots().transform(toUser);                   // snapshot을 userModel로 바꿔준다.  stream으로 userModel을 불러온다.
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();