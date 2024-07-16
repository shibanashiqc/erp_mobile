import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_extra_model.dart'
    as customer_extra_model;
import 'package:erp_mobile/models/sales/extra/customer_prescription_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPrescription extends StatefulWidget {
  String customerId;
  Function()? onSaved;
  AddPrescription({
    super.key,
    required this.customerId,
    this.onSaved,
  });

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> durationTypes = [
    'day(s)',
    'week(s)',
    'month(s)',
    'year(s)',
    's.o.s',
  ];

  List<String> dosages = [
    'mg',
    'mcg',
    'gm',
    'ml',
    'IU',
    'units',
    'million spores',
    'mg SR',
    '%',
    '% w/v',
    '% w/w',
    'NA',
  ];

  List<Data> items = [];

  List<customer_extra_model.Drugs> drugs = [];

  @override
  void initState() {
    context.read<MainCubit>().get('sales/customer/extra').then((value) {
      final data = customer_extra_model.CustomerExtraModel.fromJson(value);
      drugs = data.data?.drugs ?? [];
    });

    setState(() {});
    super.initState();
  }

  void updated() {
    addItem(customer_extra_model.Drugs(id: 0, name: ''), adding: false);
  }

  void updatedItems(index) {
    updated();
  }

  void addItem(customer_extra_model.Drugs item, {adding = true}) {
    if (item.id != 0 && adding) {
      items.add(Data(
        drugId: item.id,
        drugName: item.name,
        note: item.note,
        morning: 1,
        afternoon: 1,
        night: 1,
        strength: item.strength,
        dosage: item.dosage,
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Scaffold(
        key: _scaffoldKey,
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: XButton(
            label: 'Save Prescription',
            onPressed: () async {
              final model = items;
              for (var element in model) {
                element.customerId = int.parse(widget.customerId);
              }

              Map<String, dynamic> map = {
                'items': model.map((e) => e.toJson()).toList(),
              };
              final response = await context.read<MainCubit>().postRes(
                  'sales/customer/${widget.customerId}/prescription/create',
                  map,
                  context);

              if (response.errors == null) { 
                items = [];
                if (widget.onSaved != null) widget.onSaved!();
                Navigator.pop(context);
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return ModalOptions(
                      widget: XSelect(
                    options: drugs
                        .map((e) => DropDownItem(
                              value: e.id.toString(),
                              label: e.name,
                            ))
                        .toList(),
                    onChanged: (item) {
                      addItem(drugs.firstWhere(
                          (element) => element.id == int.parse(item)));
                    },
                  )
                      // onPressed: (item) {
                      //   addItem(item);
                      //   Navigator.pop(context);
                      // },
                      );
                },
              );
            },
            child: Text('Drugs'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.add),
              onPressed: () {
                addItem(customer_extra_model.Drugs(
                    id: null, name: '', note: '', strength: '', dosage: ''));
              },
            ),
          ],
          title: const Text('Create Prescription'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return XCard(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(items[index].drugName ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(CupertinoIcons.delete),
                                    onPressed: () {
                                      setState(() {
                                        items.removeAt(index);
                                        updated();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              XInput(
                                initialValue: items[index].drugName ?? '',
                                color: Colors.grey.shade100,
                                label: 'Drug Name',
                                hintText: 'Enter Drug Name',
                                onChanged: (value) {
                                  items[index].drugName = value;
                                  updatedItems(index);
                                },
                              ),
                              XInput(
                                initialValue: items[index].strength ?? '',
                                color: Colors.grey.shade100,
                                label: 'Strength',
                                hintText: 'Enter Strength',
                                onChanged: (value) {
                                  items[index].strength = value;
                                  updatedItems(index);
                                },
                              ),
                              XSelect(
                                value: items[index].dosage ?? '',
                                color: Colors.grey.shade100,
                                label: 'Dosage',
                                options: dosages
                                    .map((e) => DropDownItem(
                                          value: e,
                                          label: e,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  items[index].dosage = value;
                                  updatedItems(index);
                                },
                              ),
                              XInput(
                                initialValue: items[index].duration ?? '',
                                color: Colors.grey.shade100,
                                label: 'Duration',
                                hintText: 'Enter Duration',
                                onChanged: (value) {
                                  items[index].duration = value;
                                  updatedItems(index); 
                                },
                              ),
                              XSelect(
                                value: items[index].durationType ?? '',
                                color: Colors.grey.shade100,
                                label: 'Duration Type',
                                options: durationTypes
                                    .map((e) => DropDownItem(
                                          value: e,
                                          label: e,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  items[index].durationType = value;
                                  updatedItems(index);
                                },
                              ),
                              XInput(
                                initialValue: items[index].morning.toString(),
                                color: Colors.grey.shade100,
                                label: 'Morning',
                                hintText: 'Enter Morning',
                                onChanged: (value) {
                                  items[index].morning = int.parse(value);
                                  updatedItems(index);
                                },
                              ),
                              XInput(
                                initialValue: items[index].afternoon.toString(),
                                color: Colors.grey.shade100,
                                label: 'Afternoon',
                                hintText: 'Enter Afternoon',
                                onChanged: (value) {
                                  items[index].afternoon = int.parse(value);
                                  updatedItems(index);
                                },
                              ),
                              XInput(
                                initialValue: items[index].night.toString(),
                                color: Colors.grey.shade100,
                                label: 'Night',
                                hintText: 'Enter Night',
                                onChanged: (value) {
                                  items[index].night = int.parse(value);
                                  updatedItems(index);
                                },
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: items[index].beforeFood == 1
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      items[index].beforeFood = 1;
                                      updatedItems(index);
                                    },
                                  ),
                                  const Text('Before Food'),
                                  Checkbox(
                                    value: items[index].beforeFood == 1
                                        ? false
                                        : true,
                                    onChanged: (value) {
                                      items[index].beforeFood = 0;
                                      updatedItems(index);
                                    },
                                  ),
                                  const Text('After Food'),
                                ],
                              ),
                              XInput(
                                height: 0.1,
                                initialValue: items[index].note ?? '',
                                color: Colors.grey.shade100,
                                label: 'Note',
                                hintText: 'Enter Note',
                                onChanged: (value) {
                                  items[index].note = value;
                                  updatedItems(index);
                                },
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  const Text(
                      'Select a drug from the right. You can add multiple items.',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrugsWidget extends StatefulWidget {
  Function(customer_extra_model.Drugs) onPressed;
  List<customer_extra_model.Drugs> drugs = [];

  DrugsWidget({
    super.key,
    required this.onPressed,
    required this.drugs,
  });

  @override
  State<DrugsWidget> createState() => _DrugsWidgetState();
}

class _DrugsWidgetState extends State<DrugsWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: Center(
          child: Text('Drugs'.toUpperCase(),
              style: const TextStyle(color: Colors.black, fontSize: 15))),
      content: SingleChildScrollView(
        child: XCard(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(height: 10),
            Column(
              children: widget.drugs
                  .map((e) => ListTile(
                        title: Text(e.name ?? ''),
                        trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.type ?? ''),
                            )),
                        onTap: () {
                          widget.onPressed(e);
                        },
                      ))
                  .toList(),
            ),
          ]),
        ),
      ),
      actions: [
        XButton(
          color: Colors.black,
          label: 'Close',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
