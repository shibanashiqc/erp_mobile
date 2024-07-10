// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/products_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart' as sales;
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Cart extends StatefulWidget {
  List<Data> products = [];

  dynamic subTotal = 0;
  dynamic grandTotal = 0;

  Cart(
      {super.key,
      required this.products,
      required this.subTotal,
      required this.grandTotal});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool loading = false;
  bool calculationLoading = false;
  List<sales.Customers>? customers = [];
  dynamic customerId;
  dynamic discountAmount = 0;
  dynamic taxAmount = 0;
  dynamic tax = 0;
  String paymentMode = 'Cash';
  DateTime focusedDay = DateTime.now();
  List<Errors> errorBags = [];
  String address = '';
  String streetAddress = '';
  String city = '';
  String states = '';
  String zip = '';
  String country = '';
  String note = '';

  String name = '';
  String phone = '';
  String email = '';

  void setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'customer_id':
        customerId = state.value;
        break;
      case 'discount':
        discountAmount = state.value;
        break;
      case 'tax':
        taxAmount = state.value;
        break;
      case 'payment_method':
        paymentMode = state.value;
        break;
      case 'name':
        name = state.value;
        break;
      case 'phone':
        phone = state.value;
        break;
      case 'address':
        address = state.value;
        break;
      case 'street_address':
        streetAddress = state.value;
        break;
      case 'city':
        city = state.value;
        break;
      case 'state':
        states = state.value;
        break;
      case 'zip':
        zip = state.value;
        break;
      case 'country':
        country = state.value;
        break;
      case 'note':
        note = state.value;
        break;
      case 'email':
        email = state.value;
        break;
      default:
    }
  }

  List<dynamic> customerPhones = [];
  bool enableCustomerFilter = false;
  List<dynamic> filterdCustomers = [];

  void filterCustomer(String val) {
    if (val.isEmpty) {
      enableCustomerFilter = false;
      setState(() {});
      return;
    }

    enableCustomerFilter = true;
    filterdCustomers = customerPhones
        .where((element) => element.toString().contains(val))
        .toList();

    log('Filterd Customers: $customerPhones');
    setState(() {});
  }

  updateData() {
    final salesExra = context.read<MainCubit>().getExtraSales();
    loading = true;
    salesExra.then((value) {
      customers = value.data?.customers;
      customerPhones = customers?.map((e) => e.phone).toList() ?? [];
      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    updateData();
    calculateAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  void calculateAmount() {
    calculationLoading = true;
    setState(() {});

    try {
      var subTotal = widget.products
          .map((e) => e.qty * double.parse(e.totalPrice.toString()))
          .reduce((value, element) => value + element);
      
      var originalPrice = widget.products
          .map((e) => e.qty * double.parse(e.price.toString()))
          .reduce((value, element) => value + element);  
          
      taxAmount =  subTotal - originalPrice;
      widget.subTotal = subTotal;
      // taxAmount = (tax / 100) * double.parse(subTotal.toString());
      widget.grandTotal = subTotal - discountAmount;
    } catch (e) {
      log('Error: $e');
    } finally { 
      calculationLoading = false;
      setState(() {});
    }
  }

  Scaffold buildScaffold(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        height: 0.1 * screenHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04 * screenWidth,
            vertical: 0.02 * screenHeight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: ₹${widget.grandTotal.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Text(
                    '@including tax ₹${taxAmount.toStringAsFixed(3)}',  
                    style: const TextStyle( 
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              Container(
                width: 0.4 * screenWidth,
                height: 0.06 * screenHeight,
                decoration: BoxDecoration(
                  color: ColorConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    //loading dialog
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: ColorConstants.whiteColor,
                                  )),
                            ],
                          );
                        });

                    context.read<MainCubit>().createPosOrder({
                      'name': name,
                      'phone': phone,
                      'email': email,
                      'customer_id': customerId,
                      'address': address,
                      'street_address': streetAddress,
                      'city': city,
                      'state': states,
                      'zip': zip,
                      'country': country,
                      'note': note,
                      'discount': discountAmount,
                      'tax': taxAmount,
                      'payment_method': paymentMode,
                      'selected_products': (widget.products
                          .map((e) => {
                                'product_id': e.id,
                                'qty': e.qty,
                                'price': e.price,
                              })
                          .toList()),
                      'sub_total': widget.subTotal,
                      'grand_total': widget.grandTotal,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.message.toString())));

                      if (value.status == 'error') {
                        Navigator.pop(context);
                        return;
                      }

                      context.push('/pos/receipts', extra: {
                        'extra': {
                          'data': value.data,
                          'products': widget.products,
                        }
                      });
                    });

                    //context.push('/pos/receipts');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      calculationLoading == true
                          ? const Row(
                              children: [
                                SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                SizedBox(width: 10),
                              ],
                            )
                          : const SizedBox(),
                      const Text(
                        'Purchase',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('CART'),
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) {
          loading = false;
          if (state.data != null) {
            widget.subTotal = state.data['subTotal'];
            widget.grandTotal = state.data['grandTotal'];
            setState(() {});
          }
        }

        if (state is LoadingMainState) {
          loading = true;
          log('Loading');
        }

        if (state is ValidationErrorState) {
          log('Validation Error');
          errorBags = state.errors;
        }

        if (state is ChangeFormValuesState) {
          setValue(state);

          if (state.type == 'phone') {
            filterCustomer(state.value);
          }

          if (state.type == 'discount' || state.type == 'tax') {
            calculateAmount();
          }
          //   calculationLoading = true;
          //   log('Calculating');
          //   context.read<MainCubit>().sumCart(widget.subTotal,
          //       discount: int.parse(discountAmount.toString()),
          //       tax: int.parse(taxAmount.toString()));
          //   calculationLoading = false;
          // }
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
                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        shrinkWrap: true,
                        itemCount: widget.products.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    widget.products.removeAt(index);
                                    calculateAmount();
                                    setState(() {});
                                  },
                                  label: 'Delete',
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  widget.products[index].image ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(widget.products[index].name ?? '',
                                    style: const TextStyle(fontSize: 12)),
                                subtitle: Text(
                                  '₹${widget.products[index].price ?? 0}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    // color: Colors.grey.withOpacity(0.1),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () async {
                                                if (widget
                                                        .products[index].qty ==
                                                    1) {
                                                  return;
                                                }

                                                widget.products[index].qty =
                                                    widget.products[index].qty -
                                                        1;

                                                calculateAmount();
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                // size: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              widget.products[index].qty
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            InkWell(
                                              onTap: () async {
                                                widget.products[index].qty =
                                                    widget.products[index].qty +
                                                        1;
                                                calculateAmount();
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                // size: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      XInput(
                        labelExtra: InkWell(
                          onTap: () {
                            phone = '';
                            customerId = null;
                            setState(() {});
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: ColorConstants.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onlyCard: phone.length == 10,
                        initialValue: phone,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('phone', val);

                          if (val.length == 10) {
                            customerId = customers
                                ?.firstWhere((element) =>
                                    element.phone.toString() == val)
                                .id;
                            enableCustomerFilter = false;
                            context.read<MainCubit>().changeFormValues(
                                'customer_id', customerId.toString());
                            name = customers
                                    ?.firstWhere((element) =>
                                        element.phone.toString() == val)
                                    .name ??
                                '';
                            context
                                .read<MainCubit>()
                                .changeFormValues('name', name);
                          }
                        },
                        label: 'Phone',
                        hintText: 'Enter phone',
                        keyboardType: TextInputType.number,
                      ),
                      enableCustomerFilter == true && phone.length != 10
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: filterdCustomers.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                            filterdCustomers[index].toString()),
                                        onTap: () {
                                          context
                                              .read<MainCubit>()
                                              .changeFormValues(
                                                  'phone',
                                                  filterdCustomers[index]
                                                      .toString());
                                          phone = filterdCustomers[index]
                                              .toString();
                                          customerId = customers
                                              ?.firstWhere((element) =>
                                                  element.phone.toString() ==
                                                  filterdCustomers[index]
                                                      .toString())
                                              .id;
                                          context
                                              .read<MainCubit>()
                                              .changeFormValues('customer_id',
                                                  customerId.toString());
                                          name = customers
                                                  ?.firstWhere((element) =>
                                                      element.phone
                                                          .toString() ==
                                                      filterdCustomers[index]
                                                          .toString())
                                                  .name ??
                                              '';
                                          context
                                              .read<MainCubit>()
                                              .changeFormValues('name', name);
                                          enableCustomerFilter = false;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(height: 5),
                      XSelect(
                        readOnly: phone.length == 10,
                        extraLabel: InkWell(
                          onTap: () {
                            context.push('/sales/create_customers',
                                extra: updateData);
                          },
                          child: const Text(
                            'Add Customer', 
                            style: TextStyle(
                              color: ColorConstants.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        errorBags: errorBags,
                        model: 'customer_id',
                        value: customerId,
                        options: customers?.map((e) {
                              return DropDownItem(
                                label: e.name ?? '',
                                value: e.id.toString(),
                              );
                            }).toList() ??
                            [],
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('customer_id', val);

                          name = customers
                                  ?.firstWhere(
                                      (element) => element.id.toString() == val)
                                  .name ??
                              '';
                          context
                              .read<MainCubit>()
                              .changeFormValues('name', name);
                          phone = customers
                                  ?.firstWhere(
                                      (element) => element.id.toString() == val)
                                  .phone ??
                              '';
                          context
                              .read<MainCubit>()
                              .changeFormValues('phone', phone);
                        },
                        label: 'Select Customer',
                      ),
                      XInput(
                        initialValue: email,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('email', val);
                        },
                        label: 'Email',
                        hintText: 'Enter email',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: address,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('address', val);
                        },
                        label: 'Address',
                        hintText: 'Enter address',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: streetAddress,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('street_address', val);
                        },
                        label: 'Street Address',
                        hintText: 'Enter street address',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: city,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('city', val);
                        },
                        label: 'City',
                        hintText: 'Enter city',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: states,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('state', val);
                        },
                        label: 'State',
                        hintText: 'Enter state',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: zip,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('zip', val);
                        },
                        label: 'Zip',
                        hintText: 'Enter zip',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: country,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('country', val);
                        },
                        label: 'Country',
                        hintText: 'Enter country',
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        height: 0.2,
                        initialValue: note,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('note', val);
                        },
                        label: 'Note',
                        hintText: 'Enter note',
                      ),
                      XInput(
                        initialValue: discountAmount.toString(),
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('discount', val);
                        },
                        label: 'Discount',
                        hintText: 'Enter discount',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 5),
                      // XInput(
                      //   readOnly: true,
                      //   initialValue: taxAmount.toString(),
                      //   onChanged: (val) {
                      //     context
                      //         .read<MainCubit>()
                      //         .changeFormValues('tax', val);
                      //   },
                      //   label: 'Tax',
                      //   hintText: 'Tax',
                      //   keyboardType: TextInputType.number,
                      // ),
                      // const SizedBox(height: 5),
                      XSelect(
                        errorBags: errorBags,
                        model: 'payment_method',
                        value: paymentMode,
                        options: [
                          DropDownItem(
                            label: 'Cash',
                            value: 'Cash',
                          ),
                          DropDownItem(
                            label: 'Credit',
                            value: 'Credit',
                          ),
                        ],
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('payment_method', val);
                        },
                        label: 'Payment Mode',
                      ),
                    ],
                  ));
      }),
    );
  }
}
