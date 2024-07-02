

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_extra_model.dart'
    as customer_extra_model;
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:erp_mobile/models/sales/extra/appointment_invoice_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceItems extends StatefulWidget {
  String customerId;
  InvoiceItems({
    super.key,
    required this.customerId,
  });

  @override
  State<InvoiceItems> createState() => _InvoiceItemsState();
}

class _InvoiceItemsState extends State<InvoiceItems> {
  Data data = Data();
  List<Items> items = [];

  @override
  void initState() {
    data.totalCost = '0.0';
    data.totalDiscount = '0.0';
    data.totalTax = '0.0';
    data.grandTotal = '0.0';
    data.invoiceNumber = 'INV-000${DateTime.now().millisecondsSinceEpoch}';
    super.initState();
  }

  void updated() {
    addItem(customer_extra_model.Proceedures(id: 0, name: '', price: '0.0'),
        adding: false);
  }

  void updatedItems(index) {
    if (items[index].cost == null || items[index].cost == '') {
      items[index].cost = '0.0';
    }
    if (items[index].discountValue == null) items[index].discountValue = 0;
    if (items[index].taxValue == null) items[index].taxValue = 0;
    if (items[index].unit == null) items[index].unit = 0;
    items[index].total = (double.parse(items[index].cost.toString()) *
            double.parse(items[index].unit.toString()))
        .toString();
    items[index].discountAmount = ((items[index].discountValue ?? 0) *
            double.parse(items[index].cost.toString()) /
            100)
        .toString();
    items[index].taxAmount = ((items[index].taxValue ?? 0) *
            double.parse(items[index].cost.toString()) /
            100)
        .toString();
    updated();
  }

  void addItem(customer_extra_model.Proceedures item, {adding = true}) {
    if (item.id != 0 && adding) {
      items.add(Items(
        proceedureId: item.id,
        itemName: item.name,
        total: item.price,
        unit: 1,
        cost: item.price,
        discountValue: 0,
        discountAmount: '0.0',
        taxValue: 0,
        taxAmount: '0.0',
      ));
    }

    data.totalCost = items
        .fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element.total ?? '0.0'))
        .toString();

    data.totalDiscount = items
        .fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element.discountAmount ?? '0.0'))
        .toString();

    data.totalTax = items
        .fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element.taxAmount ?? '0.0'))
        .toString();

    data.grandTotal = (double.parse(data.totalCost ?? '0.0') -
            double.parse(data.totalDiscount ?? '0.0') +
            double.parse(data.totalTax ?? '0.0'))
        .toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.add),
              onPressed: () {
                addItem(customer_extra_model.Proceedures(
                    id: null, name: '', price: '0.0'));
              },
            ),
          ],
          title: const Text('Create Invoice'),
        ),
        body: SingleChildScrollView(
         child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  
                  XCard( 
                    isPadding: true, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('PROCEDURES',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return Procedures(
                                  onPressed: (item) {
                                    addItem(item);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween, 
                                children: [
                                  Text(items[index].itemName ?? '',
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
                              const SizedBox(height: 10),
                              XInput(
                                initialValue: items[index].unit.toString(), 
                                color: Colors.grey.shade100,
                                label: 'Unit',
                                hintText: 'Enter Unit',
                                onChanged: (value) {
                                  items[index].unit = int.parse(value);
                                  updatedItems(index);
                                },
                              ),
                              const SizedBox(height: 10),
                              XInput(
                                initialValue: items[index].cost ?? '0.0',
                                color: Colors.grey.shade100,
                                label: 'Cost',
                                hintText: 'Enter Cost',
                                onChanged: (value) {
                                  items[index].cost = value;
                                  updatedItems(index);
                                },
                              ),
                              const SizedBox(height: 10),
                              XInput(
                                initialValue: items[index].discountValue.toString(),
                                color: Colors.grey.shade100,
                                label: 'Discount(%)',
                                hintText: 'Enter Discount',
                                onChanged: (value) {
                                  items[index].discountValue = int.parse(value);
                                  updatedItems(index);
                                },
                              ),
                              const SizedBox(height: 10),
                              XInput(
                                initialValue: items[index].taxValue.toString(),     
                                color: Colors.grey.shade100,
                                label: 'Tax(%)',
                                hintText: 'Enter Tax',
                                onChanged: (value) {
                                  items[index].taxValue =
                                      int.parse(value);
                                  updatedItems(index); 
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween, 
                                children: [
                                  Text('Total'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(items[index].total ?? '0.00',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  XCard(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(  
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Cost'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,  
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(data.totalCost ?? '',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Discount'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(data.totalDiscount ?? '',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Tax'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(data.totalTax ?? '',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Grand Total'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(data.grandTotal ?? '',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          XButton(
                            label: 'Save',
                            onPressed: () async {
                              final model = data;
                              model.invoiceNumber = 'INV-000${DateTime.now().millisecondsSinceEpoch}';  
                              model.items = items;
                                
                              final response = await context.read<MainCubit>().postRes(
                                'sales/customer/${widget.customerId}/invoices/create',
                                model.toJson(),
                                context
                              );
                                
                              if (response.errors == null) { 
                                  data = Data();
                                  items = []; 
                                  Navigator.pop(context); 
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Procedures extends StatefulWidget {
  Function(customer_extra_model.Proceedures) onPressed;
  Procedures({
    super.key,
    required this.onPressed,
  });

  @override
  State<Procedures> createState() => _ProceduresState();
}

class _ProceduresState extends State<Procedures> {
  List<customer_extra_model.Proceedures> proceedures = [];
  @override
  void initState() {
    context.read<MainCubit>().get('sales/customer/extra').then((value) {
      final data = customer_extra_model.CustomerExtraModel.fromJson(value);
      proceedures = data.data?.proceedures ?? []; 
      setState(() {}); 
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Procedures'),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          const SizedBox(height: 10),
         proceedures.isNotEmpty ?  CupertinoListSection(
            children: proceedures
                .map((e) => CupertinoListTile(
                      title: Text(e.name ?? ''),
                      trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.price ?? ''),
                          )),
                      onTap: () {
                        widget.onPressed(e);
                      },
                    ))
                .toList(), 
          ) : const Center(child: CircularProgressIndicator()) 
        ]),
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
