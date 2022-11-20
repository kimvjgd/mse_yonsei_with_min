import 'package:flutter/material.dart';
import 'package:mse_yonsei/constants/material_color.dart';
import 'package:mse_yonsei/model/firestore/tip_model.dart';
import 'package:mse_yonsei/repo/tip_network_repository.dart';
import 'package:mse_yonsei/screens/tip_detail_screen.dart';
import 'package:mse_yonsei/widgets/background.dart';
import 'package:mse_yonsei/widgets/my_progress_indicator.dart';

class TipScreen extends StatefulWidget {
  const TipScreen({Key? key}) : super(key: key);

  @override
  _TipScreenState createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TipModel>>(
        initialData: [TipModel(name: '인터넷 연결 상태를 확인해주세요.')],
        future: tipNetworkRepository.getTips(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MyProgressIndicator();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('Tip'),
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
                                builder: (context) => TipDetailScreen(
                                      tipModel: snapshot.data![index],
                                    )));
                          },
                          child: ListTile(
                            title: Text(
                              snapshot.data![index].name.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
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
