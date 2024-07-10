import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/extra/customer_file_manager_model.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Files extends StatefulWidget {
  String customerId;
  Files({
    super.key,
    required this.customerId, 
  });

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  
  List<Data> data = [];
  bool loading = true;
  dynamic parentId;
  String folderName = ''; 
  File file = File(''); 
  
  isImage(String name) { 
    final ext = name.split('.').last;
    if (ext == 'jpg' || ext == 'jpeg' || ext == 'png' || ext == 'gif') {
      return true;
    }
    return false;
  }
  
  fetchData() async {
    context.read<MainCubit>().get('sales/customer/${widget.customerId}/file-manager').then((value) {
      final res = CustomerFileManagerModel.fromJson(value);
      if (res.data != null) { 
        setState(() {
          data = res.data ?? [];
          if (parentId != null) {
            data = data.where((element) => element.parentId.toString() == parentId.toString()).toList(); 
          } 
          loading = false; 
        });
      } 
    });
  }
  
  @override
  void initState() {
    fetchData();  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return XContainer( 
      child: Column(
        children: [
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width:  0.1), 
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Files'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () {
                           showMenu<String>(
                            context: context,
                            position: const RelativeRect.fromLTRB(100, 100, 0, 100),
                            items: <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: '1',
                                child: Text('Create Folder'),
                              ),
                              const PopupMenuItem<String>(
                                value: '2',
                                child: Text('Upload File'), 
                              ),
                            ],
                          ).then((value) {
                            if (value == '1') {
                              // create folder
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Create Folder'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          onChanged: (value) {
                                            folderName = value;
                                          }, 
                                          decoration: const InputDecoration(
                                            hintText: 'Folder Name',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.read<MainCubit>().postRes('sales/customer/${widget.customerId}/file-manager/create', {
                                                'name': folderName,
                                                'is_folder': 1,
                                                'parent_id': parentId,
                                                }, context).then((value) {
                                                  if (value.data != null) { 
                                                    fetchData();
                                                    Navigator.of(context).pop();  
                                                  } 
                                                });
                                              
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ); 
                             
                            } else if (value == '2') {
                              // upload file
                               
                              showDialog( 
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          if (file.path == '') {
                                            alert(context, 'Please select file');   
                                            return;
                                          }
                                          context.read<MainCubit>().postRes('sales/customer/${widget.customerId}/file-manager/create', {
                                            'parent_id': parentId,
                                            'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last), 
                                            'is_folder': 0,  
                                            'name': 'file.jpg', 
                                          }, context, multipart: true).then((value) {
                                            if (value.data != null) {  
                                              file = File(''); 
                                              fetchData();
                                              Navigator.of(context).pop();  
                                            }  
                                          });
                                        },
                                        child: const Text('Save'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ), 
                                    ],
                                    title: const Text('Upload File'),
                                    content: Column(
                                      children: [
                                         XFileImage(onChanged: (value) {
                                           file = value;
                                         }), 
                                      ],
                                    ),
                                  );
                                },
                              );
                              
                            }
                          }); 
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child:  Column(
                    children: [
                      
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: data.length, 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  data[index].parentId == null || parentId != null  ? Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                data[index].isFolder == 1 ?
                                InkWell(
                                  onDoubleTap: () { 
                                      parentId = data[index].id;
                                      data = data.where((element) => element.parentId.toString() == parentId.toString()).toList(); 
                                    setState(() {
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.folder, size: 50),
                                      Text(data[index].name ?? '', style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ) : 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isImage(data[index].file ?? '') ? Image.network(data[index].file ?? '', width: 100, height: 60) :  
                                    Column( 
                                      children: [
                                        const Icon(Icons.file_copy, size: 50),
                                    Text(data[index].file ?? '', style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis,)),
                                        
                                      ], 
                                    ),
                                  ], 
                                ),
                              ],
                            )  
                          ) : Container(); 
                        },
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),  
          ),
        ],
      ),
    ); 
  }
}