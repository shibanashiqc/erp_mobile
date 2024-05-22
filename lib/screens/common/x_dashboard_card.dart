import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class XDashboardCard extends StatelessWidget {
   IconData icon;
   String title;
   String subTitle;
   String bottomText;
   String value; 
   XDashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.bottomText, 
    required this.value,
    
  });

  @override
  Widget build(BuildContext context) {
    return XCard(
        height: 100,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: ColorConstants.secondaryColor
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:  Icon(icon),   
                      ),
                      const SizedBox(width: 25),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, 
                              style: const TextStyle(
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold)),
                          Text(subTitle, 
                              style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bottomText,
                      style: const TextStyle(
                          fontSize: 10, color: Colors.grey)),
                  Row(
                    children: [
                      Text(value,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.green)),
                     ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
