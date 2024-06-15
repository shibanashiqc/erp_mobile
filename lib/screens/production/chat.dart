// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/project_chat_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Chat extends StatefulWidget {
  Object? extra;
  Chat({
    super.key,
    this.extra,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data> chats = [];
  String appTitle = 'Chat';
  String projectId = '';
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  TextEditingController messageController = TextEditingController();
  File attachment = File('');  

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;
  
  static const apiKey = 'cc0a4b947e0fee206b2b';
  static const cluster = 'ap2';
  
  static const channelName = 'my-channel';
  static const eventName = 'my-event';
  
  
  void onConnectPressed() async {
    try {
      await pusher.init(
        useTLS: true,
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      ); 
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onEvent(PusherEvent event) {
    loadMessages();
  } 

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    log("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    log("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }


  void _scrollListener() { 
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadMessages();
    }  
    
  }
  
   void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null) {
      attachment = File(result.files.single.path!);
      setState(() {});
    }
  }


  loadMessages({query}) async {
    await context
        .read<MainCubit>()
        .getMessages(projectId, query: query, limit: limit)
        .then((value) {
      chats = value.data ?? [];
      isLoad = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    var map = widget.extra as Map<String, dynamic>;
    projectId = map['id'].toString();
    appTitle = map['name'];
    controller = ScrollController()..addListener(_scrollListener);

    loadMessages();
    onConnectPressed(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Padding( 
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              
              attachment.path.isNotEmpty
                  ? SizedBox(
                      height: 100,
                      width: screenWidth * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(attachment),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(attachment),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ))
                  : Container(), 
              
              
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          InkWell( 
                            onTap: selectFile,
                            child: const CircleAvatar(
                              backgroundColor: ColorConstants.secondaryColor,
                              child: Icon(
                                CupertinoIcons.camera,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                hintText: 'Type a message',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: ColorConstants.secondaryColor,
                          //   child: Icon(
                          //     CupertinoIcons.mic,
                          //     color: Colors.white,
                          //     size: 18,
                          //   ),
                          // ),
                          InkWell(
                            onTap: () async {
                              context.read<MainCubit>().save({
                                'project_id': projectId,
                                'message': messageController.text, 
                                'attachments': attachment.path.isNotEmpty ? await MultipartFile.fromFile(attachment.path) : null, 
                              }, 'production/project/send-message');
                             
                              attachment = File(''); 
                              messageController.clear();  
                            },
                            child: const CircleAvatar(
                              backgroundColor: ColorConstants.secondaryColor,
                              child: Icon(
                                CupertinoIcons.paperplane,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
          shape: const Border(bottom: BorderSide(width: 0.1)),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis),
              onPressed: () {},
            ),
          ],
          title: Row(
            children: [
              const CircleAvatar(
                child: Icon(Icons.person, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appTitle),
                  const SizedBox(height: 2),
                  const Row(
                    children: [
                      Text('Active now',
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                      SizedBox(width: 3),
                      Icon(Icons.circle, size: 7, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ],
          )),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) {
          loading = false;
        }

        if (state is LoadingMainState) {
          loading = true;
        }

        if (state is ValidationErrorState) {
          log('Validation Error');
          errorBags = state.errors;
        }

        if (state is ChangeFormValuesState) {}
      }, builder: (context, state) {
        return XContainer(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.8, 
                  child: ListView.builder(
                    controller: controller,  
                    // shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(), 
                    reverse: true,  
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return Row(
                          mainAxisAlignment: chats[index].sender == 'me'
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  chats[index].sender != 'me'
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              chats[index].profile ?? ''))
                                      : Container(),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: chats[index].sender != 'me'
                                          ? Colors.grey[200]
                                          : ColorConstants.secondaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (chats[index].attachment?.isNotEmpty ==
                                            true)
                                          SizedBox(
                                              height: 100,
                                              width: screenWidth * 0.6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            child: Container(
                                                              height: 300,
                                                              width: 300,
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          chats[index].attachment ??
                                                                              ''),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                chats[index]
                                                                        .attachment ??
                                                                    ''),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              )),
                                        Text(chats[index].message ?? '',
                                            style: TextStyle(
                                                color: chats[index].sender != 'me'
                                                    ? Colors.black
                                                    : Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                    },
                  ),
                ),
                
                
              ],
            ));
      }),
    );
  }
}
