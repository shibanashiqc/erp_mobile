import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_menu.dart';
import 'package:erp_mobile/screens/common/x_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppsWidget extends StatefulWidget {
  const AppsWidget({
    super.key,
  });

  @override
  State<AppsWidget> createState() => _AppsWidgetState();
}

class _AppsWidgetState extends State<AppsWidget> {
  List<dynamic> modules = [];
  @override
  Widget build(BuildContext context) {
    return XContainer(
      child: Column(
        children: [
          XMenu(height: 0.27, sectionTitle: 'Production Management', children: [
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {
                  context.pushNamed('project.clients');
                },
                title: 'Clients'),
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {
                  context.pushNamed('project.teams');
                },
                title: 'Teams'),
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {
                  context.pushNamed('project.list');
                },
                title: 'Projects'),
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {
                  context.pushNamed('project.create_or_edit');
                },
                title: 'Create Project'),
            XMenuItem(
                icon: CupertinoIcons.doc_plaintext,
                onTap: () {
                  context.pushNamed('qa');
                },
                title: 'Qa'),
          ]),

          XMenu(
            height: 0.25, 
            sectionTitle: 'HR Management',
            children: [
              XMenuItem(
                  // isHidden: modules
                  //         .where(
                  //             (element) => element['slug'] == 'hr-management')
                  //         .isEmpty ??
                  //     true,
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
              XMenuItem(
                  icon: Icons.design_services_outlined,
                  onTap: () {
                    context.push('/staff/list'); 
                  },
                  title: 'Staff List'),
              XMenuItem(
                  icon: Icons.supervised_user_circle_sharp,
                  onTap: () {
                    context.push('/staff/update_or_create');
                  }, 
                  title: 'Create Staffs'),
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
          // const SizedBox(height: 10),
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
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/sales/create_sales_orders');
                  },
                  title: 'Add Sales Order'),
              XMenuItem(
                  icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                  onTap: () {
                    context.push('/sales/customers');
                  },
                  title: 'Customers'),
                  
                  //create_customers
              XMenuItem(
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context.push('/sales/create_customers');
                  },
                  title: 'Add Customers'), 
            ],
          ),
          // const SizedBox(height: 10),
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
          // const SizedBox(height: 10),
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

          XMenu(
            height: 0.15,
            sectionTitle: 'Medical',
            children: [
              XMenuItem(
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () {
                    context
                        .push('/sales/customers', extra: {'type': 'Patients'});
                  },
                  title: 'Patients'),
            ],
          ),
        ],
      ),
    );
  }
}
