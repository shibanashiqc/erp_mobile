import 'dart:convert';
import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';


import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/auth/login/login_cubit.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/cubit/hr/staff/staff_cubit.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/products_model.dart' as pos;
import 'package:erp_mobile/screens/auth/login_screen.dart';
import 'package:erp_mobile/screens/pos/cart.dart';
import 'package:erp_mobile/screens/dashboard.dart';
import 'package:erp_mobile/screens/hr/staff/attendance.dart';
import 'package:erp_mobile/screens/hr/staff/create_staff.dart';
import 'package:erp_mobile/screens/hr/staff/payroll.dart';
import 'package:erp_mobile/screens/hr/staff/salaries.dart';
import 'package:erp_mobile/screens/hr/staff/salary_advance_request.dart';
import 'package:erp_mobile/screens/pos/pos.dart';
import 'package:erp_mobile/screens/pos/pos_orders.dart';
import 'package:erp_mobile/screens/pos/reciept.dart';
import 'package:erp_mobile/screens/product/add_product.dart';
import 'package:erp_mobile/screens/product/product_lists.dart';
import 'package:erp_mobile/screens/purchase/add_or_edit_purchase_order.dart';
import 'package:erp_mobile/screens/purchase/add_or_edit_vendor.dart';
import 'package:erp_mobile/screens/purchase/expense.dart';
import 'package:erp_mobile/screens/purchase/vendor.dart';
import 'package:erp_mobile/screens/sales/create_customers.dart';
import 'package:erp_mobile/screens/sales/create_sales_order_form.dart';
import 'package:erp_mobile/screens/sales/customers.dart';
import 'package:erp_mobile/screens/sales/invoice.dart';
import 'package:erp_mobile/screens/sales/sales_order.dart';
import 'package:erp_mobile/screens/sales/view_sales_orders.dart';
import 'package:erp_mobile/screens/splash/splash_screen.dart';
import 'package:erp_mobile/screens/hr/department.dart';
import 'package:erp_mobile/screens/hr/department_form.dart';
import 'package:erp_mobile/screens/hr/employee_type.dart';
import 'package:erp_mobile/screens/hr/employee_type_form.dart';
import 'package:erp_mobile/screens/hr/role.dart';
import 'package:erp_mobile/screens/hr/role_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  // initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, state) => const SplashScreen(),
      routes: [
        GoRoute(
          name: 'login',
          path: 'login',
          builder: (_, state) => const LoginScreen(),
        ),
        GoRoute(
          name: 'dashboard',
          path: 'dashboard',
          builder: (_, state) => const Dashbaord(),
        ),
        GoRoute(
          name: 'product',
          path: 'product',
          builder: (_, state) => const Dashbaord(),
          routes: [
            GoRoute(
              path: 'product_lists',
              builder: (context, state) => const ProductLists(),
            ),
            GoRoute(
              name: 'add_product',
              path: 'add_product',
              builder: (context, state) {
                if (state.extra == null) return AddProduct();
                final extra = json.encode(state.extra);
                final params = Params.fromJson(json.decode(extra));
                return AddProduct(
                  editId: params.id,
                  data: params.extra,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: 'pos',
          path: 'pos',
          builder: (_, state) => const Pos(),
          routes: [
            GoRoute(
                name: 'orders',
                path: 'orders',
                builder: (context, state) => const PosOrder()),
            GoRoute(
                name: 'cart',
                path: 'cart',
                builder: (context, state) {
                  final extra = json.encode(state.extra);
                  final params = Params.fromJson(json.decode(extra));
                  List<pos.Data> products = params.extra['products']
                      .map<pos.Data>((e) => pos.Data.fromJson(e))
                      .toList();
                  return Cart(
                    products: products,
                    subTotal: params.extra['subTotal'],
                    grandTotal: params.extra['grandTotal'],
                  );
                  // return Cart(
                  //    products: params.extra['products'],
                  //    subTotal: params.extra['subTotal'],
                  //    grandTotal: params.extra['grandTotal'],
                  // );
                }),
            GoRoute(
                name: 'receipts',
                path: 'receipts',
                builder: (context, state) {
                  final extra = json.encode(state.extra);
                  final params = Params.fromJson(json.decode(extra));
                  List<pos.Data> products = params.extra['products']
                      .map<pos.Data>((e) => pos.Data.fromJson(e))
                      .toList();
                  return Reciept(
                    products: products,
                    data: params.extra['data'],
                  );
                }),
          ],
        ),
        GoRoute(
          name: 'hr.departments',
          path: 'department',
          builder: (_, state) => const Department(),
          routes: [
            GoRoute(
              path: 'update_or_create',
              builder: (context, state) {
                if (state.extra == null) return DepartmentForm();
                final extra = json.encode(state.extra);
                final params = Params.fromJson(json.decode(extra));
                return DepartmentForm(
                  editId: params.id,
                  title: params.title,
                  description: params.description,
                  status: params.status,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: 'hr.employee-types',
          path: 'employee_type',
          builder: (_, state) => const EmployeeType(),
          routes: [
            GoRoute(
              path: 'update_or_create',
              builder: (context, state) {
                if (state.extra == null) return EmployeeTypeForm();
                final extra = json.encode(state.extra);
                final params = Params.fromJson(json.decode(extra));
                return EmployeeTypeForm(
                  editId: params.id,
                  title: params.title,
                  description: params.description,
                  status: params.status,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: 'hr.staffs.salary_advance_request',
          path: 'salary_advance_request',
          builder: (_, state) => const SalaryAdvanceRequest(),
          routes: const [],
        ),
        GoRoute(
          name: 'hr.salary',
          path: 'salaries',
          builder: (_, state) => const Salaries(),
          routes: const [],
        ),
        GoRoute(
          path: 'purchase/vendor',
          name: 'purchase.vendor',
          builder: (context, state) => const Vendor(),
        ),
         GoRoute(
          path: 'purchase/expense', 
          name: 'purchase.expense',
          builder: (context, state) => const Expense(),
        ),
        
        GoRoute(
            name: 'purchase.add_or_edit_purchase_order',
            path: 'purchase/add_or_edit_purchase_order',
            builder: (context, state) {
              if (state.extra == null) return AddOrEditPurchaseOrder();
              final extra = json.encode(state.extra);
              final params = Params.fromJson(json.decode(extra));
              return AddOrEditPurchaseOrder(
                editId: params.id,
                data: params.extra,
              );
            }),
        
        
        GoRoute(
            path: 'purchase/add_or_edit_vendor',
            builder: (context, state) {
              if (state.extra == null) return AddOrEditVendor();
              final extra = json.encode(state.extra);
              final params = Params.fromJson(json.decode(extra));
              return AddOrEditVendor(
                editId: params.id,
                data: params.extra,
              );
            }),
        GoRoute(
          name: 'hr.staffs.payrolls',
          path: 'payroll',
          builder: (_, state) => const Payroll(),
          routes: const [],
        ),
        GoRoute(
          path: 'attendance',
          builder: (_, state) => const Attendance(),
          routes: const [],
        ),
        GoRoute(
          name: 'hr.roles',
          path: 'role',
          builder: (_, state) => const Role(),
          routes: [
            GoRoute(
              path: 'update_or_create',
              builder: (context, state) {
                if (state.extra == null) return RoleForm();
                final extra = json.encode(state.extra);
                final params = Params.fromJson(json.decode(extra));
                return RoleForm(
                  editId: params.id,
                  title: params.title,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'staff',
          builder: (_, state) => const Role(),
          routes: [
            GoRoute(
              path: 'update_or_create',
              builder: (context, state) {
                if (state.extra == null) return CreateStaff();
                final extra = json.encode(state.extra);
                final params = Params.fromJson(json.decode(extra));
                return RoleForm(
                  editId: params.id,
                  title: params.title,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'sales',
          builder: (_, state) => const Role(),
          routes: [
            GoRoute(
              path: 'sales_orders',
              builder: (context, state) => const SalesOrder(),
            ),

            GoRoute(
                path: 'create_sales_orders',
                builder: (context, state) {
                  if (state.extra == null) return CreateSalesOrder();
                  return CreateSalesOrder(
                    data: state.extra,
                  );
                }),

            // Invoice

            GoRoute(
              path: 'view_invoice',
              builder: (context, state) => const Invoice(),
            ),

            GoRoute(
                path: 'view_sales_orders',
                builder: (context, state) {
                  if (state.extra == null) return ViewSalesOrders();
                  final extra = json.encode(state.extra);
                  final params = Params.fromJson(json.decode(extra));
                  return ViewSalesOrders(
                    salesOrder: params.extra,
                  );
                }),

            GoRoute(
              path: 'generate_invoice',
              builder: (context, state) => const Invoice(),
            ),

            GoRoute(
              path: 'customers',
              builder: (context, state) => const Customers(),
            ),

            GoRoute(
                path: 'create_customers',
                builder: (context, state) {
                  if (state.extra == null) return CreateCustomers();
                  final extra = json.encode(state.extra);
                  final params = Params.fromJson(json.decode(extra));
                  return CreateCustomers(
                    editId: params.id,
                    data: params.extra,
                  );
                }),
          ],
        ),
      ],
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => HrCubit()),
        BlocProvider(create: (context) => StaffCubit()),
        BlocProvider(create: (context) => MainCubit()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: ColorConstants.secondaryColor,
          ),
          scaffoldBackgroundColor: Colors.grey[100],
          primaryColor: const Color.fromRGBO(80, 66, 155, 1),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: ColorConstants.secondaryColor,
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: ColorConstants.secondaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: ColorConstants.secondaryColor,
            ),
          ),
          // useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routerConfig: router,
      ),
    );
  }
}

class Params {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic status;
  dynamic extra;
  dynamic onSaved;
  Params(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.extra,
      this.onSaved});

  Params.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    extra = json['extra'];
    onSaved = json['onSaved'];
  }
}
