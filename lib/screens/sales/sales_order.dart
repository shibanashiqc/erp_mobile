// ignore_for_file: must_be_immutable

import 'dart:developer';

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

class SalesOrder extends StatefulWidget {
  const SalesOrder({super.key});

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  List<Data> data = [];
  
  void loadData ({query = ''}) async
  {
    // loading = true;
    await context.read<MainCubit>().getSalesOrders(search: query).then((value) {
        setState(() {
          data = value.data!; 
          loading = false;
        }); 
      });
     
  }
  
  @override
  void initState() { 
    super.initState();
    loadData(); 
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
              context.push('/sales/create_sales_orders');
            }, 
          )
        ],
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        
        if (state is ErrorMainState) {
          log('Error: ${state}');
        }

        if (state is LoadedMainState) {
          log('Loaded');
        }

        if (state is LoadedMainState) {
          log('Loading');
        }
        
      }, builder: (context, state) {
        return SingleChildScrollView (
          child: XContainer(
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
                          onChanged: (value) {
                            loadData(query: value); 
                          },
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
                          itemCount: data.length,
                          separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>  XCard( 
                            child: Column(
                              children: [
                                Items(
                                  items: [
                                    ItemListModel(name: 'DATE', value: data[index].orderDate ?? ''),
                                    ItemListModel(name: 'PHONE', value: data[index].phone ?? ''), 
                                    ItemListModel(name: 'SALES ORDER#', value: data[index].id.toString()),
                                    ItemListModel(name: 'REFERENCE#', value:  data[index].reference ?? ''),
                                    ItemListModel(name: 'PAID AMOUNT', value: data[index].paidAmount ?? ''),
                                    ItemListModel(name: 'BALANCE AMOUNT', value: data[index].balanceAmount ?? ''),
                                    ItemListModel(name: 'CUSTOMER NAME', value: data[index].customer?.name ?? ''),
                                    ItemListModel(name: 'CREATED AT', value: data[index].createdAt ?? ''), 
                                  ]
                                ),  
                                
                                
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('ACTION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                                          
                                          Row( 
                                            children: [
                                              InkWell(  
                                                onTap: () { 
                                                  context.push('/sales/view_sales_orders', extra: {'extra': data[index]});
                                                },
                                                child: const Icon(Icons.edit),
                                              ),
                                            ]
                                          ),
                                          
                                        ],
                                      ),
                                      
                                     const SizedBox(height: 10), 
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('VIEW INVOICE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                                          InkWell(
                                            onTap: () { 
                                              context.push('/sales/view_invoice');
                                            },
                                            child: const Icon(CupertinoIcons.eye),
                                          ), 
                                        ],
                                      ), 
                                      
                                    ],
                                  ),
                                ),  
                                
                                
                              ],
                            ),
                          ),
                        ),
                        
                        
                      ],
                    )),
        );
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
      child:  Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start, 
        children: items.map((e) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${e.name} : ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                Text(e.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
            
            const SizedBox(height: 5), 
            
          ],
        )).toList(),
        
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