// ignore_for_file: must_be_immutable, unrelated_type_equality_checks

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/products_model.dart';
import 'package:erp_mobile/models/product/product_extra_model.dart' as product;
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/common/x_select_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProductLists extends StatefulWidget {
  const ProductLists({super.key});

  @override
  State<ProductLists> createState() => _ProductListsState();
}

class _ProductListsState extends State<ProductLists> {
  bool loading = false;
  int limit = 10;
  List<Data> products = [];
  String categoryId = '';
  late ScrollController controller;
  List<product.Category> categories = [];

  void lodaData({query}) async {
    loading = true;
    await context.read<MainCubit>().getProducts(
        limit: limit,
        query: {'search': query, 'category_id': categoryId}).then((value) {
      setState(() {
        loading = false;
        products = value.data!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    lodaData();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<MainCubit>().getExtraProducts().then((value) {
        categories = value.data?.category ?? [];
        setState(() {});
      });
    });
    controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      lodaData();
    }
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
      appBar: AppBar(
        title: const Text('PRODUCTS'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/product/add_product');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
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
                      XSelect(
                        value: categoryId,
                        options: categories.map((e) {
                          return DropDownItem(
                              value: e.id.toString(), label: e.name);
                        }).toList(),
                        onChanged: (value) {
                          categoryId = value;
                          lodaData();
                        }, 
                        label: 'Select Category',
                      ),
                      XInput(
                        onChanged: (value) {
                          lodaData(query: value);
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
                                    const Text('No products found'),
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
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: GridView.builder(
                                controller: controller,
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.6,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Center(
                                                      child: Icon(Icons.error)),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    '₹${products[index].price} /-',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    'SK: ${products[index].quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      context.push(
                                                          '/product/add_product',
                                                          extra: {
                                                            'id':
                                                                products[index]
                                                                    .id,
                                                            'extra':
                                                                products[index]
                                                          });
                                                    },
                                                    icon: const Icon(
                                                        CupertinoIcons.pencil),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Delete Product'),
                                                              content: const Text(
                                                                  'Are you sure you want to delete this product?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    context
                                                                        .read<
                                                                            MainCubit>()
                                                                        .deleteProduct({
                                                                      'id': products[
                                                                              index]
                                                                          .id
                                                                    }).then((value) {
                                                                      if (value
                                                                              .status ==
                                                                          200) {
                                                                        lodaData();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: const Text(
                                                                      'Delete'),
                                                                ),
                                                              ],
                                                            );
                                                          });

                                                      // context.read<MainCubit>().deleteProduct({
                                                      //   'id' : products[index].id
                                                      // }).then((value) {
                                                      //   if(value.status == 200){
                                                      //     lodaData();
                                                      //   }
                                                      // });
                                                    },
                                                    icon: const Icon(
                                                        CupertinoIcons.trash),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                            ],
                                          ),
                                        ),
                                        products[index].barCode != ''
                                            ? Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              if (products[
                                                                          index]
                                                                      .barCode !=
                                                                  '') {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        title: Text(products[index].name ??
                                                                            ''),
                                                                        content:
                                                                            Container(
                                                                          color:
                                                                              Colors.white,
                                                                          height:
                                                                              80,
                                                                          width:
                                                                              200,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                SfBarcodeGenerator(
                                                                              showValue: true,
                                                                              value: products[index].barCode,
                                                                              symbology: Code128(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                              }
                                                            },
                                                            child: const Icon(
                                                                Icons.qr_code)),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          products[index]
                                                                  .barCode ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
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
