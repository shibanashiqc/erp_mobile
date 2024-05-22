// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/products_model.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Pos extends StatefulWidget {
  const Pos({super.key});

  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();

  List<Data> products = [];

  dynamic subTotal = 0;
  dynamic tax = 0;
  dynamic discount = 0;
  dynamic grandTotal = 0;
  
  bool calculationLoading = false; 
  
  // roudOfAmount()
  // {}
  
  void loadData({query}) async
  {
    loading = true; 
    await context.read<MainCubit>().getProducts(query: {
      'search': query 
    }).then((value) {
      setState(() {
        loading = false;
        products = value.data!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    // loading = true;
    // departments.then((value) {
    //   setState(() {
    //     loading = false;
    //   });
    // });
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
                    'Total: ₹ $grandTotal',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Items:  ${products.where((element) => element.isSelected == true).length}',
                    style: const TextStyle(
                      fontSize: 12,
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
                    if (products
                        .where((element) => element.isSelected == true)
                        .isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content:
                                const Text('Please select atleast one product'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          );
                        },
                      );
                      return; 
                    }
                    
                    log('Products: ${json.encode(products
                            .where((element) => element.isSelected == true)
                            .toList())}');      
  
                    context.push('/pos/cart', extra: { 
                      'extra': {
                        'products': products
                            .where((element) => element.isSelected == true)
                            .toList(),
                        'subTotal': subTotal, 
                        'tax': tax,
                        'discount': discount,
                        'grandTotal': grandTotal,
                      }
                    });
                    
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,  
                    children: [
                      
                       calculationLoading == true
                          ? const Row(
                              children: [
                                SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                SizedBox(width: 10),
                              ],
                            )
                          : const SizedBox(),
                      
                      const Text(
                        'Checkout',
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
        title: const Text('POS'),
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) { 
          if (state.data != null) {
            subTotal = state.data['subTotal'];
            grandTotal = state.data['grandTotal'];
            setState(() {});
          }
          calculationLoading = false;   
        }

        if (state is LoadingMainState) {
          log('Loading');
          calculationLoading = true; 
        }

        if (state is RefreshMainState) {}
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
                        onChanged: (value) {
                          loadData(query: value);  
                        },
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),


                     products.isEmpty
                        ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8, 
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, 
                              children: [
                                const  Text('No products found'),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    context.push('/product/add_product');   
                                  }, 
                                  child: const Text('Add Products'),
                                ) 
                              ],
                            ),
                          ),
                        )
                        : 
                    
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          // shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(5),
                                //
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Center(child: Icon(Icons.error)),
                                    products[index].image ?? '',
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index].name ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              '₹${products[index].price} /-',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              'SK: ${products[index].quantity}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey.withOpacity(0.1),
                                                border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () async {
                                                        if (products[index]
                                                                .qty ==
                                                            0) {
                                                          products[index]
                                                                  .isSelected =
                                                              false;

                                                          setState(() {});
                                                          return;
                                                        }

                                                        products[index].qty =
                                                            products[index]
                                                                    .qty -
                                                                1;

                                                        context
                                                            .read<MainCubit>()
                                                            .sumCart(products
                                                                .where((element) =>
                                                                    element
                                                                        .isSelected ==
                                                                    true)
                                                                .map((e) =>
                                                                    e.qty *
                                                                    double.parse(e
                                                                        .price
                                                                        .toString()))
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element));

                                                        if (products[index]
                                                                .qty ==
                                                            0) {
                                                          products[index]
                                                                  .isSelected =
                                                              false;
                                                        }

                                                        await context
                                                            .read<MainCubit>()
                                                            .refreshState();
                                                      },
                                                      child: const Icon(
                                                          Icons.remove),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      products[index]
                                                          .qty
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () async {
                                                        products[index]
                                                            .isSelected = true;
                                                        products[index].qty =
                                                            products[index]
                                                                    .qty +
                                                                1;

                                                        context
                                                            .read<MainCubit>()
                                                            .sumCart(products
                                                                .where((element) =>
                                                                    element
                                                                        .isSelected ==
                                                                    true)
                                                                .map((e) =>
                                                                    e.qty *
                                                                    double.parse(e
                                                                        .price
                                                                        .toString()))
                                                                .reduce((value,
                                                                        element) =>
                                                                    value +
                                                                    element));

                                                        await context
                                                            .read<MainCubit>()
                                                            .refreshState();
                                                      },
                                                      child:
                                                          const Icon(Icons.add),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ]),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: ColorConstants
                                                    .secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  products[index].isSelected =
                                                      true;
                                                  context
                                                      .read<MainCubit>()
                                                      .sumCart(products
                                                          .where((element) =>
                                                              element
                                                                  .isSelected ==
                                                              true)
                                                          .map((e) =>
                                                              e.qty *
                                                              double.parse(e
                                                                  .price
                                                                  .toString()))
                                                          .reduce((value,
                                                                  element) =>
                                                              value + element));
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    size: 20,
                                                    Icons.add_shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}
