// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XMenu extends StatelessWidget {
  String sectionTitle;
  double height = 0.0;
  List<Widget> children = const <Widget>[];
  XMenu({super.key, required this.sectionTitle, required this.children, this.height = 0.0});

  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height; 
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontWeight: FontWeight.bold,),
        ),
        const SizedBox(
          height: 9,
        ),
        SizedBox(
          height: screenHeight * height,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 0.8, 
            children: children
          ),
        ),
      ],
    );
  }
}
