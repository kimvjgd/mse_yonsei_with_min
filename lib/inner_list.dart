import 'package:mse_yonsei/model/firestore/post_model.dart';

class InnerList {
  final String name;
  List<PostModel> children;
  InnerList({required this.name, required this.children});
}
