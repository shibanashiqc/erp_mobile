// ignore_for_file: must_be_immutable

import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:flutter/material.dart';

class XMenuItem extends StatelessWidget {
  XMenuItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title,
      this.isSelected = true, 
      this.isHidden = false, 
      });
  IconData icon;
  String title;
  bool isSelected = true;
  bool isHidden = false; 
  void Function()? onTap;
  @override
  Widget build(BuildContext context) { 
    return
     isHidden ? const SizedBox(): 
     InkWell( 
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          XCard(height: 60, width: 60, child: Icon(icon)),
          const SizedBox( 
            height: 9,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 9),  
          )
        ],
      ),
    );
  }
}
