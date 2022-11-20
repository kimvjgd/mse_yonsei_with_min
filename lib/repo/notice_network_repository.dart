import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/notice_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeNetworkRepository with Transformers {

  Stream<List<NoticeModel>> getAllNotice() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_NOTICE)
        .snapshots()
        .transform(toNotice)
        .transform(latestToTopNotices);
  }

  Future<List<NoticeModel>> getNotices() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_NOTICE);
    QuerySnapshot snapshots =
        await collectionReference.get();

    List<NoticeModel> notices = [];
    for(int i = 0; i<snapshots.size;i++){
      NoticeModel noticeModel = NoticeModel.fromSnapshot(snapshots.docs[i]);
      notices.add(noticeModel);
    }
    return notices;
  }
}

NoticeNetworkRepository noticeNetworkRepository = NoticeNetworkRepository();