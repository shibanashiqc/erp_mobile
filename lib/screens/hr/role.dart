// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/hr/roles_model.dart';
import 'package:erp_mobile/screens/common/delete-dialog.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  
  List<Data>? data;
  bool loading = false;
  
 void loadData ({query = ''}) async
 {
  
  loading = true;
  await context.read<HrCubit>().getRoles(search: query).then((value) {
      setState(() {
        data = value.data; 
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
        title: const Text('Role'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/role/update_or_create', extra: { 
                'onSaved' : loadData
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          loadData();
        },
        child: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
          if (state is ErrorHrState) {
            log('Error: ${state.message}');
          }
        }, builder: (context, state) {
          return XContainer(
              child: Column(
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
              SizedBox(
                 height: MediaQuery.of(context).size.height * 0.8 ,
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
                                    'hr/delete-role',
                                    {'id': data?[index].id},
                                    context,
                                  ).then((value) => 
                                    loadData() 
                                  ) 
                                  }
                                );
                              },
                      onTap: () {   
                        context.push('/role/update_or_create',  extra: {
                          'id': 1, 
                          'title': data?[index].name,
                        });
                      },
                      title: data?[index].name.toString() ?? '',
                      subtitle: '',
                    );
                  },
                ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}

class XList extends StatelessWidget {
  String subtitle;
  String title;
  int? status;
  VoidCallback onTap;
  VoidCallback onDelete;
  XList({
    super.key,
    required this.subtitle,
    required this.title,
    this.status,
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
            // subtitle: Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: Text(
            //     subtitle,
            //     style: const TextStyle(fontSize: 10),
            //   ),
            // ),
            trailing: status != null ? XBadge(
              label: status == 1 ? 'Active' : 'InActive',
              color: status == 1 ? Colors.green : Colors.orange,
            ) : null,
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
                          onPressed: onTap, 
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
                        XBadge(
                          onPressed: onDelete  ,
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
          )
        ],
      ),
    );
  }
}
