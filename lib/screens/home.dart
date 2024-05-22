import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_dashboard_card.dart';
import 'package:erp_mobile/screens/common/x_menu.dart';
import 'package:erp_mobile/screens/common/x_menu_item.dart';
import 'package:erp_mobile/screens/dashboard.dart';
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
  
  List<dynamic> modules = [];

  String totalIncome = '0.00';
  String totalExpense = '0.00';
  String totalStaffs = '0';
  String totalPurchase = '0.00';
  String totalSales = '0.00';
  String totalBalance = '0.00';
  String totalPos = '0.00';
  String totalProducts = '0.00';
  
  IconData getRandomIcon(){
  final List<int> points = <int>[0xe0b0, 0xe0b1, 0xe0b2, 0xe0b3, 0xe0b4];
  final Random random = Random();
  const String chars = '0123456789ABCDEF';
  int length = 3;
  String hex = '0xe';
  while(length-- > 0) hex += chars[(random.nextInt(16)) | 0];
  return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
}

 double generateHeight(count)
  {
    if(count == 3)
    {
      return 0.15;
    }
    
    if(count == 4)
    {
      return 0.2;
    }
    
    if(count == 5)
    {
      return 0.25;
    }
    
    if(count == 6)
    {
      return 0.3;
    }
    
    if(count == 7)
    {
      return 0.35;
    }
    
    if(count == 8)
    {
      return 0.4;
    }
    
    if(count == 9)
    { 
      return 0.45;
    }
    
    if(count == 10)
    {
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
          totalPurchase =   value['data']['extra']['purchase_products'].toString();
          totalSales = value['data']['extra']['total_sales'].toString();
          totalBalance = value['data']['extra']['total_balance'].toString();
          totalPos = value['data']['extra']['total_pos'].toString();
          totalProducts = value['data']['extra']['total_products'].toString();    
              
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
            children: [
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalIncome',
                subTitle: 'Total Income ',
                bottomText: 'This Year',
                value: '22%',
              ),
              XDashboardCard(
                icon: CupertinoIcons.lock_shield_fill,
                title: '₹ $totalExpense',
                subTitle: 'Total Expense',
                bottomText: 'This Year',
                value: '22%',
              ),
              XDashboardCard(
                icon: CupertinoIcons.person_2_alt,
                title: totalStaffs, 
                subTitle: 'Total Staffs',
                bottomText: 'This Year',
                value: '22%',
              ),
              XDashboardCard(
                icon: CupertinoIcons.bag_fill,
                title: '₹ $totalPurchase',
                subTitle: 'Total Purchase',
                bottomText: 'This Year',
                value: '22%',
              ),
              
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalSales',
                subTitle: 'Total Sales',
                bottomText: 'This Year',
                value: '22%',
              ),
              
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalBalance',
                subTitle: 'Total Balance',
                bottomText: 'This Year',
                value: '22%',
              ),
              
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalPos',
                subTitle: 'Total Pos',
                bottomText: 'This Year',
                value: '22%',
              ), 
              
              XDashboardCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: '₹ $totalProducts',
                subTitle: 'Total Products',
                bottomText: 'This Year',
                value: '22%',
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
          
          
          XMenu(
            height: 0.15, 
            sectionTitle: 'HR Management',
            children: [
              XMenuItem(
                  isHidden: modules.where((element) => element['slug'] == 'hr-management').isEmpty ?? true,
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/department');
                  },
                  title: 'Departments'),
              XMenuItem(
                  icon: CupertinoIcons.doc_person,
                  onTap: () {
                    context.push('/employee_type');
                  },
                  title: 'Employee Types'),
              // XMenuItem(
              //     icon: Icons.design_services_outlined,
              //     onTap: () {},
              //     title: 'Designation'),
              XMenuItem(
                  icon: Icons.supervised_user_circle_sharp,
                  onTap: () {
                    context.push('/staff/update_or_create');
                  },
                  title: 'Staffs'),
              XMenuItem(
                  icon: CupertinoIcons.checkmark_shield,
                  onTap: () {
                    context.push('/role');
                  },
                  title: 'Roles'),
              // XMenuItem(
              //     icon: CupertinoIcons.money_dollar,
              //     onTap: () {
              //       context.push('/payroll');
              //     },
              //     title: 'Payroll'),
              // XMenuItem(
              //     icon: CupertinoIcons.doc_append,
              //     onTap: () {
              //       context.push('/salary_advance_request');
              //     },
              //     title: 'Salary Advance'),
              // XMenuItem(
              //     icon: CupertinoIcons.person_crop_circle_badge_checkmark,
              //     onTap: () {
              //       context.push('/attendance');
              //     },
              //     title: 'Attendance'),
              // XMenuItem(
              //     icon: Icons.mobile_friendly_outlined,
              //     onTap: () {
              //       context.push('/salaries');
              //     },
              //     title: 'Salaries'),
            ],
          ),
          const SizedBox(height: 10),
          XMenu(
            height: 0.15,
            sectionTitle: 'Sales Management',
            children: [
              XMenuItem(
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/sales/sales_orders');
                  },
                  title: 'Sales Order'),
              XMenuItem(
                  icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                  onTap: () {
                    context.push('/sales/customers');
                  },
                  title: 'Customers'),
            ],
          ),
          const SizedBox(height: 10),
          XMenu(height: 0.15, sectionTitle: 'POS Management', children: [
            XMenuItem(
                icon: CupertinoIcons.money_dollar,
                onTap: () {
                  context.push('/pos');
                },
                title: 'Pos'),
            XMenuItem(
                icon: Icons.design_services_outlined,
                onTap: () {
                  context.push('/pos/orders');
                },
                title: 'Pos Order'),
          ]),
          const SizedBox(height: 10),
          XMenu(
            height: 0.15,
            sectionTitle: 'Inventry Management',
            children: [
              XMenuItem(
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/product/add_product');
                  },
                  title: 'Add Item'),
              XMenuItem(
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/product/product_lists');
                  },
                  title: 'Items')
            ],
          ),
          XMenu(
            height: 0.3,
            sectionTitle: 'Purchase Management',
            children: [
              XMenuItem(
                title: 'Vendor',
                icon: Icons.person,
                onTap: () {
                  context.push('/purchase/vendor');
                },
              ),
              XMenuItem(
                title: 'Expense',
                icon: CupertinoIcons.money_dollar,
                onTap: () {
                  context.pushNamed('purchase.expense');
                },
              ),
              XMenuItem(
                title: 'Purchase Order',
                icon: CupertinoIcons.bag,
                onTap: () {
                  context.pushNamed('purchase.add_or_edit_purchase_order');
                },
              ),
            ],
          ),
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
