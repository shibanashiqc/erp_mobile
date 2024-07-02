import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(BuildContext context, String message, {IconData icon = CupertinoIcons.check_mark_circled_solid, Color color = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content:  Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 10),
          Text( 
            message,
            style: const TextStyle(
              fontSize: 14,
              overflow: TextOverflow.ellipsis, 
            ),
          ), 
        ],  
      ),
    ),
  );
}
