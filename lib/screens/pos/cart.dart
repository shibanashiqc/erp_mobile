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
  String paymentMode = 'Cash';
  DateTime focusedDay = DateTime.now();
  List<Errors> errorBags = [];

  String name = '';
  String phone = '';

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
      default:
    }
  }

  @override
  void initState() {
    final salesExra = context.read<MainCubit>().getExtraSales();
    loading = true;
    salesExra.then((value) {
      customers = value.data?.customers;
      loading = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
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
                    context.read<MainCubit>().createPosOrder({
                      'name': name,
                      'phone': phone,
                      'customer_id': customerId,
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
                      if (value.status == 'error') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.message.toString())));
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
          if (state.type == 'discount' || state.type == 'tax') {
            calculationLoading = true;
            log('Calculating');
            context.read<MainCubit>().sumCart(widget.subTotal,
                discount: int.parse(discountAmount.toString()),
                tax: int.parse(taxAmount.toString()));
            calculationLoading = false;
          }
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
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListTile(
                              leading: Image.network(
                                widget.products[index].image ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(widget.products[index].name ?? ''),
                              subtitle:
                                  Text('₹${widget.products[index].price ?? 0}'),
                              trailing: Container(
                                width: 90,
                                decoration: BoxDecoration(
                                  // color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () async {
                                          context.pop();

                                          // if (widget.products[index].qty == 0) {
                                          //   widget.products[index].isSelected =
                                          //       false;

                                          //   setState(() {});
                                          //   return;
                                          // }

                                          // widget.products[index].qty =
                                          //     widget.products[index].qty - 1;

                                          // context.read<MainCubit>().sumCart(
                                          //     widget.products
                                          //         .where((element) =>
                                          //             element.isSelected ==
                                          //             true)
                                          //         .map((e) =>
                                          //             e.qty *
                                          //             double.parse(
                                          //                 e.price.toString()))
                                          //         .reduce((value, element) =>
                                          //             value + element));

                                          // if (widget.products[index].qty == 0) {
                                          //   widget.products[index].isSelected =
                                          //       false;
                                          // }

                                          // await context
                                          //     .read<MainCubit>()
                                          //     .refreshState();
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.products[index].qty.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () async {
                                          context.pop();
                                          // widget.products[index].isSelected =
                                          //     true;
                                          // widget.products[index].qty =
                                          //     widget.products[index].qty + 1;

                                          // context.read<MainCubit>().sumCart(
                                          //     widget.products
                                          //         .where((element) =>
                                          //             element.isSelected ==
                                          //             true)
                                          //         .map((e) =>
                                          //             e.qty *
                                          //             double.parse(
                                          //                 e.price.toString()))
                                          //         .reduce((value, element) =>
                                          //             value + element));

                                          // await context
                                          //     .read<MainCubit>()
                                          //     .refreshState();
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      
                       XInput(
                        initialValue: phone,
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('phone', val);
                              
                              if (val.length == 10) {
                                customers?.forEach((element) {
                                  customerId = element.id;
                                  context
                                      .read<MainCubit>()
                                      .changeFormValues('customer_id', element.id.toString()); 
                                  name = element.name ?? '';
                                  context
                                      .read<MainCubit>()
                                      .changeFormValues('name', element.name ?? '');  
                                }); 
                              }
                              
                        },
                        label: 'Phone',
                        hintText: 'Enter phone',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 5), 
                      
                      XSelect(
                        extraLabel: InkWell(
                          onTap: () {
                            context.push('/sales/create_customers');
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
                        },
                        label: 'Select Customer',
                      ),
                      // XInput(
                      //   initialValue: name,
                      //   onChanged: (val) {
                      //     context
                      //         .read<MainCubit>()
                      //         .changeFormValues('name', val);
                      //   },
                      //   label: 'Name',
                      //   hintText: 'Enter name',
                      // ),
                      // const SizedBox(height: 5),
                     
                      XInput(
                        initialValue: discountAmount.toString(),
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('discount', val);
                        },
                        label: 'Discount%',
                        hintText: 'Enter discount',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 5),
                      XInput(
                        initialValue: taxAmount.toString(),
                        onChanged: (val) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('tax', val);
                        },
                        label: 'Tax%',
                        hintText: 'Tax',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 5),
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
