// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/logs_model.dart';
import 'package:erp_mobile/screens/apointments.dart';
import 'package:erp_mobile/screens/apps_widget.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/drawer.dart';
import 'package:erp_mobile/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashbaord extends StatefulWidget {
  const Dashbaord({super.key});

  @override
  State<Dashbaord> createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  int currentPageIndex = 0;
  dynamic user;
  List<dynamic>? modules;
  List<dynamic>? branches = [];
  String selectedBranchId = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      user = json.decode(prefs.getString('user') ?? '{}');
      modules = json.decode(prefs.getString('modules') ?? '[]');
      branches = json.decode(prefs.getString('branches') ?? '[]');
      branches?.add({'id': '', 'name': 'All'});  
      selectedBranchId = prefs.getString('current_branch_id') ?? ''; 
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (justification) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        // drawer: CustomDrawer(
        //   user: user,
        //   modules: modules ?? [],
        // ),
        appBar: AppBar(
          leadingWidth: 150,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () async {},
                child: Text('TechkiHub',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18, 
                        fontWeight: FontWeight.bold))),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: XSelect(
                value: selectedBranchId,
                width: 0.39,
                height: 0.04,
                placeholder: 'Select Branch',
                color: Colors.grey.withOpacity(0.1),
                options: branches?.map((e) {
                      return DropDownItem(
                          value: e['id'].toString(), label: e['name']);
                    }).toList() ??
                    [],
                onChanged: (value) async {
                  await context
                      .read<LoginCubit>()
                      .updateUser({'current_branch_id': value}).then(
                          (value) => context.push('/'));
                  selectedBranchId = value;
                },
              ),
            ),
            InkWell(
              onTap: () async {
                context.push('/profile');
              }, 
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 15,
                  child: Icon(
                    Icons.person,
                    size: 15,
                  ),
                  // backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
            
              
            InkWell(
              onTap: () async {
                context.pushNamed('notification');
              }, 
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 15,
                  child: Icon(
                    Icons.notifications,
                    size: 15,
                  ),
                  // backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ),
            ), 
            
          ],
          // title: XInput(
          //   height: 0.05,
          //   radius: 10,
          //   color: Colors.grey.withOpacity(0.1),
          //   hintText: 'Search something...',
          //   suffixIcon: const Icon(Icons.search),
          // ),
        ), 
    
      
        

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.square_grid_2x2),
            //   label: 'Apps',
            // ),
            
           BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_grid_2x2), 
              label: 'Menu', 
              //activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill, color: Colors.blue)  ,  
            ),

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: 'Appointments',
            ),

            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location),   
              label: 'Logs',
            ),
          ],
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: const <Widget>[
            Home(),
            AppsWidget(), 
            Appointments(),
            Logs(),

            // Center(
            //   child: Text('Messages'),
            // ),
          ],
        ),
      ),
    );
  }
}

class Logs extends StatefulWidget {
  const Logs({
    super.key,
  });

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  List<Data> logs = [];
  @override
  void initState() {
    
    context.read<MainCubit>().get('logs', limit: 10).then((value) {
      final LogModel logsModel = LogModel.fromJson(value);
      logs = logsModel.data ?? []; 
      setState(() {}); 
    });  
      
    super.initState();
    log('Logs');
  }  
  
  
  @override
  Widget build(BuildContext context) {
    return Container( 
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const Divider(), 
                    Text(logs[index].username ?? ''), 
                    
                    ListTile(
                      title: Text(logs[index].route ?? ''),
                      subtitle: Text(logs[index].action ?? ''),
                      trailing: Text(logs[index].createdAt ?? ''),
                    ),
                  ],
                );
              },
            ),
          ), 
        ],
      ),
    ); 
  }
}



class DrawerList extends StatefulWidget {
  String title;
  String route;
  IconData? icon;
  List<Widget> children;
  VoidCallback? onTap;
  DrawerList({
    required this.title,
    required this.route,
    this.icon,
    required this.children,
    this.onTap,
    super.key,
  });

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.icon == null ? null : Icon(widget.icon),
      title: Text(widget.title),
      onTap: () {
        Navigator.pop(context);
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      trailing: widget.children.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(widget.title),
                      children: widget.children,
                    );
                  },
                );
              },
            ),
    );
  }
}
