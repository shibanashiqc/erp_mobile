// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/hr/employee_type_model.dart';
import 'package:erp_mobile/screens/common/delete-dialog.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeType extends StatefulWidget {
  const EmployeeType({super.key});

  @override
  State<EmployeeType> createState() => _EmployeeTypeState();
}

class _EmployeeTypeState extends State<EmployeeType> {
  List<Data>? data;
  bool loading = false;
  
  loadData()
  {
    final employeeTypes = context.read<HrCubit>().getEmployeeTypes();
    loading = true;
    setState(() { 
    });
    employeeTypes.then((value) {
      setState(() {
        data = value.data;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    final employeeTypes = context.read<HrCubit>().getEmployeeTypes();
    loading = true;
    employeeTypes.then((value) {
      setState(() {
        data = value.data;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HrCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Type'),
        actions: [
          IconButton( 
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/employee_type/update_or_create', extra: {
                'onSaved': loadData,
              });
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8 ,
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return XList(
                                onDelete: () {},
                                onTap: () {},
                                title: '',
                                subtitle: '',
                                status: 1,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XInput(
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8, 
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return XList(
                              onDelete: () {
                                 deleteDialog(context, () => 
                                  {
                                   context.read<HrCubit>().postRes(
                                    'hr/delete-employee-type',
                                    {'id': data?[index].id},
                                    context,
                                  ).then((value) => 
                                    loadData() 
                                  ) 
                                  }
                                );
                              },
                                  
                              title: data?[index].name ?? '',
                              subtitle: data?[index].description ?? '',
                              status: data?[index].status ?? 0,
                              onTap: () {
                                context.push(
                                    '/employee_type/update_or_create',
                                    extra: {
                                      'id': data?[index].id,
                                      'title': data?[index].name,
                                      'description': data?[index].description,
                                      'status': data?[index].status,
                                      'onSaved': loadData,
                                    });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}

class XList extends StatelessWidget {
  String subtitle;
  String title;
  int status;
  VoidCallback onTap;
  VoidCallback onDelete;

  XList({
    super.key,
    required this.subtitle,
    required this.title,
    required this.status,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        children: [
          ListTile(
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 10),
              ),
            ),
            trailing: XBadge(
              label: status == 1 ? 'Active' : 'InActive',
              color: status == 1 ? Colors.green : Colors.orange,
            ),
            title: Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Actions',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: onTap,
                          child: XBadge(
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            color: ColorConstants.primaryColor,
                            padding: 4,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        XBadge(
                          onPressed: onDelete,
                          icon: const Icon(
                            CupertinoIcons.delete_solid,
                            size: 15,
                          ),
                          color: Colors.pink,
                          padding: 4,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
