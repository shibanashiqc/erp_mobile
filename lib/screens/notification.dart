import 'dart:developer';

import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  List notifications = [];
  
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await context.read<LoginCubit>().getLoggedUser().then((value) async {
        if (value != null) { 
          //log(value.toString());
           notifications = value['data']['notifications']; 
        }
      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,  
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300)  ,
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ), 
                child: ListTile(
                  leading: const Icon(Icons.notifications)  ,
                  title: Text(notifications[index]['title']),
                  subtitle: Text(notifications[index]['description']),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}