import 'package:erp_mobile/models/sales/extra/customer_extra_model.dart'
    as customer_extra_model;
import 'package:erp_mobile/models/sales/extra/customer_payment_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPayments extends StatefulWidget {
  const AddPayments({
    super.key,
  });

  @override
  State<AddPayments> createState() => _AddPaymentsState();
}

class _AddPaymentsState extends State<AddPayments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController amountPaidController = TextEditingController(text: '0');
  List<Invoices>? items = [];
  Data data = Data();
  List<customer_extra_model.Invoices> invoices = [
    customer_extra_model.Invoices(
        invoiceNumber: 'INV-2021-0001',
        grandTotal: '1000',
        createdAt: '2021-01-01',
        items: [
          customer_extra_model.Items(
              id: 1, itemName: 'ALBANTAZOL', total: '2000'),
        ]),
  ];

  @override
  void initState() {
    data.amountToPay = '0';
    data.amountRemaining = '0';
    data.amountPaid = '0';
    super.initState();
  }

  void updatedItems(index) {}

  void addItem(customer_extra_model.Invoices item, {adding = true}) {
    if (item.id != 0 && adding) {
      items?.add(Invoices(
        appointmentInvoiceId: item.id,
        invoiceNumber: item.invoiceNumber,
        amountRemaining: item.grandTotal,
        amountPaid: item.grandTotal,
        dueAfter: 0,
      ));
    }

    data.amountToPay = items
        ?.fold(
            0,
            (previousValue, element) =>
                previousValue + int.parse(element.amountPaid ?? '0'))
        .toString();
    
    amountPaidController.text = data.amountToPay ?? '0';  
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
            label: 'Save Payments',
            onPressed: () {},
          ),
        ),
        appBar: AppBar(
          title: const Text('Create Payments'),
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
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return PendingInvoices(
                            invoices: invoices.where((element) {
                              return items?.every((element2) {
                                    return element.invoiceNumber !=
                                        element2.invoiceNumber;
                                  }) ??
                                  true;
                            }).toList(),
                            onPressed: (customer_extra_model.Invoices invoice) {
                              addItem(invoice);
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Invoices.'.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.red.shade900,
                            child: const Text('2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items?.length ?? 0,
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
                                    Text(
                                        'INVOICE NO: ${items?[index].invoiceNumber}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(CupertinoIcons.delete,
                                          size: 16),
                                      onPressed: () {
                                        items?.removeAt(index);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text('PROCEDURES',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: invoices
                                              .firstWhere((element) =>
                                                  element.invoiceNumber ==
                                                  items?[index].invoiceNumber)
                                              .items
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index2) {
                                        return Row(
                                          children: [
                                            Text(
                                                invoices
                                                        .firstWhere((element) =>
                                                            element
                                                                .invoiceNumber ==
                                                            items?[index]
                                                                .invoiceNumber)
                                                        .items?[index2]
                                                        .itemName ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const Spacer(),
                                            Text(
                                                invoices
                                                        .firstWhere((element) =>
                                                            element
                                                                .invoiceNumber ==
                                                            items?[index]
                                                                .invoiceNumber)
                                                        .items?[index2]
                                                        .total ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text('DUE (INR)'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(
                                        invoices
                                                .firstWhere((element) =>
                                                    element.invoiceNumber ==
                                                    items?[index].invoiceNumber)
                                                .grandTotal ??
                                            '0',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text('PAY NOW (INR)'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(data.amountToPay ?? '0',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                        'DUE AFTER PAYMENT (INR)'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(
                                        (double.parse(invoices
                                                        .firstWhere((element) =>
                                                            element
                                                                .invoiceNumber ==
                                                            items?[index]
                                                                .invoiceNumber)
                                                        .grandTotal ??
                                                    '0') -
                                                double.parse(
                                                    data.amountPaid ?? '0'))
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  XCard(
                    color: Colors.yellow.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Amount to Pay :'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Text('INR ${data.amountToPay ?? '0'}',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          XInput(
                            controller: amountPaidController, 
                            label: 'PAY NOW',
                            onChanged: (value) {
                              data.amountPaid = value;
                            },
                          ),
                          Row(
                            children: [
                              Text('DUE AMOUNT:'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Text('INR ${data.amountRemaining ?? '0'}',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          XInput(
                            height: 0.1,
                            label: 'Notes',
                            onChanged: (value) {
                              data.notes = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
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

// ignore: must_be_immutable
class PendingInvoices extends StatefulWidget {
  Function(customer_extra_model.Invoices) onPressed;
  List<customer_extra_model.Invoices> invoices;
  PendingInvoices({
    super.key,
    required this.onPressed,
    required this.invoices,
  });

  @override
  State<PendingInvoices> createState() => _PendingInvoicesState();
}

class _PendingInvoicesState extends State<PendingInvoices> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('Pending Invoices'.toUpperCase(),
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const Divider(
              thickness: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.invoices.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.invoices[index].invoiceNumber ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              const SizedBox(width: 10),
                              Text(widget.invoices[index].createdAt ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                widget.invoices[index].items?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(
                                      widget.invoices[index].items?[index]
                                              .itemName ??
                                          ''.toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Text(
                                      widget.invoices[index].items?[index]
                                              .total ??
                                          '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              );
                            },
                          ),
                          Row(
                            children: [
                              Text('Total'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Text(widget.invoices[index].grandTotal ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        widget.onPressed(widget.invoices[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
