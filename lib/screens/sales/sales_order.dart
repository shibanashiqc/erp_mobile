// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/sales_orders_model.dart';
import 'package:erp_mobile/models/sales/sales_recieve_balance_model.dart'
    as salesReciveBalanceModel;
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/dynamic.dart';
import 'package:erp_mobile/screens/sales/balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SalesOrder extends StatefulWidget {
  const SalesOrder({super.key});

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  List<Data> data = [];
  late ScrollController controller;
  bool isLoad = false;
  int limit = 10;

  // PdfController pdfController;

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      log('Limit: $limit');
      loadData();
    }
  }

  loadScreen() {
    setState(() {});
  }

  void loadData({query = ''}) async {
    // loading = true;
    isLoad = true;
    setState(() {});
    await context
        .read<MainCubit>()
        .getSalesOrders(limit: limit, search: query)
        .then((value) {
      setState(() {
        data = value.data!;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    controller = ScrollController()..addListener(_scrollListener);
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
                  extra: {'onSaved': loadData});
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
                          hintText: 'Search by order number / phone / email',
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
                        hintText: 'Search by order number / phone / email',
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
                        itemBuilder: (context, index) => XCard(
                          child: Column(
                            children: [
                              Items(items: [
                                ItemListModel(
                                    name: 'DATE',
                                    value: data[index].orderDate ?? ''),
                                ItemListModel(
                                    name: 'PHONE',
                                    value: data[index].phone ?? ''),
                                ItemListModel(
                                    name: 'SALES ORDER#',
                                    value: data[index].id.toString()),
                                ItemListModel(
                                    name: 'REFERENCE#',
                                    value: data[index].reference ?? ''),
                                ItemListModel(
                                    name: 'PAID AMOUNT',
                                    value: data[index].paidAmount ?? ''),
                                ItemListModel(
                                    name: 'BALANCE AMOUNT',
                                    value: data[index].balanceAmount ?? ''),
                                double.parse(data[index].balanceAmount ?? '') >
                                        0
                                    ? ItemListModel(
                                        name: 'COLLECT BALANCE',
                                        value: 'DUE',
                                        isColored: true,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Dynamic(
                                                  sectionTitle:
                                                      'Collect Balance',
                                                  child: BalanceWidget(
                                                    refresh: loadData,
                                                    data: data[index],
                                                  )),
                                            ),
                                          );
                                        },
                                      )
                                    : ItemListModel(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Dynamic(
                                                  sectionTitle:
                                                      'Collect Balance',
                                                  child: BalanceWidget(
                                                    refresh: loadData,
                                                    data: data[index],
                                                  )),
                                            ),
                                          );
                                        },
                                        name: 'COLLECT BALANCE',
                                        value: 'PAID', isColored: true),
                                ItemListModel(
                                    name: 'CUSTOMER NAME',
                                    value: data[index].customer?.name ?? ''),
                                ItemListModel(
                                    name: 'BILL DATE',
                                    value: data[index].createdAt ?? ''),
                              ]),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('ACTION',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Row(children: [
                                          InkWell(
                                            onTap: () {
                                              context.push(
                                                  '/sales/view_sales_orders',
                                                  extra: {
                                                    'extra': data[index],
                                                    'onSaved': loadData
                                                  });
                                            },
                                            child: const Icon(
                                                Icons.remove_red_eye_outlined),
                                          ),
                                        ]),
                                      ],
                                    ),

                                    //  const SizedBox(height: 10),

                                    //   Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       const Text('VIEW INVOICE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)) ,
                                    //       InkWell(
                                    //         onTap: () {
                                    //           context.push('/sales/view_invoice');
                                    //         },
                                    //         child: const Icon(CupertinoIcons.eye),
                                    //       ),
                                    //     ],
                                    //   ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      if (isLoad == true)
                        const Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()))
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
            .map((e) => InkWell(
                  onTap: e.onTap ?? () {},
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${e.name} : ',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          e.isColored == true ?
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(e.value,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ) : 
                          Text(e.value,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ItemListModel {
  final String name;
  final String value;
  Function()? onTap;
  bool isColored = false;

  ItemListModel({
    required this.name,
    required this.value,
    this.isColored = false,
    this.onTap,
  });
}
