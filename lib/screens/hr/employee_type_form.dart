// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeTypeForm extends StatefulWidget {
  int? editId;
  String? title = '';
  String? description = '';
  int? status = 1;
  Function()? onSaved;
  EmployeeTypeForm(
      {super.key, this.editId, this.title, this.description, this.status, this.onSaved});

  @override
  State<EmployeeTypeForm> createState() => _EmployeeTypeFormState();
}

class _EmployeeTypeFormState extends State<EmployeeTypeForm> {
  String title = '';
  String description = '';
  int status = 1;
  
  List<Errors> errorBags = [];

  @override
  void initState() {
    super.initState();
    if (widget.editId != null) {
      title = widget.title ?? '';
      description = widget.description ?? '';
      status = widget.status ?? 1;
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
          context.read<HrCubit>().createEmployeeType({
            'id': widget.editId ?? '',  
            'name': title,
            'description': description, 
            'status': status, 
          }).then((value) {  
            alert(context, value.message ?? '');  
            if(widget.onSaved != null) widget.onSaved!(); 
            Navigator.pop(context, { 'status': value.status, 'message': value.message});
          });
        }, 
      ),
      appBar: AppBar(
        title: const Text('Employee Type Update or Create'),
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        
        log('State: $state'); 
        
        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is ChangeStatusState) {
          status = state.status;
        }

        if (state is TitleState) {
          title = state.title;
        }
        
        if (state is ValidationErrorState) { 
          log('Error: ${state.errors}');    
            // errorBags = state.errors;
          }
 
        if (state is DescriptionState) {
          description = state.description;
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
              initialValue: title,
              onChanged: (value) {
                context.read<HrCubit>().changeTitle(value);
              },
              isMandatory: true,
              label: 'Title', 
              hintText: 'Enter title',
            ),
            XInput(
              initialValue: description,
              onChanged: (value) {
                context.read<HrCubit>().changeDescription(value);
              },
              height: 0.1,
              isMandatory: true,
              label: 'Description',
              hintText: 'Enter description',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Active',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  value: status == 1 ? true : false,
                  onChanged: (value) {
                    context.read<HrCubit>().changeStatus(value ? 1 : 0);
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ],
        ));
      }),
    );
  }
}
