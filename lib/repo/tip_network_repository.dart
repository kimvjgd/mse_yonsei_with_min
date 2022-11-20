import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/tip_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';

class TipNetworkRepository with Transformers {

  Stream<List<TipModel>> getAllTip() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_TIP)
        .snapshots()
        .transform(toTip)
        .transform(latestToTopTips);
  }

  Future<List<TipModel>> getTips() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_TIP);
    QuerySnapshot snapshots =
        await collectionReference.get();

    List<TipModel> tips = [];
    for(int i = 0; i<snapshots.size;i++){
      TipModel tipModel = TipModel.fromSnapshot(snapshots.docs[i]);
      tips.add(tipModel);
    }
    return tips;
  }
}

TipNetworkRepository tipNetworkRepository = TipNetworkRepository();