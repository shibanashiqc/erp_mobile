// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class XContainer extends StatelessWidget {
  Widget child;
  bool enablePading = true;
  bool showShimmer = false;
  ScrollController? controller = ScrollController();
  XContainer(
      {super.key,
      required this.child,
      this.enablePading = true,
      this.controller,
      this.showShimmer = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
          padding: enablePading
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(0),
          child: showShimmer
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height, 
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(10, (index) { 
                        return Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.white,
                        );
                      }),
                    ),
                  ), 
                ) 
                  
              : child),
    );
  }
}
