// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'dart:developer';

import 'package:erp_mobile/contants/constants.dart';
import 'package:erp_mobile/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  dynamic user;
  List<dynamic> modules;
  CustomDrawer({super.key, required this.user, required this.modules});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        SizedBox(
          height: 180,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              color: ColorConstants.secondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.person,
                    size: 20,
                  ),
                  // backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user?['name'] ?? 'User',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     log('Logout'); 
                        //     SharedPreferences prefs =  await SharedPreferences.getInstance();
                        //     await prefs.remove('user');
                        //     await prefs.remove('token'); 
                        //     await prefs.remove('modules');
                        //     context.push('/login');  
                        //   },
                        //   child: const SizedBox( 
                        //     width: 50,
                        //     height: 10, 
                        //     child:  Icon(CupertinoIcons.power,
                        //         color: Colors.white),
                        //   ),
                        // ),
                      ],
                    ),
                    Text(
                      user?['email'] ?? 'user@example.com',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        ListView(
          shrinkWrap: true,
          children: modules.map((module) {
            return DrawerList(
                title: module['name'],
                route: module['route'],
                icon: Icons.apps,
                children: [
                  for (var subModule in module['items'])
                    ListTile(
                      title: Text(subModule['name']),
                      onTap: () {
                        // Navigator.pushNamed(context, subModule['route']);
                        context.pushNamed(subModule['route']);
                      },
                    ),
                ]);
          }).toList(),
        ),
        DrawerList(
          title: 'Logout',
          route: '/logout',
          icon: Icons.logout, 
          children: [],
          onTap: () async {
            log('Logout');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('user');
            await prefs.remove('token');
            await prefs.remove('modules');
            context.push('/login');
          }, 
        ),

        // DrawerList(
        //   title: 'HR Management',
        //   route: '/hr-management',
        //   icon: Icons.person,
        //   children: [
        //     ListTile(
        //       title: Text('Employee'),
        //       onTap: () {
        //         Navigator.pushNamed(context, '/employee');
        //       },
        //     ),
        //     ListTile(
        //       title: Text('Attendance'),
        //       onTap: () {
        //         Navigator.pushNamed(context, '/attendance');
        //       },
        //     ),
        //     ListTile(
        //       title: Text('Payroll'),
        //       onTap: () {
        //         Navigator.pushNamed(context, '/payroll');
        //       },
        //     ),
        //   ],
        // )
      ]),
    );
  }
}
