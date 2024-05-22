// ignore_for_file: must_be_immutable

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  XButton({super.key, required this.label, required this.onPressed, this.enableRadius = true, this.color = ColorConstants.secondaryColor, this.enablePadding = true, this.icon, this.loading = false});
  String label;
  void Function() onPressed; 
  bool enableRadius = true; 
  Color color = ColorConstants.secondaryColor;  
  bool enablePadding = true;  
  IconData? icon; 
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enablePadding ? const EdgeInsets.all(7.9) : const EdgeInsets.all(0),
      child: ElevatedButton(  
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 40), 
          shape: RoundedRectangleBorder(  
            borderRadius:  enableRadius ? BorderRadius.circular(5) : BorderRadius.circular(0), 
          ),
          backgroundColor: color,
            
        ),
        onPressed: onPressed, 
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            if(loading) const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))), 
            if(icon != null) Icon(icon, color: Colors.white),
            const SizedBox(width: 10),  
            Text(label.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  } 
}