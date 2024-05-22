// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateCustomers extends StatefulWidget {
  int? editId;
  Map<String, dynamic>? data = {};
  Function()? onSaved;
  CreateCustomers({super.key, this.editId, this.data, this.onSaved});

  @override
  State<CreateCustomers> createState() => _CreateCustomersState();
}

class _CreateCustomersState extends State<CreateCustomers> {
  String name = '';
  String email = '';
  String phone = '';

  List<Errors> errorBags = [];

  set setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'name':
        name = state.value;
        break;
      case 'email':
        email = state.value;
        break;
      case 'phone':
        phone = state.value;
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.editId != null) {
      log('Edit ID: ${widget.editId}'); 
      name = widget.data?['name'];
      email = widget.data?['email'];
      phone = widget.data?['phone'];
    }
    setState(() {});  
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HrCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: XButton(
        label: 'Save',
        onPressed: () {
          context.read<HrCubit>().createCustomers({
            'edit_id': widget.editId, 
            'name': name,
            'email': email,
            'phone': phone,
          }).then((value) {
            if (value.status == 'error') {
              errorBags = value.errors!; 
              setState(() {
              });
             return;
            }
            
             ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.message.toString()))); 
           widget.onSaved != null ? widget.onSaved!() : null; 
           context.pop();  
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Customers Update or Create'),
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        log('State: $state');

        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is ValidationErrorState) {
          log('Error: ${state.errors}');
          errorBags = state.errors;
        }

        if (state is LoadedHrState) {
          log('Loaded');
        }

        if (state is LoadingHrState) {
          log('Loading');
        }

        if (state is InitialHrState) {
          log('Initial');
        }

        if (state is ChangeFormValuesState) {
          setValue = state;
        }
      }, builder: (context, state) {
        return XContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XInput(
              model: 'name',
              errorBags: errorBags,
              initialValue: name,
              onChanged: (value) {
                context.read<HrCubit>().setValues('name', value);
              },
              isMandatory: true,
              label: 'Name',
              hintText: 'Enter name',
            ),
            XInput(
              initialValue: email,
              model: 'email',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('email', value);
              },
              label: 'Email',
              hintText: 'Enter email',
            ),
            XInput(
              initialValue: phone,
              model: 'phone',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('phone', value);
              },
              label: 'Phone',
              hintText: 'Enter phone',
            ),
          ],
        ));
      }),
    );
  }
}
