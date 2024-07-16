// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/hr/department_model.dart';
import 'package:erp_mobile/screens/common/delete-dialog.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Department extends StatefulWidget {
  const Department({super.key});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List<Data>? data;
  List<Data>? dataTemp;
  bool loading = true;
  
  loadData() {
    final departments = context.read<HrCubit>().getDepartments();
    loading = true;
    setState(() { }); 
    departments.then((value) {
      setState(() { 
        data = value.data;
        dataTemp = value.data;
        loading = false;
      });
    }); 
  }

  @override
  void initState() {
    super.initState();
    final departments = context.read<HrCubit>().getDepartments();
    loading = true;
    departments.then((value) {
      setState(() {
        data = value.data;
        dataTemp = value.data;
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
        title: const Text('Department'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/department/update_or_create', extra: {
                'onSaved' : initState 
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
          loadData;   
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
                            return XList(
                              onDelete: () {}, 
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
                          data = data
                              ?.where((element) => element.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          setState(() {}); 
                          if (value.isEmpty) {
                            data = dataTemp;
                            setState(() {});
                          }
                        },
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
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return XList(
                              title: data?[index].name ?? '',
                              subtitle: data?[index].description ?? '',
                              status: data?[index].status ?? 0,
                              onDelete: () {
                                deleteDialog(context, () {
                                  context.read<HrCubit>().postRes(
                                    'hr/delete-department',
                                    {'id': data?[index].id},
                                    context,
                                  ).then((value) => 
                                    loadData()
                                  );
                                  
                                  
                                  
                                });
                              },
                              onTap: () {
                                context.push( 
                                    '/department/update_or_create',
                                    extra: {
                                      'id': data?[index].id,
                                      'title': data?[index].name,
                                      'description': data?[index].description,
                                      'status': data?[index].status,
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
  VoidCallback? onDelete;

  XList({
    super.key,
    required this.subtitle,
    required this.title,
    required this.status,
    required this.onTap,
    this.onDelete,
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
                        XBadge(
                          onPressed:  onTap,
                          icon: const Icon(
                            Icons.edit, 
                            size: 15,
                          ),
                          color: ColorConstants.primaryColor,
                          padding: 4,
                        ),
                        const SizedBox(
                          width: 4,   
                        ),
                        InkWell(
                          onTap: () {
                            if (onDelete != null) {
                              onDelete!();
                            } 
                          },
                          child: XBadge(
                            icon: const Icon(
                              CupertinoIcons.delete_solid,
                              size: 15,
                            ),
                            color: Colors.pink,
                            padding: 4,
                          ),
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
