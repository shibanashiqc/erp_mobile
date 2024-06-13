// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/product/product_extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class AddProduct extends StatefulWidget {
  int? editId;
  Map<String, dynamic>? data = {};
  Function()? onSaved;
  AddProduct({super.key, this.editId, this.data, this.onSaved});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool loading = false;
  String editId = '';
  String name = '';
  dynamic productTypeId;
  dynamic inventoryTypeId;
  String sku = '';
  dynamic categoryId;
  dynamic subCategoryId;
  File image = File('');
  String description = '';
  String purchasePrice = '';
  String salePrice = '';

  String imageUrl = '';
  String billImageUrl = '';

  String taxRate = '';
  String price = '';
  String quantity = '1';
  dynamic productBrandId;
  String expiryDate = '';
  String manufacturingDate = '';
  String receivedDate = '';
  dynamic modeOfReceive;
  File billImage = File('');
  dynamic productUnitId;

  List<Errors> errorBags = [];

  List<ProductTypes> productTypes = [];
  List<InventoryTypes> inventoryTypes = [];
  List<ProductBrands> brands = [];
  List<Category> categories = [];
  List<SubCategory> subCategories = [];
  List<Units> productUnits = [];
  bool isSubmiting = false;
  ModeOfReceive modeOfReceives = ModeOfReceive();
  String? barCode;

  set setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'name':
        name = state.value;
        break;
      case 'product_type_id':
        productTypeId = state.value;
        break;
      case 'inventory_type_id':
        inventoryTypeId = state.value;
        break;
      case 'sku':
        sku = state.value;
        break;
      case 'category_id':
        categoryId = state.value;
        break;
      case 'sub_category_id':
        subCategoryId = state.value;
        break;
      case 'price':
        price = state.value;
        break;
      case 'quantity':
        quantity = state.value;
        break;
      case 'brand_id':
        productBrandId = state.value;
        break;
      case 'product_unit_id':
        productUnitId = state.value;
        break;
      case 'purchase_price':
        purchasePrice = state.value;
        break;
      case 'sale_price':
        salePrice = state.value;
        break;
      case 'tax_rate':
        taxRate = state.value;
        break;
      case 'expiry_date':
        expiryDate = state.value;
        break;
      case 'manufacturing_date':
        manufacturingDate = state.value;
        break;
      case 'mode_of_receive':
        modeOfReceive = state.value;
        break;
      case 'description':
        description = state.value;
        break;
      case 'image':
        image = state.value;
        break;
      case 'bill_image':
        billImage = state.value;
        break;
      case 'received_date':
        receivedDate = state.value;
        break;
      default:
    }
  }

  Future<File> getImageFileFromUrl(String url) async {
    final File file = await DefaultCacheManager().getSingleFile(url);
    return file;
  }

  String generateRandom(int length) {
    Random random = Random();
    String num = '';
    for (int i = 0; i < length; i++) {
      num += random.nextInt(9).toString();
    }
    return num;
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    if (widget.editId != null) {
      editId = widget.editId.toString();
      name = widget.data?['name'] ?? '';
      productTypeId = widget.data?['product_type_id'].toString() ?? '';
      // inventoryTypeId = widget.data?['inventory_type_id'].toString() ?? '';
      sku = widget.data?['sku'].toString() ?? '';
      categoryId = widget.data?['category_id'].toString() ?? '';
      subCategoryId = widget.data?['sub_category_id'].toString() ?? '';
      price = widget.data?['price'].toString() ?? '';
      quantity = widget.data?['quantity'].toString() ?? '';
      productBrandId = widget.data?['product_brand_id'].toString() ?? '';
      productUnitId = widget.data?['product_unit_id'].toString() ?? '';
      purchasePrice = widget.data?['purchase_price'].toString() ?? '';
      salePrice = widget.data?['sale_price'].toString() ?? '';
      taxRate = widget.data?['tax_rate'].toString() ?? '';
      expiryDate = widget.data?['expiry_date'].toString() ?? '';
      manufacturingDate = widget.data?['manufacturing_date'].toString() ?? '';
      modeOfReceive = widget.data?['mode_of_receive'].toString() ?? '';
      receivedDate = widget.data?['received_date'].toString() ?? '';
      description = widget.data?['description'].toString() ?? '';

      imageUrl = widget.data?['image'].toString() ?? '';
      billImageUrl = widget.data?['bill_image'].toString() ?? '';

      barCode = widget.data?['bar_code'].toString() ?? '';

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      //   if (widget.data?['image'] != null) {
      //     image = await getImageFileFromUrl(widget.data?['image']);
      //   }

      //   if (widget.data?['bill_image'] != null) {
      //     billImage = await getImageFileFromUrl(widget.data?['bill_image']);
      //   }

      // });

      setState(() {});
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<MainCubit>().getExtraProducts().then((value) {
        productTypes = value.data?.productTypes ?? [];
        inventoryTypes = value.data?.inventoryTypes ?? [];
        brands = value.data?.productBrands ?? [];
        categories = value.data?.category ?? [];
        subCategories = value.data?.subCategory ?? [];
        productUnits = value.data?.units ?? [];
        modeOfReceives = value.data?.modeOfReceive ?? ModeOfReceive();
        loading = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: XButton(
        disabled: isSubmiting,
        // loading: context.select((MainCubit cubit) => cubit.state is LoadedMainState),
        label: 'Save',
        onPressed: () async {
          try {
            isSubmiting = true;
            setState(() {});
            await context.read<MainCubit>().createOrUpdateProduct({
              'edit_id': editId,
              'name': name,
              'product_type_id': productTypeId,
              'inventory_type_id': inventoryTypeId,
              'sku': sku,
              'category_id': categoryId,
              'sub_category_id': subCategoryId,
              'price': price,
              'quantity': quantity,
              'product_brand_id': productBrandId,
              'product_unit_id': productUnitId,
              'purchase_price': purchasePrice,
              'sale_price': price,
              'tax_rate': taxRate,
              'expiry_date': expiryDate,
              'manufacturing_date': manufacturingDate,
              'mode_of_receive': modeOfReceive,
              'received_date': receivedDate,
              'description': description,
              'bar_code': barCode,
              'symblogy': 'CODE128',
              'image': image.path != ''
                  ? await MultipartFile.fromFile(image.path)
                  : imageUrl,
              'bill_image': billImage.path != ''
                  ? await MultipartFile.fromFile(billImage.path)
                  : billImageUrl,
            }).then((value) {
              if (value.status != 'error') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(value.message ?? 'Data saved successfully')));
                // widget.onSaved!();
                context.push('/dashboard');
              } else {
                errorBags = value.errors ?? [];
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(value.message ?? 'Data not saved')));
              }

              isSubmiting = false;
              setState(() {});
            });
          } catch (e) {
            // log('error: $e');
          }
        },
      ),
      appBar: AppBar(
        title: const Text('Product Update or Create'),
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {}

        if (state is LoadedMainState) {
          loading = false;
          // log('state: $state');
        }

        if (state is LoadingMainState) {
          loading = true;
        }

        if (state is ValidationErrorState) {
          errorBags = state.errors;
          // log('errorBags: $errorBags');
          setState(() {});
        }

        if (state is ChangeFormValuesState) {
          setValue = state;
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
                      XInput(
                        model: 'name',
                        errorBags: errorBags,
                        initialValue: name,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('name', value);
                        },
                        isMandatory: true,
                        label: 'Title',
                        hintText: 'Enter title',
                      ),
                      XSelect(
                          errorBags: errorBags,
                          model: 'product_type_id',
                          value: productTypeId,
                          label: 'Product Type',
                          options: productTypes
                              .map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList(),
                          onChanged: (val) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('product_type_id', val);
                          }),

                      // XSelect(
                      //     errorBags: errorBags,
                      //     model: 'inventory_type_id',
                      //     value: inventoryTypeId,
                      //     label: 'Inventry Type',
                      //     options: inventoryTypes
                      //         .map((e) => DropDownItem(
                      //             value: e.id.toString(), label: e.name))
                      //         .toList(),
                      //     onChanged: (val) {
                      //       context
                      //           .read<MainCubit>()
                      //           .changeFormValues('inventory_type_id', val);
                      //     }),

                      XInput(
                        model: 'sku',
                        errorBags: errorBags,
                        initialValue: sku,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('sku', value);
                        },
                        isMandatory: true,
                        label: 'SKU',
                        hintText: 'Enter SKU',
                      ),
                      XSelect(
                          errorBags: errorBags,
                          model: 'brand_id',
                          value: productBrandId,
                          label: 'Brand',
                          options: brands
                              .map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList(),
                          onChanged: (val) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('brand_id', val);
                          }),
                      XSelect(
                          errorBags: errorBags,
                          model: 'category_id',
                          value: categoryId,
                          label: 'Category',
                          options: categories
                              .map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList(),
                          onChanged: (val) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('category_id', val);
                          }),
                      XSelect(
                          errorBags: errorBags,
                          model: 'sub_category_id',
                          value: subCategoryId,
                          label: 'Sub Category',
                          options: subCategories
                              .where((element) =>
                                  element.categoryId.toString() ==
                                  categoryId.toString())
                              .map((e) => DropDownItem(
                                  value: e.id.toString(), label: e.name))
                              .toList(),
                          onChanged: (val) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('sub_category_id', val);
                          }),
                      XInput(
                        model: 'price',
                        errorBags: errorBags,
                        initialValue: price,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('price', value);
                        },
                        isMandatory: true,
                        label: 'Price',
                        hintText: 'Enter Price',
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          XSelect(
                              // errorBags: errorBags,
                              model: 'product_unit_id',
                              value: productUnitId,
                              width: 0.32,
                              // height: 0.1,
                              label: 'Unit',
                              options: productUnits
                                  .map((e) => DropDownItem(
                                      value: e.id.toString(), label: e.name))
                                  .toList(),
                              onChanged: (val) {
                                context
                                    .read<MainCubit>()
                                    .changeFormValues('product_unit_id', val);
                              }),
                          const SizedBox(width: 10),
                          XInput(
                            keyboardType: TextInputType.number,
                            width: 0.6,
                            model: 'quantity',
                            // errorBags: errorBags,
                            initialValue: quantity,
                            onChanged: (value) {
                              context
                                  .read<MainCubit>()
                                  .changeFormValues('quantity', value);
                            },
                            isMandatory: true,
                            label: 'Quantity',
                            hintText: 'Enter Quantity',
                          ),
                        ],
                      ),

                      XFileImage(
                        file: image,
                        allowMultiple: false,
                        label: 'Image',
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('image', value);
                        },
                        isMandatory: true,
                      ),

                      imageUrl != '' && image.path == ''
                          ? ImageWidget(imageUrl: imageUrl)
                          : const SizedBox(),

                      XInput(
                        model: 'purchase_price',
                        errorBags: errorBags,
                        initialValue: purchasePrice,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('purchase_price', value);
                        },
                        isMandatory: true,
                        label: 'Purchase Price',
                        hintText: 'Enter Purchase Price',
                      ),
                      // XInput(
                      //   model: 'sale_price',
                      //   errorBags: errorBags,
                      //   initialValue: salePrice,
                      //   onChanged: (value) {
                      //     context
                      //         .read<MainCubit>()
                      //         .changeFormValues('sale_price', value);
                      //   },
                      //   isMandatory: true,
                      //   label: 'Sales Price',
                      //   hintText: 'Enter Sales Price',
                      // ),
                      XInput(
                        model: 'tax_rate',
                        errorBags: errorBags,
                        initialValue: taxRate,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('tax_rate', value);
                        },
                        isMandatory: true,
                        label: 'Tax Rate',
                        hintText: 'Enter Tax Rate',
                      ),
                      XInput(
                        type: 'date',
                        model: 'received_date',
                        errorBags: errorBags,
                        initialValue: receivedDate,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('received_date', value);
                        },
                        isMandatory: true,
                        label: 'Recived Date',
                        hintText: 'Enter Recived Date',
                      ),
                      XInput(
                        type: 'date',
                        model: 'expiry_date',
                        errorBags: errorBags,
                        initialValue: expiryDate,
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('expiry_date', value);
                        },
                        isMandatory: true,
                        label: 'Expiry Date',
                        hintText: 'Enter Expiry Date',
                      ),
                      XSelect(
                          model: 'mode_of_receive',
                          value: modeOfReceive,
                          errorBags: errorBags,
                          label: 'Mode of Recieve',
                          options: [
                            DropDownItem(value: 'courier', label: 'Courier'),
                            DropDownItem(value: 'self', label: 'Self'),
                            DropDownItem(
                                value: 'sales_person', label: 'Sales Person'),
                            DropDownItem(
                                value: 'container', label: 'Container'),
                            DropDownItem(value: 'other', label: 'Other'),
                          ],
                          onChanged: (val) {
                            context
                                .read<MainCubit>()
                                .changeFormValues('mode_of_receive', val);
                          }),
                      XInput(
                        type: 'date',
                        model: 'manufacturing_date',
                        errorBags: errorBags,
                        initialValue: manufacturingDate,
                        onChanged: (value) => context
                            .read<MainCubit>()
                            .changeFormValues('manufacturing_date', value),
                        isMandatory: true,
                        label: 'Manufactor Date',
                        hintText: 'Enter Manufactor Date',
                      ),
                      XFileImage(
                        file: billImage,
                        allowMultiple: false,
                        label: 'Bill Image',
                        onChanged: (value) {
                          context
                              .read<MainCubit>()
                              .changeFormValues('bill_image', value);
                        },
                        isMandatory: true,
                      ),

                      billImageUrl != '' && billImage.path == ''
                          ? ImageWidget(imageUrl: billImageUrl)
                          : const SizedBox(),

                      XInput(
                        height: 0.2,
                        model: 'description',
                        errorBags: errorBags,
                        initialValue: description,
                        onChanged: (value) => context
                            .read<MainCubit>()
                            .changeFormValues('description', value),
                        isMandatory: true,
                        label: 'Description',
                        hintText: 'Enter Description',
                      ),

                      barCode != 'null' && widget.editId != null
                          ? const SizedBox()
                          : Column(
                              children: [
                                XButton(
                                  color: ColorConstants.primaryColor,
                                  label: 'Generate Bar Code',
                                  onPressed: () {
                                    barCode = generateRandom(12);
                                    setState(() {});
                                  },
                                ),
                                XButton(
                                    icon: Icons.qr_code,
                                    label: 'Scan BARCODE',
                                    onPressed: () async {
                                      barCode = await FlutterBarcodeScanner
                                          .scanBarcode(
                                        '#ff6666',
                                        'Cancel',
                                        true,
                                        ScanMode.BARCODE,
                                      );
                                      
                                      setState(() {
                                      });

                                      // if (barcode == '-1') {
                                      //   return;
                                      // }

                                      try {} catch (e) {
                                        // log('Error: $e');
                                      }
                                    })
                              ],
                            ),

                      barCode != 'null'
                          ? Container(
                              color: Colors.white,
                              height: 80,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SfBarcodeGenerator(
                                  showValue: true,
                                  value: barCode ?? '',
                                  symbology: Code128(),
                                ),
                              ),
                            )
                          : const SizedBox(),

                      const SizedBox(height: 60),
                    ],
                  ));
      }),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ]),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        imageUrl,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )),
        const SizedBox(height: 10),
      ],
    );
  }
}
