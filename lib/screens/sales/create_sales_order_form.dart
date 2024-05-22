// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart';
import 'package:erp_mobile/models/sales/sales_orders_model.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class CreateSalesOrder extends StatefulWidget {
  dynamic data = {};
  CreateSalesOrder({super.key,  this.data});

  @override
  State<CreateSalesOrder> createState() => _CreateSalesOrderState();
}

class _CreateSalesOrderState extends State<CreateSalesOrder> {
  bool loading = true;
  List<SalesOrderItems> salesItems = [];
  List<Customers>? customers = [];
  List<Products>? products = [];
  List<PaymentTerms>? paymentTerms = [];
  List<SalesPersons>? salesPersons = [];

  dynamic customerId;
  dynamic salesPersonId;
  dynamic paymentTermId;
  dynamic productId;
  dynamic editId;

  String email = '';
  String phone = '';
  String orderNumber = '';
  String reference = '';
  String orderDate = '';
  String shipDate = '';
  String notes = '';
  List<Errors> errorBags = [];
  double totalAmount = 0.0;
  double paidAmount = 0.0;
  double balanceAmount = 0.0;
  int payTermValue = 0;
  
  calculate(discount) {
    totalAmount = salesItems.fold(0, (previousValue, element) => int.parse(double.parse(element.totalPrice.toString()).toStringAsFixed(0)) + previousValue).toDouble();
    paidAmount = totalAmount * (discount / 100);
    balanceAmount = totalAmount - paidAmount;
    setState(() {});
  }
  

