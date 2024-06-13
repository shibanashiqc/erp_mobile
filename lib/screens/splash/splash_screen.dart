// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        await context.read<LoginCubit>().getLoggedUser().then((value) async {
        if(value == null) {
          await context.read<LoginCubit>().logout();
          context.push('/login'); 
        }
        // log(value.toString()) 
        });
        if (token != null) {
          context.push('/dashboard');
        } else {
          context.push('/login'); 
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(), child: buildScaffold(context));
  }

  Widget buildScaffold(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is ErrorLoginState) {
        log('Error: ${state.message}');
      }
    }, builder: (context, state) {
      return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            
            Image.asset('assets/images/logo.png', height: 100),
            const SizedBox(height: 10), 
            const SizedBox(
              height: 15,
              width: 15, 
              child: CircularProgressIndicator()),
            const SizedBox(height: 10),
            const Text('Please wait for few seconds.'), 
          ],
        ),
      );
    }));
  }
}
