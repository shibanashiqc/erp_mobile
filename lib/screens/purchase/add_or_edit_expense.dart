// ignore_for_file: must_be_immutable


import 'dart:developer';

import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/purchase/expene_model.dart' as purchase;
import 'package:erp_mobile/models/purchase/extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class AddOrEditExpense extends StatefulWidget {
   dynamic editId;
   purchase.Data? data;
   AddOrEditExpense({
    this.editId,
    this.data, 
    super.key,
  }); 

  @override
  State<AddOrEditExpense> createState() => _AddOrEditExpenseState();
}

class _AddOrEditExpenseState extends State<AddOrEditExpense> {
  
  String date = '';
  dynamic categoryId;
  String amount = '0';
  dynamic purchaseVendorId;
  String invoice = '';
  String note = '';
  dynamic customerId;
  File image = File('');
  
  List<Customers> customers = [];
  List<Category> categories = [];
  List<Vendors> vendors = [];  
    
  
  @override
  void initState() {
    super.initState(); 
    
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      
     await context.read<HrCubit>().getExtra().then((value) { 
        customers = value.data?.customers ?? []; 
        categories = value.data?.category ?? [];
        vendors = value.data?.vendors ?? [];    
        setState(() { 
        });  
      });


      
    });
    
    if (widget.editId != null) {
        date = widget.data?.date ?? '';
        categoryId = widget.data?.categoryId.toString() ?? '';
        amount = widget.data?.amount ?? '';
        purchaseVendorId = widget.data?.purchaseVendorId.toString() ?? '';
        invoice = widget.data?.invoice ?? '';
        note = widget.data?.note ?? '';
        customerId = widget.data?.customerId.toString() ?? '';
    }
  }
  
  set setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'date':
        date = state.value;
        break;
      case 'category_id':
        categoryId = state.value;
        break;
      case 'amount':
        amount = state.value;
        break;
      case 'purchase_vendor_id':
        purchaseVendorId = state.value;
        break;
      case 'invoice':
        invoice = state.value;
        break;
      case 'note':
        note = state.value;
        break;
      case 'customer_id':
        customerId = state.value;
        break;
      case 'image':
        image = state.value;
        break;
      default:
    }
  }
  
  List<Errors> errorBags = [];
  
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
          context.read<HrCubit>().creatExpense({
            'edit_id' : widget.editId,  
            'date': date,
            'category_id': categoryId,
            'amount': amount,
            'purchase_vendor_id': purchaseVendorId,
            'invoice': invoice,
            'note': note,
            'customer_id': customerId,
            'image': image,
           
          }).then((value) {
            if (value.status == 'error') {
              errorBags = value.errors!;
              setState(() {
              });
             return;
            }

             ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.message.toString())));
          //  widget.onSaved != null ? widget.onSaved!() : null;
           context.push('/dashboard');
          });
        }, 
      ), 
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
         if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        // if (state is ValidationErrorState) {
        //   errorBags = state.errors; 
        //   setState(() {
        //   }); 
        // } 

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
          return SingleChildScrollView( 
            child: Container(
              color: Colors.white,
              child: Padding( 
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    
                    const SizedBox(height: 10), 
                    const Text('Add Expense', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),), 
                    
                    XInput(
                      model: 'date',
                      color: const Color.fromRGBO(0, 0, 0, 0.1), 
                      type: 'date',
                      label: 'Date',
                      initialValue: date,
                      hintText: 'Select Date', 
                      onChanged: (value) => context.read<HrCubit>().setValues('date', value), 
                    ),
                    
                    XSelect( 
                      model: 'category_id',
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                      label: 'Category',
                      value: categoryId,
                      options: categories.map((e) => DropDownItem(
                          value: e.id.toString(),
                          label: e.name, 
                        )).toList(), 
                      onChanged: (value) => context.read<HrCubit>().setValues('category_id', value),
                    ),
                    
                    XInput( 
                      model: 'amount', 
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                      keyboardType: TextInputType.number,
                      label: 'Amount',
                      initialValue: amount,
                      hintText: 'Enter Amount', 
                      onChanged: (value) => context.read<HrCubit>().setValues('amount', value),
                    ),
                    
                    XSelect(
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                      label: 'Purchase Vendor',
                      value: purchaseVendorId,
                      options: vendors.map((e) => DropDownItem(
                          value: e.id.toString(),
                          label: e.name,
                        )).toList(), 
                      onChanged: (value) => context.read<HrCubit>().setValues('purchase_vendor_id', value),
                    ), 
                    
                    XInput( 
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                      label: 'Invoice',
                      initialValue: invoice,
                      hintText: 'Enter Invoice', 
                      onChanged: (value)  => context.read<HrCubit>().setValues('invoice', value),
                    ),  
                    
                    XInput( 
                      height: 0.1,
                      label: 'Note',
                      color: const Color.fromRGBO(0, 0, 0, 0.1), 
                      initialValue: note,
                      hintText: 'Enter Note', 
                      onChanged: (value) => context.read<HrCubit>().setValues('note', value),
                    ),
                    
                    XSelect(
                      color: const Color.fromRGBO(0, 0, 0, 0.1), 
                      label: 'Customer',
                      value: customerId,
                      options: customers.map((e) => DropDownItem(
                          value: e.id.toString(),
                          label: e.name,
                        )).toList(), 
                      onChanged: (value)  => context.read<HrCubit>().setValues('customer_id', value), 
                    ),
                    
                    XFileImage(
                      label: 'Image',
                      onChanged: (value) 
                      => context.read<HrCubit>().setValues('image', value),
                    ), 
                    
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
