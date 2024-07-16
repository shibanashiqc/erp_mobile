import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/sales/extra/add_prescription.dart';
import 'package:erp_mobile/models/sales/extra/customer_prescription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Prescription extends StatefulWidget {
  String customerId;
  Prescription({
    super.key,
    required this.customerId,
  });

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  List<Data> data = [];
  List<GroupByData> groupByData = [];
  bool loading = false;
  
  initData()
  {
    loading = true;
    setState(() {});
    context
        .read<MainCubit>()
        .get('sales/customer/${widget.customerId}/prescription')
        .then((value) {
      final customerPrescription = CustomerPrescriptionModel.fromJson(value);
      if (customerPrescription.data != null) {
        setState(() {
          loading = false;
          data = customerPrescription.data!;
          groupByData = [];
          data.forEach((element) {
            final index = groupByData.indexWhere(
                (element2) => element2.createdAt == element.createdAt);
            if (index == -1) {
              groupByData.add(
                  GroupByData(createdAt: element.createdAt, data: [element]));
            } else {
              groupByData[index].data!.add(element);
            }
          });
        });
        log('Prescription Data: $data');
      }
    });
  }
  
  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return XContainer(
      showShimmer: loading,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Prescription',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AddPrescription(
                        customerId: widget.customerId,
                        onSaved: initData, 
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add Prescription'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupByData.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return XCard(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(groupByData[index].createdAt ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupByData[index].data!.length,
                      separatorBuilder: (context, indexx) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, indexx) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('DRUG : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              groupByData[index]
                                                      .data?[indexx]
                                                      .drugName ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
                                          Text(
                                              '${groupByData[index].data?[indexx].strength} ${groupByData[index].data?[indexx].dosage}',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('FREQUENCY : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          '${groupByData[index].data?[indexx].morning}-${groupByData[index].data?[indexx].afternoon}-${groupByData[index].data?[indexx].night}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('DURATION : '.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                       Text('${groupByData[index].data?[indexx].duration} ${groupByData[index].data?[indexx].durationType}',  
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Notes'.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(groupByData[index].data?[indexx].note ?? '', 
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ])),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class GroupByData {
  String? createdAt;
  List<Data>? data;
  GroupByData({this.createdAt, this.data});
  factory GroupByData.fromJson(Map<String, dynamic> json) {
    return GroupByData(
      createdAt: json['createdAt'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }
}
