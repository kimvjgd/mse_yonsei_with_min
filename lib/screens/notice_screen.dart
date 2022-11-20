import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/model/firestore/notice_model.dart';
import 'package:mse_yonsei/model/firestore/post_model.dart';
import 'package:mse_yonsei/repo/notice_network_repository.dart';
import 'package:mse_yonsei/screens/notice_detail_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<NoticeModel>>.value(
    //   initialData: [],
    //   value: noticeNetworkRepository.getAllNotice(),
    // );
    return FutureBuilder<List<NoticeModel>>(
        initialData: [NoticeModel(name: '인터넷 연결 상태를 확인해주세요.')],
        future: noticeNetworkRepository.getNotices(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MyProgressIndicator();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Notice'),
                backgroundColor: app_color,
              ),
              body: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Background(file_name: 'homebackground')),
                  ListView.builder(
                    itemBuilder: (context, index) => Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => NoticeDetailScreen(
                                      noticeModel: snapshot.data![index],
                                    )));
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].name.toString(),
                              maxLines: 1,
                              style: TextStyle(color: Colors.white),
                            ),

                            // title: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       notices[index].name!,
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //     Text(
                            //       '${notices[index].postTime!.year}년 ${notices[index].postTime!.month}월 ${notices[index].postTime!.day}일',
                            //       style: TextStyle(
                            //           color: Colors.white, fontSize: 13),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: Colors.white,
                        )
                      ],
                    ),
                    itemCount: snapshot.data!.length,
                  )
                ],
              ));
        });
  }
}
