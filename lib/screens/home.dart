import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/models/pos/pos_order_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_dashboard_card.dart';
import 'package:erp_mobile/screens/common/x_menu.dart';
import 'package:erp_mobile/screens/common/x_menu_item.dart';
import 'package:erp_mobile/screens/dashboard.dart';
import 'package:erp_mobile/screens/dynamic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<_SalesData> data = [];
  List<_SalesData> dataExpense = [];
  List<Product> lowQuantityProducts = [];
  List<Product> expiredProducts = [];

  List<dynamic> modules = [];

  String totalIncome = '0.00';
  String totalExpense = '0.00';
  String totalStaffs = '0';
  String totalPurchase = '0.00';
  String totalSales = '0.00';
  String totalBalance = '0.00';
  String totalPos = '0.00';
  String totalProducts = '0.00';

  IconData getRandomIcon() {
    final List<int> points = <int>[0xe0b0, 0xe0b1, 0xe0b2, 0xe0b3, 0xe0b4];
    final Random random = Random();
    const String chars = '0123456789ABCDEF';
    int length = 3;
    String hex = '0xe';
    while (length-- > 0) {
      hex += chars[(random.nextInt(16)) | 0];
    }
    return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
  }

  double generateHeight(count) {
    if (count == 3) {
      return 0.15;
    }

    if (count == 4) {
      return 0.2;
    }

    if (count == 5) {
      return 0.25;
    }

    if (count == 6) {
      return 0.3;
    }

    if (count == 7) {
      return 0.35;
    }

    if (count == 8) {
      return 0.4;
    }

    if (count == 9) {
      return 0.45;
    }

    if (count == 10) {
      return 0.5;
    }

    return 0.0;
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await context.read<LoginCubit>().getLoggedUser().then((value) async {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          modules = json.decode(prefs.getString('modules') ?? '[]');
          modules.removeWhere((element) => element['slug'] == 'dashboard');

          for (var item in value['data']['extra']['monthly_income']) {
            data.add(_SalesData(
                item['label'], double.parse(item['data'].toString())));
          }

          for (var item in value['data']['extra']['monthly_expence']) {
            dataExpense.add(_SalesData(
                item['label'], double.parse(item['data'].toString())));
          }

          totalIncome = value['data']['extra']['year_by_income'].toString();
          totalExpense = value['data']['extra']['year_by_expence'].toString();
          totalStaffs = value['data']['extra']['staffs'].toString();
          totalPurchase =
              value['data']['extra']['purchase_products'].toString();
          totalSales = value['data']['extra']['total_sales'].toString();
          totalBalance = value['data']['extra']['total_balance'].toString();
          totalPos = value['data']['extra']['total_pos'].toString();
          totalProducts = value['data']['extra']['total_products'].toString();
          lowQuantityProducts =
              (value['data']['extra']['low_quantity_products'] as List)
                  .map((e) => Product.fromJson(e))
                  .toList();
          expiredProducts = (value['data']['extra']['expired_products'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
        } catch (e) {
          // log(e.toString());
        }
      });

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return XContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalIncome',
                subTitle: 'Total Income ',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.lock_shield_fill,
                title: '₹ $totalExpense',
                subTitle: 'Total Expense',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.person_2_alt,
                title: totalStaffs,
                subTitle: 'Total Staffs',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.bag_fill,
                title: '₹ $totalPurchase',
                subTitle: 'Total Purchase',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalSales',
                subTitle: 'Total Sales',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalBalance',
                subTitle: 'Total Balance',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalPos',
                subTitle: 'Total Pos',
                bottomText: 'This Year',
                value: '',
              ),
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalProducts',
                subTitle: 'Total Products',
                bottomText: 'This Year',
                value: '',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Sales Overview',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              XCard(
                child: Column(children: [
                  SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      title: const ChartTitle(
                          text: 'Monthly Salary Analytics',
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.secondaryColor)),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<_SalesData, String>>[
                        ColumnSeries<_SalesData, String>(
                            dataSource: data,
                            xValueMapper: (_SalesData sales, _) => sales.year,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]),
                ]),
              ),

              const SizedBox(height: 10),

              XCard(
                child: Column(children: [
                  SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      title: const ChartTitle(
                          text: 'Expense Analytics',
                          textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.secondaryColor)),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<_SalesData, String>>[
                        LineSeries<_SalesData, String>(
                            dataSource: dataExpense,
                            xValueMapper: (_SalesData sales, _) => sales.year,
                            yValueMapper: (_SalesData sales, _) => sales.sales,
                            name: 'Sales',
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true))
                      ]),
                ]),
              ),

              const SizedBox(height: 10),

              //rounded bar chart

              // XCard(
              //   child: Column(children: [
              //     SfCircularChart(
              //         title: const ChartTitle(
              //             text: 'Sales Analytics',
              //             textStyle: TextStyle(
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.bold,
              //                 color: ColorConstants.secondaryColor)),
              //         legend: const Legend(isVisible: true),
              //         tooltipBehavior: TooltipBehavior(enable: true),
              //         series: <CircularSeries<_SalesData, String>>[
              //           PieSeries<_SalesData, String>(
              //               dataSource: data,
              //               xValueMapper: (_SalesData sales, _) => sales.year,
              //               yValueMapper: (_SalesData sales, _) => sales.sales,
              //               name: 'Sales',
              //               // Enable data label
              //               dataLabelSettings:
              //                   const DataLabelSettings(isVisible: true))
              //         ]),
              //   ]),
              // ),
            ],
          ),
          const SizedBox(height: 20),

          InkWell(
            child: XCard(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Expired Products',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primaryColor)),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Dynamic(
                        sectionTitle: 'Expired Products',
                        child: XCard(
                            showChild: expiredProducts.isNotEmpty,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text('Expired Products',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.red[100],
                                    child: const Text(
                                        'Note: These products are expired. Please remove these products from your inventory.',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: expiredProducts.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              ColorConstants.primaryColor,
                                          backgroundImage: NetworkImage(
                                              expiredProducts[index].image ??
                                                  ''),
                                        ),
                                        title: Text(
                                            expiredProducts[index].name ?? ''),
                                        subtitle: Text(
                                            'Expiry Date: ${expiredProducts[index].expiryDate}'),
                                        trailing: InkWell(
                                          onTap: () {
                                            context.push('/product/add_product',
                                                extra: {
                                                  'id':
                                                      expiredProducts[index].id,
                                                  'extra':
                                                      expiredProducts[index]
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Text('VIEW',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ));
                                  },
                                )
                              ],
                            )))),
              );
            },
            // child:
          ),

          const SizedBox(height: 20),

          InkWell(
            child: XCard(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Low Quantity Products',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primaryColor)),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Dynamic(
                        sectionTitle: 'Low Quantity Products',
                        child: XCard(
                            showChild: lowQuantityProducts.isNotEmpty,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text('Low Quantity Products',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.red[100],
                                    child: const Text(
                                        'Note: These products are running out of stock. Please add more quantity to these products.',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lowQuantityProducts.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              ColorConstants.primaryColor,
                                          backgroundImage: NetworkImage(
                                              lowQuantityProducts[index]
                                                      .image ??
                                                  ''),
                                        ),
                                        title: Text(
                                            lowQuantityProducts[index].name ??
                                                ''),
                                        subtitle: Text(
                                            'Quantity: ${lowQuantityProducts[index].quantity}'),
                                        trailing: InkWell(
                                          onTap: () {
                                            context.push('/product/add_product',
                                                extra: {
                                                  'id':
                                                      lowQuantityProducts[index]
                                                          .id,
                                                  'extra':
                                                      lowQuantityProducts[index]
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Text('Fill QTY',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ));
                                  },
                                )
                              ],
                            )))),
              );
            },
            // child: ),
          ),

          const SizedBox(height: 20),

          // ListView(
          //   shrinkWrap: true,
          //   children: modules.map((module) {
          //     return  XMenu(
          //       height: generateHeight(module['items'].length),
          //       sectionTitle: module['name'],
          //       children: [
          //         for (var subModule in module['items'])
          //           XMenuItem(
          //             icon: getRandomIcon(),
          //             onTap: () {
          //               context.pushNamed(subModule['route']);
          //             },
          //             title: subModule['name'],
          //           ),
          //       ],
          //     );
          //   }).toList(),
          // ), 
 
         
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
