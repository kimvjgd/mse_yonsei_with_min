import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/constants/screen_size.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/model/user_model_state.dart';
import 'package:mse_yonsei/screens/expansion_screen.dart';
import 'package:mse_yonsei/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userKey = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repoConfirm(),
      builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   print('@@@ snapshot은 데이터가 없다.');
          //   return MyProgressIndicator(
          //     progressSize: 50,
          //   );
          // }

        return Scaffold(
          body: ExpansionScreen(),
        );
      },
    );
  }

  Future<List<PostModel>> repoConfirm() async {
    if (size == null) size = MediaQuery.of(context).size;

    userKey =
        Provider.of<UserModelState>(context, listen: false).userModel.userKey;

    if (userKey != null || userKey != "") {
      userKey = FirebaseAuth.instance.currentUser!.uid;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .collection('repo')
        .get();
    if (snapshot.docs.length == 0) {
      await FirebaseFirestore.instance
          .collection(COLLECTION_USERS)
          .doc(userKey)
          .collection('repo')
          .doc('first_$userKey')
          .set({'name': 'Welcome, new friend'});
    }

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_YOUTUBE);
    QuerySnapshot snapshots = await collectionReference.get();

    List<PostModel> myRepo = [];
    for (int i = 0; i < snapshots.size; i++) {
      PostModel youtubeModel = PostModel.fromSnapshot(snapshots.docs[i]);
      myRepo.add(youtubeModel);
    }
    return myRepo;
  }
}
