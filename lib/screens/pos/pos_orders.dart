// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/pos_order_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/hr/department.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PosOrder extends StatefulWidget {
  const PosOrder({super.key});

  @override
  State<PosOrder> createState() => _PosOrderState();
}

class _PosOrderState extends State<PosOrder> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  List<Data> data = [];
  int limit = 10;  
  late ScrollController controller;
  bool isLoad = false;
  
  void lodaData({query}) async {
    isLoad = true;
    // loading = true;
    setState(() {
    }); 
    await context.read<MainCubit>().getPosOrders(
      limit: limit, 
      query: {
      'search': query,  
    }).then((value) { 
       isLoad = false;   
       data = value.data!; 
      setState(() { 
      });
    }); 
  }
  
  void _scrollListener() {
  if (controller.position.extentAfter == 0.0) { 
    limit = limit + 10;  
    lodaData();
  } 
}  
  
  @override
  void initState() { 
    super.initState();
    lodaData(); 
    controller = ScrollController()..addListener(_scrollListener);
    // final orders = context.read<MainCubit>().getPosOrders();
    // loading = true;
    // orders.then((value) { 
    //   data = value.data!; 
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Orders'),
        actions: [
          IconButton( 
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/pos');
            }, 
          )
        ],
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        
        if (state is ErrorMainState) {
          log('Error: $state');
        }

        if (state is LoadedMainState) {
          log('Loaded');
        }

        if (state is LoadedMainState) {
          log('Loading');
        }
        
      }, builder: (context, state) {
        return XContainer(
            controller: controller,
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
                          itemCount: data.length, 
                          itemBuilder: (context, index) {
                            return XList(
                              onTap: () {}, 
                              title: '', 
                              subtitle: '',
                              status: 1,
                            );
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
                          lodaData(query: value); 
                        },
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by order number / name',
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>  XCard( 
                          child: Column(
                            children: [
                              Items(
                                items: [
                                  ItemListModel(name: 'DATE', value: data[index].createdAt ?? ''),
                                  ItemListModel(name: 'PHONE', value: data[index].phone ?? ''), 
                                  ItemListModel(name: 'SALES ORDER#', value: data[index].id.toString()),
                                  ItemListModel(name: 'CUSTOMER NAME', value: data[index].customer?.name ?? ''),
                                  ItemListModel(name: 'SUB TOTAL', value: data[index].subTotal.toString()),
                                  ItemListModel(name: 'TOTAL', value: data[index].grandTotal.toString()), 
                                ]
                              ),  
                              
                              
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    
                                   const SizedBox(height: 10), 
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('VIEW INVOICE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                                        InkWell( 
                                          onTap: () { 
                                            context.push('/pos/receipts', extra: {
                                                'extra': { 
                                                  'data': data[index], 
                                                  'products': data[index].items
                                                }  
                                              });
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
                      
                      
                      const SizedBox(height: 10),
                      if (isLoad == true) 
                        const Center(child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator()
                          ))
                      
                      
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