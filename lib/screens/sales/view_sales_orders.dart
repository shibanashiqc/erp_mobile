// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import "package:collection/collection.dart";
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/sales_orders_model.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewSalesOrders extends StatefulWidget {
  dynamic salesOrder;
  ViewSalesOrders({super.key, this.salesOrder});

  @override
  State<ViewSalesOrders> createState() => _ViewSalesOrdersState();
}

class _ViewSalesOrdersState extends State<ViewSalesOrders> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  List<SalesOrderItems>? items = []; 
  Data data = Data(); 

  @override
  void initState() {
    super.initState();
    if (widget.salesOrder != null) {   
      data = Data.fromJson(widget.salesOrder);
      // group by sales person id
      items = data.salesOrderItems; 
      // ?.groupListsBy((element) => element.salesPersonId);
       
    } 
    // check it is list or not
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {  
              context.push('/sales/create_sales_orders', 
              extra: widget.salesOrder, 
              ); 
            },
          )
        ],
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
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XInput(
                        onChanged: (value) {},
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),
                      // TableCalendar(
                      //   firstDay: DateTime.utc(2010, 10, 16),
                      //   lastDay: DateTime.utc(2030, 3, 14),
                      //   focusedDay: focusedDay,
                      //   onDaySelected: (selectedDay, focusedDay) {
                      //     focusedDay = selectedDay;
                      //     setState(() {
                      //     });
                      //   },
                      // )

                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: items!.length,
                        shrinkWrap: true,  
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => XCard(
                          child: Column(
                            children: [ 
                              const SizedBox(height: 10), 
                              Text('DATE : ${items?[index].orderDate}',  
                                  style: const TextStyle( 
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Items(items: [
                                ItemListModel(name: 'REFERENCE', value: items?[index].reference ?? ''), 
                                ItemListModel(name: 'SALES MAN', value: items?[index].salesPerson?.name ?? ''), 
                                ItemListModel(name: 'NAME', value: data.customer?.name ?? ''), 
                                ItemListModel(name: 'EMAIL', value: data.email ?? ''), 
                                ItemListModel(name: 'PHONE', value: data.phone ?? ''), 
                                ItemListModel(name: 'ID', value: items?[index].id.toString() ?? ''), 
                                ItemListModel(name: 'DATE & TIME', value: items?[index].createdAt ?? ''),
                                ItemListModel(name: 'PAYMENT DUE DATE', value: items?[index].dueDate ?? ''), 
                                ItemListModel(name: 'BALANCE AMOUNT', value: items?[index].balanceAmount ?? '0.0'), 
                                ItemListModel(name: 'PAID AMOUNT', value: items?[index].paidAmount ?? '0.0'), 
                                ItemListModel(name: 'TOTAL AMOUNT', value: items?[index].totalPrice ?? '0.0'), 
                                
                              ]), 
                              const SizedBox(height: 10),
                              Padding( 
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text( items?[index].notes ?? ''),
                                    const SizedBox(height: 10), 
                                    const Text('PRODUCT',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    const SizedBox(height: 10),
                                    
                                    // Container(
                                    //   padding: const EdgeInsets.all(10),
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(color: Colors.grey),
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   child: Column(
                                    //     children: [
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text('ITEM',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold,
                                    //                   fontSize: 12)),
                                    //           Text('Men T-shirt',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold,
                                    //                   fontSize: 12)),
                                    //         ],
                                    //       ),
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text('QUANTITY',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold,
                                    //                   fontSize: 12)),
                                    //           Text('1',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //         ],
                                    //       ),
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text('PRICE',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold,
                                    //                   fontSize: 12)),
                                    //           Text('2000',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //         ],
                                    //       ),
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text('TOTAL',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold,
                                    //                   fontSize: 12)),
                                    //           Text('2000',
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 10),
                                    
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('ITEM',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(items?[index].product?.name ?? '', 
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                             const Text('QUANTITY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(items?[index].quantity.toString() ?? '', 
                                                  style: const TextStyle(
                                                      fontWeight: 
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                             const Text('PRICE',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(items?[index].rate.toString() ?? '', 
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                            const  Text('TOTAL',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                              Text(items?[index].totalPrice.toString() ?? '',
                                                  style: const TextStyle( 
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}

class Items extends StatelessWidget {
  List<ItemListModel> items = [];
  Items({
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items
            .map((e) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${e.name} : ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(e.value,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

class ItemListModel {
  final String name;
  final String value;

  ItemListModel({
    required this.name,
    required this.value,
  });
}
