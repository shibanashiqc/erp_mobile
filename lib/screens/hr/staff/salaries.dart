// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Salaries extends StatefulWidget {
  const Salaries({super.key});

  @override
  State<Salaries> createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    final departments = context.read<HrCubit>().getDepartments();
    loading = true;
    departments.then((value) {
      setState(() {
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
        title: const Text('Salaries'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       context.push('/department/update_or_create');
        //     },
        //   )
        // ],
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
                        onChanged: (value) {},
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),
                      SizedBox(
                         height: MediaQuery.of(context).size.height * 0.8 ,
                        child: Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return XList(
                                amount: '2000.00',
                                title: 'Shanoop',
                                subtitle: '2024-01-25',
                                leaves: '3',
                                payble: '2000.00', 
                                createdAt: '2024-01-25',
                                onTap: () {
                                  showCupertinoModalPopup(  
                                    context: context,
                                    builder: (context) { 
                                      return CupertinoActionSheet(
                                        title: const Text('Update Salary Advance Request'),
                                        message: const Text('Please fill the form to update the salary advance request'),
                                        actions: [ 
                                          Material( 
                                            child: const AdvanceRequestModal(),
                                          ),
                                          CupertinoButton(
                                            child: const Text('Update'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                        cancelButton: CupertinoButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ); 
                                    }); 
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}

class AdvanceRequestModal extends StatelessWidget {
  const AdvanceRequestModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(  
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              XInput(
                hintText: 'Name',
              ),
          
             XInput(
              type: 'date',
              hintText: 'Date', 
             ),
             
              XInput(
                hintText: 'Amount', 
              ),
              
              XInput(
                hintText: 'Outstanding Amount', 
              ),
              
              XInput(
                hintText: 'Reason', 
              ),
              
              XInput(
                hintText: 'Status', 
              ),
              
              XInput(
                hintText: 'Approved By', 
              ),
              
              XInput(
                hintText: 'Approved Date', 
              ),
              
              XInput(
                hintText: 'Approved Remark', 
              ),
              
           
              
            ],
          ),
        ),
      ),
    );
  }
}

class XList extends StatelessWidget {
  String subtitle;
  String title;
  String leaves;
  dynamic amount;
  String payble;
  String createdAt;
  VoidCallback onTap;

  XList({
    super.key,
    required this.subtitle,
    required this.title,
    required this.leaves,
    required this.amount,
    required this.onTap,
    required this.createdAt,
    this.payble = '',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE : $subtitle',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'ADVANCE AMOUNT : $amount',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'TOTAL AMOUNT PAYABLE : $payble',
                    style: const TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'CREATED AT : $createdAt',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
            trailing: XBadge(
              label: leaves,
              color: Colors.green,
            ),
            title: Text('NAME : $title',
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
                        // InkWell(
                        //   onTap: onTap,
                        //   child: XBadge(
                        //     icon: const Icon(
                        //       Icons.edit,
                        //       size: 15,
                        //     ),
                        //     color: ColorConstants.primaryColor,
                        //     padding: 4,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 4,
                        // ),
                        XBadge(
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
