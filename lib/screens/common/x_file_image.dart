// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XFileImage extends StatefulWidget {
  String? label;
  bool isMandatory = false;
  void Function(dynamic)? onChanged; 
  void Function(List<File>)? onChangedMultiple;
  bool allowMultiple = false;
  File? file = File('');
  List<String> stringFileUrls = [];
  XFileImage({
    super.key,
    this.label,
    this.isMandatory = false,
    required this.onChanged,
    this.onChangedMultiple, 
    this.allowMultiple = false,
    this.file,
    this.stringFileUrls = const [], 
  });

  @override
  State<XFileImage> createState() => _XFileImageState();
}

class _XFileImageState extends State<XFileImage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;
  List<File>? _files = [];
  PlatformFile? _platformFile;

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultiple,
      type: FileType.any,
      // allowedExtensions: ['*'],
      //allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', ],
    );
    if (result != null) {
      _platformFile = result.files.first;
      _files = result.paths.map((path) => File(path!)).toList();
      loadingController.forward();
      setState(() {});
      if (widget.allowMultiple == true) {
        widget.onChanged!(_files);
        if (widget.onChangedMultiple != null) {
          widget.onChangedMultiple!(_files!);
        } 
      } else {
        File file = File(result.files.single.path!);
        widget.onChanged!(file);
      }
    }
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    if (widget.file != null) {
      _files = [widget.file!];
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(widget.label!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 5),
                if (widget.isMandatory)
                  const Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        const SizedBox(
          height: 5,
        ),
        XCard(
          child: GestureDetector(
            onTap: selectFile,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: Colors.black,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cloud_upload_fill,
                        color: Colors.black,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select your file',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        _platformFile != null
            ? SizedBox(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected File',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _files!.length,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _files![index],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _platformFile!.name,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${(_platformFile!.size / 1024).ceil()} KB',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 5,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue.shade50,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: loadingController.value,
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 45,
                  //   onPressed: () {},
                  //   color: Colors.black,
                  //   child: Text('Upload', style: TextStyle(color: Colors.white),),
                  // )
                ],
              ))
            : widget.stringFileUrls.isNotEmpty ?
            SizedBox(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected File',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.stringFileUrls.length,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    widget.stringFileUrls[index],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.stringFileUrls[index],
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   '${(_platformFile!.size / 1024).ceil()} KB',
                                      //   style: TextStyle(
                                      //       fontSize: 13,
                                      //       color: Colors.grey.shade500),
                                      // ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Container(
                                      //     height: 5,
                                      //     clipBehavior: Clip.hardEdge,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(5),
                                      //       color: Colors.blue.shade50,
                                      //     ),
                                      //     child: LinearProgressIndicator(
                                      //       value: loadingController.value,
                                      //     )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))
            : const SizedBox(),
             
        const SizedBox(height: 8),
      ],
    );
  }
}
