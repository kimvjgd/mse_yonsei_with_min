import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mse_yonsei/constants/firestore_keys.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/repo/helper/transformers.dart';
import 'package:rxdart/rxdart.dart';

class PostNetwokRepository with Transformers {

  Future<void> sendData(String userKey, String postKey, String name,
      String? number, String? url, String? lab_url, String? professor_url, String? category) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .collection('repo')
        .doc(postKey)
        .set({
      'name': name,
      'number': number,
      'url': url,
      'lab_url': lab_url,
      'professor_url': professor_url,
      'category': category,
      'posyKey':postKey,
    });
  }

  Future<void> deleteDate(String userKey, String postKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .collection('repo')
        .doc(postKey)
        .delete()
        .then((_) => print('delete complete'));
  }


  // Stream<List<PostModel>> getAllPosts() {
  //   return FirebaseFirestore.instance
  //       .collection(COLLECTION_POSTS)
  //       .snapshots()
  //       .transform(toPosts);
  // }


  Stream<List<PostModel>> getAllYoutube() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_YOUTUBE)
        .snapshots()
        .transform(toPosts);
  }

  Future<List<PostModel>> getYoutube() async{
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_YOUTUBE);
    QuerySnapshot snapshots =
        await collectionReference.get();

    List<PostModel> youtubes = [];
    for(int i = 0; i<snapshots.size; i++) {
      PostModel youtubeModel = PostModel.fromSnapshot(snapshots.docs[i]);
      youtubes.add(youtubeModel);
    }
    return youtubes;
  }
  // Future<List<NoticeModel>> getNotices() async {
  //   CollectionReference collectionReference =
  //   FirebaseFirestore.instance.collection(COLLECTION_NOTICE);
  //   QuerySnapshot snapshots =
  //   await collectionReference.get();
  //
  //   List<NoticeModel> notices = [];
  //   for(int i = 0; i<snapshots.size;i++){
  //     NoticeModel noticeModel = NoticeModel.fromSnapshot(snapshots.docs[i]);
  //     notices.add(noticeModel);
  //   }
  //   return notices;
  // }


  // Stream<void> getPostsFromSpecificUser(String category) {
  //   return FirebaseFirestore.instance
  //       .collection(COLLECTION_POSTS)
  //       .where(KEY_CATEGORY, isEqualTo: category)
  //       .snapshots()
  //       .transform(toPosts);
  // }

  Stream<List<PostModel>> getMyPosts(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .collection('repo')
        .snapshots()
        .transform(toPosts)
        .transform(orderedName);
  }

  Future<List<PostModel>> getMyOwnPosts(String userKey) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey).collection('repo');
    QuerySnapshot snapshots = await collectionReference.get();

    List<PostModel> posts = [];
    for(int i = 0; i<snapshots.size;i++){
      PostModel postModel = PostModel.fromSnapshot(snapshots.docs[i]);
      posts.add(postModel);
    }
    return posts;
  }
  // Future<List<NoticeModel>> getNotices() async {
  //   CollectionReference collectionReference =
  //   FirebaseFirestore.instance.collection(COLLECTION_NOTICE);
  //   QuerySnapshot snapshots =
  //   await collectionReference.get();
  //
  //   List<NoticeModel> notices = [];
  //   for(int i = 0; i<snapshots.size;i++){
  //     NoticeModel noticeModel = NoticeModel.fromSnapshot(snapshots.docs[i]);
  //     notices.add(noticeModel);
  //   }
  //   return notices;
  // }

}

PostNetwokRepository postNetworkRepository = PostNetwokRepository();
