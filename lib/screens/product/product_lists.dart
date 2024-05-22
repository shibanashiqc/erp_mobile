// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/pos/products_model.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProductLists extends StatefulWidget {
  const ProductLists({super.key});

  @override
  State<ProductLists> createState() => _ProductListsState();
}

class _ProductListsState extends State<ProductLists> {
  bool loading = false;
  int limit = 10; 
  List<Data> products = [];
  late ScrollController controller;
  
  void lodaData({query}) async {
    loading = true;
    await context.read<MainCubit>().getProducts(
      limit: limit, 
      query: {
      'search': query,
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
    lodaData();
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
                          controller: controller, 
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
                                            overflow: TextOverflow.ellipsis,  
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
                                        
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                                        children: [
                                          
                                          IconButton(
                                            onPressed: () {
                                              context.push('/product/add_product',
                                              extra: {
                                              'id' : products[index].id, 
                                              'extra' : products[index]        
                                              }); 
                                            },
                                            icon: const Icon(CupertinoIcons.pencil),
                                          ), 
                                          
                                          IconButton( 
                                            onPressed: () {
                                              // context.read<MainCubit>().deleteProduct(products[index].id!);
                                            },
                                            icon: const Icon(CupertinoIcons.trash),
                                          ), 
                                          
                                          
                                        ],),
                                        const SizedBox(height: 12),
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
