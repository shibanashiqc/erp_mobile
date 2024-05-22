// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/sales/customers_model.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  List<Data> data = [];   
  
  void loadData({query}) async { 
    loading = true;
    await context.read<HrCubit>().getCustomers(query: {
      'name': query,
    }).then((value) {
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
        create: (context) => HrCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton( 
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/sales/create_customers',); 
            }, 
          )
        ],
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedHrState) {
          log('Loaded');
        }

        if (state is LoadingHrState) {
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
                        onChanged: (value) {
                          loadData(query: value);  
                        },
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),
                   
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(), 
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: data.length, 
                        itemBuilder: (context, index) {
                          return BuildCustomerList(
                            data: data[index],  
                          );
                        },
                      ), 
                      
                      
                    ],
                  ));
      }),
    );
  }
}

class BuildCustomerList extends StatelessWidget {
   Data data;
   BuildCustomerList({
    super.key,
    required this.data, 
  });

  @override
  Widget build(BuildContext context) {
    return XCard( 
      child: Column(
        children: [
          Items(
            items: [
              ItemListModel(name: 'NAME', value: data.name ?? ''),
              ItemListModel(name: 'EMAIL', value:  data.email ?? ''),
              ItemListModel(name: 'PHONE', value: data.phone ?? ''),
              ItemListModel(name: 'CREATED AT', value: data.createdAt ?? ''), 
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
                            context.push('/sales/create_customers', extra: {
                              'id': data.id,    
                              'extra': data  
                            }); 
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ]
                    ),
                    
                  ],
                ),
                
               const SizedBox(height: 10), 
                
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text('VIEW INVOICE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                //     InkWell(
                //       onTap: () {
                //         context.push('/sales/view_invoice');
                //       },
                //       child: const Icon(CupertinoIcons.eye),
                //     ), 
                //   ],
                // ), 
                
              ],
            ),
          ),  
          
          
        ],
      ),
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