// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XBadge extends StatelessWidget {
  String? label;
  Icon? icon;
  Color color;
  double padding = 8;
  XBadge({super.key, this.label, this.icon, required this.color, this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),    
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: label?.isNotEmpty == true ? Text(
        label!,
        style:  TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,  
        ),
      ) : icon 
         
    );
  }
}