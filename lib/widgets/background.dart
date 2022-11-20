import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  final String file_name;

  const Background({Key? key, required this.file_name}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.fill,
        child: Image.asset('assets/images/${file_name}.png'));
  }
}