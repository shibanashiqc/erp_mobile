// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XContainer extends StatelessWidget {
  Widget child;
  bool enablePading = true;
  XContainer({super.key, required this.child, this.enablePading = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: enablePading ? const EdgeInsets.all(8.0) : const EdgeInsets.all(0), 
        child: child
      ),
    );
  }
}