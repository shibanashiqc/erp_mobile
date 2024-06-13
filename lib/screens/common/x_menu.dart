// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class XMenu extends StatefulWidget {
  String sectionTitle;
  double height = 0.0;
  bool isShow = false;
  List<Widget> children = const <Widget>[];
  XMenu(
      {super.key,
      required this.sectionTitle,
      required this.children,
      this.height = 0.0,
      this.isShow = false});

  @override
  State<XMenu> createState() => _XMenuState();
}

class _XMenuState extends State<XMenu> {
  @override
  Widget build(BuildContext context) {
    num screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget.isShow = !widget.isShow;
            // ignore: invalid_use_of_protected_member
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.sectionTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  widget.isShow == false
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            widget.isShow = !widget.isShow;
                            // ignore: invalid_use_of_protected_member
                            setState(() {});
                          },
                          child: Text(
                            widget.isShow == false ? 'Show More' : 'Show Less',
                            style: const TextStyle( 
                                color: Colors.blue,
                                ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        widget.isShow == false
            ? const SizedBox(
                height: 9,
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 9,
                  ),
                  SizedBox(
                    height: screenHeight * widget.height,
                    child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        childAspectRatio: 0.8,
                        children: widget.children),
                  ),
                ],
              ),
      ],
    );
  }
}