  void setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'customer_id':
        customerId = state.value;
        break;
      case 'sales_person_id':
        salesPersonId = state.value;
        break;
      case 'payment_term_id':
        paymentTermId = state.value;
        break;
      case 'product_id':
        productId = state.value;
        break;
      case 'email':
        email = state.value;
        break;
      case 'phone':
        phone = state.value;
        break;
      case 'order_number':
        orderNumber = state.value;
        break;
      case 'reference':
        reference = state.value;
        break;
      case 'order_date':
        orderDate = state.value;
        break;
      case 'ship_date':
        shipDate = state.value;
        break;
      case 'notes':
        notes = state.value;
        break;
    }
  }

  DateTime focusedDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    
      log(widget.data.toString() ); 
    
    if (widget.data != null) {
      customerId = widget.data['customer_id'].toString();
      editId = widget.data['id'].toString(); 
      email = widget.data['email'].toString();
      phone = widget.data['phone'].toString(); 
    }
    
    orderNumber = '${DateTime.now().millisecondsSinceEpoch}'; 
    orderDate = DateTime.now().toString();
    shipDate = DateTime.now().toString();
    reference = '${DateTime.now().millisecondsSinceEpoch}';
    
    final salesExra = context.read<MainCubit>().getExtraSales();
    salesExra.then((value) {
      customers = value.data?.customers;
      products = value.data?.products;
      paymentTerms = value.data?.paymentTerms;
      salesPersons = value.data?.salesPersons;
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: XButton(
        label: 'Save',
        onPressed: () {
          context.read<MainCubit>().createSalesOrder({
            'id': editId, 
            'customer_id': customerId,
            'sales_person_id': salesPersonId,
            'payment_term_id': paymentTermId,
            'product_id': productId,
            'email': email,
            'phone': phone,
            'order_number': orderNumber,
            'reference': reference,
            'order_date': orderDate,
            'ship_date': shipDate,
            'notes': notes, 
            'paid_amount' : paidAmount.toString(),
            'balance_amount' : balanceAmount.toString(),
            'sales_order_items' : salesItems.map((e) => e.toJson()).toList(),
            'sub_total' : salesItems.fold(0, (previousValue, element) => int.parse(double.parse(element.totalPrice.toString()).toStringAsFixed(0)) + previousValue).toString(), 
            'total' : salesItems.fold(0, (previousValue, element) => int.parse(double.parse(element.totalPrice.toString()).toStringAsFixed(0)) + previousValue).toString()
          }).then((value) {
            if (value.status == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sales Order Created'))); 
              context.pop();  
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Create Sales Orders'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       context.push('/department/update_or_create');
        //     },
        //   )
        // ],
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) {
          log('Loaded');
        }

        if (state is LoadingMainState) {
          log('Loading');
        }

        if (state is ChangeFormValuesState) {
          setValue(state);
        }

        if (state is ValidationErrorState) {
          log('Validation Error');
          errorBags = state.errors;
        }
      }, builder: (context, state) {
        return XContainer(
            child: loading == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        XInput(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: ColorConstants.secondaryColor,
                          ),
                          hintText: 'Search by name',
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            // return XList(
                            //   onTap: () {},
                            //   title: '',
                            //   subtitle: '',
                            //   status: 1,
                            // );
                          },
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Customer Name

                        XSelect(
                            errorBags: errorBags,
                            model: 'customer_id',
                            label: 'Customer Name',
                            value: customerId,
                            options: customers?.map((e) {
                                  return DropDownItem(
                                      value: e.id.toString(), label: e.name);
                                }).toList() ??
                                [],
                            onChanged: (val) {
                              context
                                  .read<MainCubit>()
                                  .changeFormValues('customer_id', val);
                            }),

                        XInput(
                          initialValue: email,
                          errorBags: errorBags,
                          model: 'email',
                          label: 'Enter Email',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('email', value);
                          },
                          hintText: 'Email',
                        ),

                        XInput(
                          initialValue: phone,    
                          errorBags: errorBags,
                          model: 'phone',
                          label: 'Enter Phone',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('phone', value);
                          },
                          hintText: 'Phone',
                        ),

                        XInput(
                          initialValue: orderNumber,
                          errorBags: errorBags,
                          model: 'order_number',
                          label: 'Enter Sales Order#',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('order_number', value);
                          },
                          hintText: 'Sales Order#',
                        ),

                        XInput(
                          initialValue: reference,
                          errorBags: errorBags,  
                          label: 'Enter Reference',
                          model: 'reference',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('reference', value);
                          },
                          hintText: 'Reference',
                        ),

                        XInput(
                          errorBags: errorBags,
                          initialValue: orderDate,
                          model: 'order_date',
                          type: 'date',
                          label: 'Enter Sales Order Date',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('order_date', value);
                          },
                          hintText: 'Sales Order Date',
                        ),

                        XInput(
                          errorBags: errorBags,
                          initialValue: shipDate,
                          type: 'date',
                          label: 'Enter Shipment Date',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('ship_date', value);
                          },
                          model: 'ship_date',
                          hintText: 'Shipment Date',
                        ),

                        XSelect(
                            errorBags: errorBags,
                            value: paymentTermId,
                            model: 'payment_term_id',
                            onChanged: (val) {
                              context
                                  .read<MainCubit>()
                                  .changeFormValues('payment_term_id', val);
                                  
                                  if(paymentTerms?.where((element) => element.id == int.parse(val)).first.percentage != null) {
                                    payTermValue = paymentTerms?.where((element) => element.id == int.parse(val)).first.percentage!; 
                                    calculate(paymentTerms?.where((element) => element.id == int.parse(val)).first.percentage!); 
                                    for (var element in salesItems) {
                                      element.paymentTermId = int.parse(val); 
                                    }
                                  } 
                                  
                            },
                            label: 'Payment Terms',
                            options: paymentTerms?.map((e) {
                                  return DropDownItem(
                                      value: e.id.toString(), label: e.name);
                                }).toList() ??
                                []),

                        XSelect(
                            errorBags: errorBags,
                            value: salesPersonId,
                            model: 'sales_person_id',
                            onChanged: (val) {
                              context
                                  .read<MainCubit>()
                                  .changeFormValues('sales_person_id', val);
                                  for (var element in salesItems) {
                                      element.salesPersonId = int.parse(val); 
                                  }
                                  
                                  setState(() {});  
                            },
                            label: 'Sales Person',
                            options: salesPersons?.map((e) {
                                  return DropDownItem(
                                      value: e.id.toString(), label: e.name);
                                }).toList() ??
                                []),

                        XInput(
                          errorBags: errorBags,
                          model: 'notes',
                          height: 0.2,
                          label: 'Enter Notes',
                          onChanged: (value) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('notes', value);
                          },
                          hintText: 'Notes',
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Add Items',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            InkWell(
                              onTap: () {
                                salesItems.add(SalesOrderItems(
                                  id: 0,
                                  productId: null,
                                  quantity: 1,
                                  rate: '0.00',
                                  totalPrice: '0.00',
                                  orderNumber: orderNumber,
                                  reference: reference,
                                  orderDate: orderDate,
                                  shipDate: shipDate,
                                  paymentTermId: paymentTermId,
                                  salesPersonId: salesPersonId,
                                ));

                                setState(() {});
                              },
                              child: const Icon(Icons.add),
                            )
                          ],
                        ),

                        salesItems.isEmpty
                            ? const SizedBox()
                            : Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: salesItems.length,
                                    itemBuilder: (context, index) {
                                      return XCard(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text('ITEM ${index + 1}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                  const SizedBox(width: 10),
                                                  InkWell(
                                                    onTap: () {
                                                      salesItems.removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons.delete,
                                                      color: Colors.red,
                                                      size: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              XSelect(
                                                value: salesItems[index]
                                                    .productId
                                                    ?.toString(),
                                                onChanged: (val) {
                                                  salesItems[index].productId =
                                                      int.parse(val);
                                                      
                                                  salesItems[index].rate = products!
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          int.parse(val))
                                                      .price 
                                                      .toString();
                                                  salesItems[index].totalPrice = salesItems[index]
                                                                  .rate
                                                                  .toString();
                                                  setState(() {});  
                                                },
                                                label: 'Item Name',
                                                options: products?.map((e) {
                                                      return DropDownItem(
                                                          value: e.id.toString(),
                                                          label: e.name);
                                                    }).toList() ??
                                                    [],
                                              ),
                                              XInput(
                                                onlyCard: true, 
                                                readOnly: true,
                                                initialValue: salesItems[index]
                                                    .rate
                                                    .toString(),
                                                label: 'Price',
                                                onChanged: (value) {
                                                  // salesItems[index].price = double.parse(value);
                                                },
                                                hintText: 'Price',
                                              ),
                                              XInput(
                                                label: 'Enter Quantity',
                                                initialValue: salesItems[index]
                                                    .quantity
                                                    .toString(), 
                                                onChanged: (value) {
                                                  salesItems[index].quantity = int.parse(value);
                                                  salesItems[index].totalPrice = (salesItems[index].quantity * double.parse(salesItems[index].rate.toString())).toString();
                                                  setState(() {});
                                                  calculate(payTermValue); 
                                                },
                                                hintText: 'Quantity',
                                              ),
                                              XInput(
                                                onlyCard: true,  
                                                readOnly: true,
                                                label: 'Total',
                                                initialValue: salesItems[index]
                                                    .totalPrice 
                                                    .toString(),
                                                onChanged: (value) {
                                                  // salesItems[index].total = double.parse(value);
                                                },
                                                hintText: 'Total',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  
                                                            
                              ],
                            ),
                            
                             Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    const Text('TOTAL AMOUNT: '),
                                    const SizedBox(width: 10), 
                                    Text(salesItems.fold(0, (previousValue, element) => int.parse(double.parse(element.totalPrice.toString()).toStringAsFixed(0)) + previousValue).toString())
                                  ],),
                                  
                            Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    const Text('PAID AMOUNT: '),
                                    const SizedBox(width: 10), 
                                    Text(paidAmount.toString())
                                  ],),  
                                  
                            Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    const Text('BALANCE AMOUNT: '),
                                    const SizedBox(width: 10), 
                                    Text(balanceAmount.toString())
                                  ],),    

                        const SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ));
      }),
    );
  }
}

class SalesItemModel {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final double total;
  SalesItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });
}
