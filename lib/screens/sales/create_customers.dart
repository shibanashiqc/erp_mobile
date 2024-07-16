// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateCustomers extends StatefulWidget {
  int? editId;
  dynamic data = {};
  Function()? onSaved;
  CreateCustomers({super.key, this.editId, this.data, this.onSaved});

  @override
  State<CreateCustomers> createState() => _CreateCustomersState();
}

class _CreateCustomersState extends State<CreateCustomers>
    with SingleTickerProviderStateMixin {
  List<CustomerTypes> customerTypes = [];
  List<Country> countries = [];
  List<Errors> errorBags = [];
  bool isLoading = false;
  TabController? _tabController;
  String imageUrl = '';
  

  Map<String, dynamic> options = {
    'edit_id': '',
    'name': '',
    'email': '',
    'phone': '',
    'company_name': '',
    'alternate_phone': '',
    'pan_number': '',
    'image': '',
    'dob': '',
    'blood_group': '',
    'customer_type_id': '',
    'billing_attention': '',
    'billing_country_id': '',
    'billing_address': '',
    'billing_state_id': '',
    'billing_city_id': '',
    'billing_zip': '',
    'billing_phone': '',
    'billing_fax': '',
    'shipping_attention': '',
    'shipping_country_id': '',
    'shipping_address': '',
    'shipping_state_id': '',
    'shipping_city_id': '',
    'shipping_zip': '',
    'shipping_phone': '',
    'shipping_fax': '',
    'image_url' : '', 
  };

  set setValue(ChangeFormValuesState state) {
    try {
      options[state.type] = state.value;
    } catch (e) {
      log('Error: $e');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isLoading = true;

    setState(() {});
 
    if (widget.editId != null) {
      options['edit_id'] = widget.editId.toString();
      imageUrl = widget.data?['image'] ?? '';
      options['image_url'] = widget.data?['image'] ?? '';  
      // log('Image: ${options['image_url']}'); 
      for (var key in widget.data!.keys) { 
        options[key] = widget.data?[key].toString() ?? '';
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final salesExra = await context.read<HrCubit>().getExtraSales();
      customerTypes = salesExra.data?.customerTypes ?? [];
      countries = salesExra.data?.country ?? [];
      isLoading = false;
      setState(() {});
    });
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
          context.read<HrCubit>().createCustomers(options).then((value) {
            if (value.status == 'error') {
              errorBags = value.errors!;
              setState(() {});
              return;
            } 
             
            // log(widget.onSaved.toString());
            // widget.onSaved != null ? widget.onSaved!() : null;
            context.pop(); 
          });
          
           ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saving...')));
          
          widget.onSaved != null ? await widget.onSaved!() : null;
         
          
        },
      ),
      appBar: AppBar(
        title: const Text('Customers Update or Create'),
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
        }
      }, builder: (context, state) {
        return isLoading
            ? const Center(
                child: SizedBox(
                    height: 10, width: 10, child: CircularProgressIndicator()))
            : XContainer(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XSelect(
                      options: customerTypes.map((e) {
                        return DropDownItem(
                            value: e.id.toString(), label: e.name);
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<HrCubit>()
                            .setValues('customer_type_id', value);
                      },
                      label: 'Customer Type',
                      value: options['customer_type_id']),
                  XInput(
                    model: 'name',
                    errorBags: errorBags,
                    initialValue: options['name'],
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('name', value);
                    },
                    isMandatory: true,
                    label: 'Name',
                    hintText: 'Enter name',
                  ),
                  XInput(
                    initialValue: options['email'],
                    model: 'email',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('email', value);
                    },
                    label: 'Email',
                    hintText: 'Enter email',
                  ),
                  XInput(
                    initialValue: options['phone'],
                    model: 'phone',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('phone', value);
                    },
                    label: 'Phone',
                    hintText: 'Enter phone',
                  ),

                  // all other fields
                  XInput(
                    initialValue: options['alternate_phone'],
                    model: 'alternate_phone',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context
                          .read<HrCubit>()
                          .setValues('alternate_phone', value);
                    },
                    label: 'Alternate Phone',
                    hintText: 'Enter alternate phone',
                  ),

                  XInput(
                    initialValue: options['company_name'],
                    model: 'company_name',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('company_name', value);
                    },
                    label: 'Company Name',
                    hintText: 'Enter company name',
                  ),

                  XInput(
                    initialValue: options['pan_number'],
                    model: 'pan_number',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('pan_number', value);
                    },
                    label: 'Pan Number',
                    hintText: 'Enter pan number',
                  ),

                  XFileImage
                  (
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('image', value);
                    },
                    label: 'Image', 
                  ),
                  
                  imageUrl.isNotEmpty
                      ? ImageWidget(imageUrl: imageUrl)
                      : const SizedBox(), 

                  XInput(
                    type: 'date',
                    initialValue: options['dob'],
                    model: 'dob',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('dob', value);
                    },
                    label: 'Date of Birth',
                    hintText: 'Enter date of birth',
                  ),

                  XInput(
                    initialValue: options['blood_group'],
                    model: 'blood_group',
                    errorBags: errorBags,
                    onChanged: (value) {
                      context.read<HrCubit>().setValues('blood_group', value);
                    },
                    label: 'Blood Group',
                    hintText: 'Enter blood group',
                  ),

                  TabBar(
                    unselectedLabelColor: Colors.black,
                    // labelColor: Colors.red,
                    tabs: const [
                      Tab(
                        text: 'Billing',
                      ),
                      Tab(
                        text: 'Shipping',
                      ),
                     
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 800,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              XInput(
                                initialValue: options['billing_attention'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_attention', value),
                                label: 'Attention',
                                hintText: 'Enter attention',
                              ),
                              XInput(
                                initialValue: options['billing_address'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_address', value),
                                height: 0.2,
                                label: 'Address',
                                hintText: 'Enter address',
                              ),
                              XSelect(
                                value: options['billing_country_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_country_id', value),
                                label: 'Country',
                                options: countries
                                    .map((e) => DropDownItem(
                                        value: e.id.toString(), label: e.name))
                                    .toList(),
                              ),
                              XSelect(
                                value: options['billing_state_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_state_id', value),
                                label: 'State',
                                options: countries
                                        .where((element) =>
                                            element.id.toString() ==
                                            options['billing_country_id'])
                                        .firstOrNull
                                        ?.states
                                        ?.map((e) => DropDownItem(
                                            value: e.id.toString(),
                                            label: e.name))
                                        .toList() ??
                                    [],
                              ),
                              XSelect(
                                value: options['billing_city_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_city_id', value),
                                label: 'City',
                                options: countries
                                        .where((element) =>
                                            element.id.toString() ==
                                            options['billing_country_id'])
                                        .firstOrNull
                                        ?.states
                                        ?.where((element) =>
                                            element.id.toString() ==
                                            options['billing_state_id'])
                                        .firstOrNull
                                        ?.cities
                                        ?.map((e) => DropDownItem(
                                            value: e.id.toString(),
                                            label: e.name))
                                        .toList() ??
                                    [],
                              ),
                              XInput(
                                initialValue: options['billing_zip'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_zip', value),
                                label: 'Zip Code',
                                hintText: 'Enter zip code',
                              ),
                              XInput(
                                initialValue: options['billing_phone'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_phone', value),
                                label: 'Phone',
                                hintText: 'Enter phone',
                              ),
                              XInput(
                                initialValue: options['billing_fax'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('billing_fax', value),
                                label: 'Fax',
                                hintText: 'Enter fax',
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              XInput(
                                initialValue: options['shipping_attention'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_attention', value),
                                label: 'Attention',
                                hintText: 'Enter attention',
                              ),
                              XInput(
                                initialValue: options['shipping_address'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_address', value),
                                height: 0.2,
                                label: 'Address',
                                hintText: 'Enter address',
                              ),
                              XSelect(
                                value: options['shipping_country_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_country_id', value),
                                label: 'Country',
                                options: countries
                                    .map((e) => DropDownItem(
                                        value: e.id.toString(), label: e.name))
                                    .toList(),
                              ),
                              XSelect(
                                value: options['shipping_state_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_state_id', value),
                                label: 'State', 
                                options: countries.where((element) =>
                                        element.id.toString() ==
                                        options['shipping_country_id']).firstOrNull?.states?.map((e) => DropDownItem(
                                        value: e.id.toString(), label: e.name))
                                    .toList() ?? [],
                              ),
                              XSelect(
                                value: options['shipping_city_id'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_city_id', value),
                                label: 'City',
                                options: countries.where((element) =>
                                        element.id.toString() ==
                                        options['shipping_country_id']).firstOrNull?.states?.where((element) =>
                                        element.id.toString() ==
                                        options['shipping_state_id']).firstOrNull?.cities?.map((e) => DropDownItem(
                                        value: e.id.toString(), label: e.name)).toList() ?? [], 
                              ),
                              XInput(
                                initialValue: options['shipping_zip'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_zip', value),
                                label: 'Zip Code',
                                hintText: 'Enter zip code',
                              ),
                              XInput(
                                initialValue: options['shipping_phone'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_phone', value),
                                label: 'Phone',
                                hintText: 'Enter phone',
                              ),
                              XInput(
                                initialValue: options['shipping_fax'],
                                onChanged: (value) => context
                                    .read<HrCubit>()
                                    .setValues('shipping_fax', value),
                                label: 'Fax',
                                hintText: 'Enter fax',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
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
