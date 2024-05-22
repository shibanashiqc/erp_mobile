// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/purchase/extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddOrEditPurchaseOrder extends StatefulWidget {
  int? editId;
  Map<String, dynamic>? data = {};
  Function()? onSaved;
  AddOrEditPurchaseOrder({super.key, this.editId, this.data, this.onSaved});

  @override
  State<AddOrEditPurchaseOrder> createState() => _AddOrEditPurchaseOrderState();
}

class _AddOrEditPurchaseOrderState extends State<AddOrEditPurchaseOrder>
    with SingleTickerProviderStateMixin {
  dynamic purchaseVendorId;
  String address = '';
  String purchaseOrder = '';
  String reference = '';
  String purchaseOrderDate = '';
  String deliveryDate = '';
  String shipmentPreference = '';
  dynamic paymentTermId;
  String note = '';
  double total = 0;
  double subTotal = 0;
  int discount = 0;
  int tax = 0;
  int adjustment = 0;
  List<PurchaseItems> items = [];

  void addItem() {
    items.add(PurchaseItems(
      quantity: 1,
      unitPrice: 0,
      amount: 0,
    ));
    setState(() {});
  }

  void removeItem() {
    items.removeLast();
    setState(() {});
  }

  void addOrUpdateProduct(int index) {
    items[index].quantity = 1;
    subTotal = items.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount.toString()));
    total = subTotal - discount + tax - adjustment;
    setState(() {});  
  }

  void addOrUpdateAccount(int index, Accounts item) {
    items[index].accountId = item.id;
    log('Account: ${item.id}');
    setState(() {});
  }

  void calculateAmount(int index) {
    items[index].amount = double.parse(items[index].unitPrice.toString()) *
        int.parse(items[index].quantity.toString());
    subTotal = items.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount.toString()));
    total = subTotal - discount + tax - adjustment;
    setState(() {});
  }

  void addExtraAmount(String type, value) {
    switch (type) {
      case 'discount':
        discount = int.parse(value.toString());
        break;
      case 'tax':
        tax = int.parse(value.toString());
        break;
      case 'adjustment':
        adjustment = int.parse(value.toString());
        break;
      default:
    }  
    total = subTotal - discount + tax - adjustment;
    setState(() {});
  }

  List<Errors> errorBags = [];

  set setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'purchase_vendor_id':
        purchaseVendorId = state.value;
        break;
      case 'address':
        address = state.value;
        break;
      case 'purchase_order':
        purchaseOrder = state.value;
        break;
      case 'reference':
        reference = state.value;
        break;
      case 'purchase_order_date':
        purchaseOrderDate = state.value;
        break;
      case 'delivery_date':
        deliveryDate = state.value;
        break;
      case 'shipment_preference':
        shipmentPreference = state.value;
        break;
      case 'payment_term_id':
        paymentTermId = state.value;
        break;
      case 'note':
        note = state.value;
        break;
      case 'total':
        total = double.parse(state.value);
        break;
      case 'sub_total':
        subTotal = double.parse(state.value);
        break;
      case 'discount':
        discount = int.parse(state.value.toString());
        break;
      case 'tax':
        tax = int.parse(state.value.toString());
        break;
      case 'adjustment':
        adjustment = int.parse(state.value.toString());
        break;

      default:
    }
  }

  TabController? _tabController;

  List<Vendors> vendors = [];
  List<Payterms> paymentTerm = [];
  List<Products> products = [];
  List<Accounts> accounts = [];
  
  void updateExtraData() async {
    await context.read<HrCubit>().getExtra().then((value) {
      vendors = value.data?.vendors ?? [];
      paymentTerm = value.data?.payterms ?? [];
      products = value.data?.products ?? [];
      accounts = value.data?.accounts ?? [];
      setState(() {});
    }); 
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HrCubit>().getExtra().then((value) {
        vendors = value.data?.vendors ?? [];
        paymentTerm = value.data?.payterms ?? [];
        products = value.data?.products ?? [];
        accounts = value.data?.accounts ?? [];
        setState(() {});
      });
    });

    if (widget.editId != null) {
      purchaseVendorId = widget.data?['purchase_vendor_id'];
      address = widget.data?['address'];
      purchaseOrder = widget.data?['purchase_order'];
      reference = widget.data?['reference'];
      purchaseOrderDate = widget.data?['purchase_order_date'];
      deliveryDate = widget.data?['delivery_date'];
      shipmentPreference = widget.data?['shipment_preference'];
      paymentTermId = widget.data?['payment_term_id'];
      note = widget.data?['note'];
      total = double.parse(widget.data?['total']);
      subTotal = double.parse(widget.data?['sub_total']);
      discount = int.parse(widget.data?['discount']);
      tax = int.parse(widget.data?['tax']);
      adjustment = int.parse(widget.data?['adjustment']);
    }
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HrCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: XButton(
        label: 'Save',
        onPressed: () async {   
         updateExtraData();
         await context.read<HrCubit>().createPurchaseOrder({
            'edit_id': widget.editId,
            'purchase_vendor_id': purchaseVendorId,
            'address': address,
            'purchase_order': purchaseOrder,
            'reference': reference,
            'purchase_order_date': purchaseOrderDate,
            'delivery_date': deliveryDate,
            'shipment_preference': shipmentPreference, 
            'payment_term_id': paymentTermId,
            'note': note,
            'total': total,
            'sub_total': subTotal,
            'discount': discount,
            'tax': tax,
            'adjustment': adjustment,
            'items': items.map((e) => e.toMap()).toList(), 
          }).then((value) {
            
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value.message.toString()))); 
            
            if (value.status == 'error') {
              errorBags = value.errors!;
              setState(() {
              }); 
             return;
            }
            
            

           
           widget.onSaved != null ? widget.onSaved!() : null;
           context.push('/dashboard');
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Purchase Order Update or Create'),
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        log('State: $state');

        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is ValidationErrorState) {
          log('Error: ${state.errors}');
          errorBags = state.errors;
        }

        if (state is LoadedHrState) {
          log('Loaded');
        }

        if (state is LoadingHrState) {
          log('Loading');
        }

        if (state is InitialHrState) {
          log('Initial');
        }

        if (state is ChangeFormValuesState) {
          setValue = state;
          addExtraAmount(state.type, state.value);
        }
      }, builder: (context, state) {
        return XContainer(
            enablePading: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XSelect(
                  errorBags: errorBags,
                  model: 'purchase_vendor_id',
                  enablePadding: true,
                  label: 'Vendor',
                  value: purchaseVendorId,
                  options: vendors
                      .map((e) => DropDownItem(
                            value: e.id.toString(),
                            label: e.name,
                          ))
                      .toList(),
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'purchase_vendor_id',
                          value,
                        );
                  },
                ),
                XInput(
                   errorBags: errorBags,
                  model: 'address',
                  enablePadding: true,
                  hintText: 'Address',
                  height: 0.15,
                  label: 'Address',
                  initialValue: address,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'address',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'purchase_order',
                  enablePadding: true,
                  hintText: 'Purchase Order',
                  label: 'Purchase Order',
                  initialValue: purchaseOrder,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'purchase_order',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'reference',
                  enablePadding: true,
                  hintText: 'Reference',
                  label: 'Reference',
                  initialValue: reference,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'reference',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'purchase_order_date',
                  enablePadding: true,
                  type: 'date',
                  hintText: 'Purchase Order Date',
                  label: 'Purchase Order Date',
                  initialValue: purchaseOrderDate,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'purchase_order_date',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'delivery_date',
                  enablePadding: true,
                  type: 'date',
                  hintText: 'Delivery Date',
                  label: 'Delivery Date',
                  initialValue: deliveryDate,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'delivery_date',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'shipment_preference',
                  enablePadding: true,
                  hintText: 'Shipment Preference',
                  label: 'Shipment Preference',
                  initialValue: shipmentPreference,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'shipment_preference',
                          value,
                        );
                  },
                ),
                XSelect(
                  errorBags: errorBags,
                  model: 'payment_term_id',
                  enablePadding: true,
                  label: 'Payment Term',
                  value: paymentTermId,
                  options: paymentTerm
                      .map((e) => DropDownItem(
                            value: e.id.toString(),
                            label: e.name,
                          ))
                      .toList(),
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'payment_term_id',
                          value,
                        );
                  },
                ),
                XInput(
                  errorBags: errorBags,
                  model: 'note',
                  enablePadding: true,
                  height: 0.15,
                  hintText: 'Note',
                  label: 'Note',
                  initialValue: note,
                  onChanged: (value) {
                    context.read<HrCubit>().setValues(
                          'note',
                          value,
                        );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Purchase Items',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          addItem();
                        },
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                items.removeAt(index);
                                setState(() {});
                              },
                              child: const Text('Remove Item'),
                            ),
                            
                            XSelect(
                              color: Colors.grey[200]!,
                              label: 'Product',
                              value: items[index].productId, 
                              options: products
                                  .map((e) => DropDownItem(
                                        value: e.id.toString(),
                                        label: e.name,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                items[index].productId = value;
                                items[index].unitPrice = double.parse(products
                                        .firstWhere((element) =>
                                            element.id == int.parse(value))
                                        .price ??
                                    0);
                                items[index].amount = items[index].unitPrice;
                                items[index].quantity = 1;
                                addOrUpdateProduct(index);
                              },
                            ),
                            
                            XSelect(
                              color: Colors.grey[200]!,
                              label: 'Account',
                              value: items[index].accountId,
                              options: accounts
                                  .map((e) => DropDownItem(
                                        value: e.id.toString(),
                                        label: e.name,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                items[index].accountId = value;
                                setState(() {});
                                // addOrUpdateAccount(items.indexOf(e), accounts.firstWhere((element) => element.id == value));
                              },
                            ),
                            
                            XInput(
                              color: Colors.grey[200]!,
                              keyboardType: TextInputType.number,
                              label: 'Quantity',
                              initialValue: items[index].quantity.toString(),
                              onChanged: (value) {
                                if (value.isNotEmpty && value != '0') {
                                  items[index].quantity = int.parse(value);
                                  calculateAmount(index);
                                }
                              },
                            ),
                            
                            XInput(
                              readOnly: true,
                              color: Colors.grey[200]!,
                              keyboardType: TextInputType.number,
                              label: 'Unit Price',
                              initialValue: items[index].unitPrice.toString(),
                              onChanged: (value) {
                                // items[index].unitPrice = double.parse(value);
                              },
                            ),
                            
                            XInput( 
                              readOnly: true,
                              color: Colors.grey[200]!,
                              keyboardType: TextInputType.number,
                              label: 'Amount',
                              initialValue: items[index].amount.toString(),
                              onChanged: (value) {
                                // e.amount = double.parse(value);
                              },
                            ),
                            
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text('Extra',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      XInput(
                          color: Colors.grey[200]!,
                          label: 'Tax',
                          hintText: 'Enter Tax',
                          keyboardType: TextInputType.number,
                          model: 'tax',
                          initialValue: tax.toString(),
                          onChanged: (value) => {
                                if (value.isNotEmpty)
                                  context.read<HrCubit>().setValues(
                                        'tax',
                                        value,  
                                      )
                              }),
                      XInput(
                          color: Colors.grey[200]!,
                          label: 'Discount',
                          hintText: 'Enter Discount',
                          keyboardType: TextInputType.number,
                          model: 'discount',
                          initialValue: discount.toString(),
                          onChanged: (value) => {
                                if (value.isNotEmpty)
                                  context.read<HrCubit>().setValues(
                                        'discount',
                                        value,
                                      )
                              }),
                      XInput(
                          color: Colors.grey[200]!,
                          label: 'Adjustment',
                          hintText: 'Enter Adjustment',
                          keyboardType: TextInputType.number,
                          model: 'adjustment',
                          initialValue: adjustment.toString(),
                          onChanged: (value) => {
                                if (value.isNotEmpty)
                                  context.read<HrCubit>().setValues(
                                        'adjustment',
                                        value,
                                      )
                              }),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text('Billing Information',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      BillWidget(value: subTotal, label: 'Sub Total'),
                      BillWidget(value: discount, label: 'Discount'),
                      BillWidget(value: tax, label: 'Tax'),
                      BillWidget(value: adjustment, label: 'Adjustment'),
                      BillWidget(value: total, label: 'Total'), 
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ));
      }),
    );
  }
}

class BillWidget extends StatelessWidget {
  BillWidget({
    super.key,
    required this.value,
    required this.label,
  });

  String label = '';
  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(value.toString(),
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class PurchaseItems {
  dynamic productId;
  int? quantity = 1;
  dynamic accountId;
  double? unitPrice = 0;
  double? amount = 0;

  PurchaseItems({
    this.productId,
    this.quantity = 1,
    this.accountId,
    this.unitPrice = 0,
    this.amount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'account_id': accountId,
      'unit_price': unitPrice,
      'amount': amount,
    };
  }
}
