// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleForm extends StatefulWidget {
  int? editId;
  String? title = '';
  RoleForm( 
      {super.key, this.editId, this.title});

  @override
  State<RoleForm> createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  String title = '';

  @override
  void initState() {
    super.initState();
    if (widget.editId != null) {
      title = widget.title ?? '';
    }
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
          context.read<HrCubit>().createRole({
            'name': title,
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Role Update or Create'), 
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is TitleState) {
          title = state.title;
        }
       
      }, builder: (context, state) {
        return XContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XInput(
              initialValue: title,
              onChanged: (value) {
                context.read<HrCubit>().changeTitle(value);
              },
              isMandatory: true,
              label: 'Title',
              hintText: 'Enter title',
            ),
           
          ],
        ));
      }),
    );
  }
}
