import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/hr/staff/staff_list.dart';
import 'package:flutter/material.dart';
import 'package:erp_mobile/models/sales/sales_recieve_balance_model.dart'
    as salesReciveBalanceModel;
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:erp_mobile/models/sales/sales_orders_model.dart';

class BalanceWidget extends StatefulWidget {
  Data data;
  Function() refresh;
  BalanceWidget({super.key, required this.data, required this.refresh});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  List<salesReciveBalanceModel.Data> collectPayments = [];

  @override
  void initState() {
    super.initState();
    context
        .read<MainCubit>()
        .get('sales/sales-order/${widget.data.id}/collect-balance')
        .then((value) {
      final data =
          salesReciveBalanceModel.SalesReciveBalanceModel.fromJson(value);
      collectPayments = data.data ?? [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return XContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CREATE PAYMENT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Row(children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String amount = ''; 
                        String description = '';
                        String date = '';
                        String paymentMethod = 'Cash';

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return XContainer(
                              child: AlertDialog(
                                title: const Text('Create Payment'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    XInput(
                                      onChanged: (value) {
                                        setState(() {
                                          amount = value;
                                        });
                                      },
                                      label: 'Amount',
                                      hintText: 'Amount',
                                    ),
                                    XInput(
                                      onChanged: (value) {
                                        setState(() {
                                          description = value;
                                        });
                                      },
                                      height: 0.1,
                                      label: 'Description',
                                      hintText: 'Description',
                                    ),
                                    XInput(
                                      initialValue: date,
                                      onChanged: (value) {
                                        setState(() {
                                          date = value;
                                        });
                                      },
                                      type: 'date',
                                      label: 'Date',
                                      hintText: 'Date',
                                    ),
                                    XSelect(
                                      value: paymentMethod,
                                      label: 'Payment Method',
                                      options: [
                                        'Cash',
                                        'Bank Transfer',
                                        'Cheque'
                                      ]
                                          .map((e) =>
                                              DropDownItem(value: e, label: e))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          paymentMethod = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<MainCubit>()
                                          .postRes(
                                              'sales/sales-order/collect-balance',
                                              {
                                                'amount': amount,
                                                'description': description,
                                                'date': date,
                                                'payment_method': paymentMethod,
                                                'sales_order_id':
                                                    widget.data.id,
                                              },
                                              context)
                                          .then((value) {
                                        if (value.status == 'success') {
                                          context
                                              .read<MainCubit>()
                                              .get(
                                                  'sales/sales-order/${widget.data.id}/collect-balance')
                                              .then((value) {
                                            final data = salesReciveBalanceModel
                                                    .SalesReciveBalanceModel
                                                .fromJson(value);
                                            collectPayments = data.data ?? [];
                                            setState(() { 
                                              widget.refresh();
                                            });
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            itemCount: collectPayments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => XCard(
              child: Column(
                children: [
                  Items(items: [
                    ItemListModel(
                        name: 'DATE', value: collectPayments[index].date ?? ''),
                    ItemListModel(
                        name: 'AMOUNT',
                        value: collectPayments[index].amount ?? ''),
                    ItemListModel(
                        name: 'DESCRIPTION',
                        value: collectPayments[index].description ?? ''),
                    ItemListModel(
                        name: 'PAYMENT METHOD',
                        value: collectPayments[index].paymentMethod ?? ''),
                    ItemListModel(
                        name: 'BALANCE',
                        value: collectPayments[index].balance ?? ''),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
