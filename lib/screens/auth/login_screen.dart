import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   
  String email = ''; 
  String password = '';
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(), child: buildScaffold());
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is ErrorLoginState) {
          log('Error: ${state.message}');
        }
        
        if (state is ChangeFormValuesState) {
          setValue(state);
        }   
        
      }, builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,   
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column( 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                       Image.asset('assets/images/logo.png', height: 80), 
                       
                       const SizedBox(height: 20), 
                      
                      XInput(
                        onChanged: (value) {
                          context.read<LoginCubit>().changeFormValues('email', value);
                        }, 
                        isMandatory: true,
                        label: 'Email',
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      XInput(
                        onChanged: (value) { 
                          context
                              .read<LoginCubit>()
                              .changeFormValues('password', value);
                        }, 
                        isPassword: true,
                        isMandatory: true,
                        label: 'Password',
                        hintText: 'Enter your password',
                        obscureText: true,
                      ),
                      XButton(
                        icon: CupertinoIcons.square_arrow_right_fill,
                        label: 'Login',
                        onPressed: () {   
                          context
                              .read<LoginCubit>()
                              .login({'email': email, 'password': password}).then((value) {
                               if(value.status == 'success') {
                                 context.push('/');  
                               } else {  
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message.toString())));
                               } 
                            // context.push('/dashboard');    
                          });  
                        }, 
                      ),
                    ],
                  ),
                
                
                 XButton(
                   icon: Icons.person,
                   color: ColorConstants.greshadowColoren, 
                   label: 'Guest Login',
                   onPressed: () async {
                      SharedPreferences prefs =  await SharedPreferences.getInstance();
                      await prefs.setString('token', 'guest');
                      context.push('/'); 
                   },
                 ), 
                  
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

   void setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'email':
        email = state.value;
        break;
      case 'password':
        password = state.value;
        break;
      default:
    }
   }
}
