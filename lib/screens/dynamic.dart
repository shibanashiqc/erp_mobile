import 'package:flutter/material.dart';

class Dynamic extends StatelessWidget {
   Widget child;
   String sectionTitle;
   Dynamic({super.key, required this.child, required this.sectionTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sectionTitle),
      ),
      body: SingleChildScrollView(child: child), 
    );
  }
}