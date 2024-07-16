// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XBadge extends StatelessWidget {
  String? label;
  Icon? icon;
  Color color;
  double padding = 8;
  Function()? onPressed;
  XBadge({super.key, this.label, this.icon, required this.color, this.padding = 8, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {}, 
      child: Container(
        padding: EdgeInsets.all(padding),    
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: label?.isNotEmpty == true ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? Container(), 
            const SizedBox(width: 5),
            Text(
              label!,
              style:  TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,  
              ),
            ),
          ],
        ) : icon 
           
      ),
    );
  }
}