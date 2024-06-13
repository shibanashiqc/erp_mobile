// ignore_for_file: must_be_immutable

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:flutter/material.dart';

class XCard extends StatelessWidget {
  Widget child;
  double? height;
  double? width;
  bool isShimmer = false;
  bool isPadding = false;
  bool showChild = true;
  bool isBorder = true; 
  XCard(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.isShimmer = false,
      this.isPadding = false,
      this.showChild = true,
      this.isBorder = true
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,  
      decoration: BoxDecoration( 
        color: Colors.white, 
        borderRadius: isBorder ? BorderRadius.circular(10) :  BorderRadius.circular(0),
      ),
      child: showChild ? Container(
          padding: isPadding ? const EdgeInsets.all(8) : null,
          child: child) : null,
    ); 
  }
}
