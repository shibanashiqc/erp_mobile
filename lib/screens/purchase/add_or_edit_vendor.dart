// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';
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

class AddOrEditVendor extends StatefulWidget {
  int? editId;
  Map<String, dynamic>? data = {};
  Function()? onSaved;
  AddOrEditVendor({super.key, this.editId, this.data, this.onSaved});

  @override
  State<AddOrEditVendor> createState() => _AddOrEditVendorState();
}

class _AddOrEditVendorState extends State<AddOrEditVendor>
    with SingleTickerProviderStateMixin {
  String name = '';
  String lastName = '';
  String companyName = '';
  String vendorDisplayName = '';
  String email = '';
  String phone = '';
  String mobile = '';
  String pan = '';
  dynamic currencyId;
  dynamic paymentTermId; 
  dynamic languageId; 
  File document = File(''); 
  String bankName = '';
  String accountName = '';
  String accountNumber = '';
  String ifscCode = '';
  String billingAttention = '';
  String billingAddress = '';
  dynamic billingCountryId;
  dynamic billingStateId;
  dynamic billingCityId;
  String billingZip = '';
  String billingPhone = '';
  String billingFax = '';
  String shippingAttention = '';
  String shippingAddress = '';
  dynamic shippingCountryId;
  dynamic shippingStateId;
  dynamic shippingCityId;
  String shippingZip = '';
  String shippingPhone = '';
  String shippingFax = '';
  
  

  List<Errors> errorBags = [];

  set setValue(ChangeFormValuesState state) {
    switch (state.type) {
      case 'name':
        name = state.value;
        break;
      case 'last_name':
        lastName = state.value;
        break;
      case 'company_name':
        companyName = state.value;
        break;
      case 'vendor_display_name':
        vendorDisplayName = state.value;
        break;
      case 'email':
        email = state.value;
        break;
      case 'phone':
        phone = state.value;
        break;
      case 'mobile':
        mobile = state.value;
        break;
      case 'pan':
        pan = state.value;
        break;
      case 'currency_id':
        currencyId = state.value;
        break;
      case 'payment_term_id':
        paymentTermId = state.value;
        break;
      case 'language_id':
        languageId = state.value;
        break;
        case 'document':  
        document = state.value; 
        break; 
      case 'bank_name':
        bankName = state.value;
        break;
      case 'account_name':
        accountName = state.value;
        break;
      case 'account_number':
        accountNumber = state.value;
        break;
      case 'ifsc_code':
        ifscCode = state.value;
        break;
      case 'billing_attention':
        billingAttention = state.value;
        break;
      case 'billing_address':
        billingAddress = state.value;
        break;
      case 'billing_country_id':  
        billingCountryId = state.value;
        break;
      case 'billing_state_id':
        billingStateId = state.value;
        break;
      case 'billing_city_id':
        billingCityId = state.value;
        break;
      case 'billing_zip': 
        billingZip = state.value;
        break;
      case 'billing_phone':
        billingPhone = state.value;
        break;
      case 'billing_fax':
        billingFax = state.value;
        break;
      case 'shipping_attention':
        shippingAttention = state.value;
        break;
      case 'shipping_address':
        shippingAddress = state.value;
        break;
      case 'shipping_country_id':
        shippingCountryId = state.value;
        break;
      case 'shipping_state_id':
        shippingStateId = state.value;
        break;
      case 'shipping_city_id':
        shippingCityId = state.value;
        break;  
      case 'shipping_zip':
        shippingZip = state.value;
        break;
      case 'shipping_phone':
        shippingPhone = state.value;
        break;
      case 'shipping_fax':
        shippingFax = state.value;
        break;
      default: 
    }
  }

  TabController? _tabController;
  
  List<Currencies> currency = [];
  List<Payterms> paymentTerm = [];
  List<Languages> language = [];
  
  List<Countries> countries = [];
  List<States> states = [];
  List<Cities> cities = []; 

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    
     SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      
     await context.read<HrCubit>().getExtra().then((value) { 
        currency = value.data?.currencies ?? [];
        paymentTerm = value.data?.payterms ?? [];
        language = value.data?.languages ?? [];
        countries = value.data?.countries ?? [];
        states = value.data?.states ?? [];
        cities = value.data?.cities ?? [];
        setState(() { 
        });  
      });


      
    });

    if (widget.editId != null) {
      name = widget.data?['name'];
      email = widget.data?['email'];
      phone = widget.data?['phone'];
      mobile = widget.data?['mobile'];
      lastName = widget.data?['last_name'];
      companyName = widget.data?['company_name'];
      vendorDisplayName = widget.data?['vendor_display_name'];
      pan = widget.data?['pan'];  
      currencyId = widget.data?['currency_id'].toString() == 'null' ? currencyId : widget.data?['currency_id'].toString();   
      paymentTermId = widget.data?['payment_term_id'].toString() == 'null' ? paymentTermId : widget.data?['payment_term_id'].toString();
      languageId = widget.data?['language_id'].toString() == 'null' ? languageId : widget.data?['language_id'].toString() ;
      // document = widget.data?['document']; 
      bankName = widget.data?['bank_name'] ?? ''; 
      accountName = widget.data?['account_name'] ?? '';   
      accountNumber = widget.data?['account_number'] ?? '';
      ifscCode = widget.data?['ifsc_code'] ?? '';
      billingAttention = widget.data?['billing_attention'] ?? '';
      billingAddress = widget.data?['billing_address']?? '';
      billingCountryId = widget.data?['billing_country_id'].toString() ?? '';
      billingStateId = widget.data?['billing_state_id'].toString() ?? '';
      billingCityId = widget.data?['billing_city_id'].toString() ?? '';
      billingZip = widget.data?['billing_zip'] ?? '';
      billingPhone = widget.data?['billing_phone'] ?? '';
      billingFax = widget.data?['billing_fax'] ?? '';
      shippingAttention = widget.data?['shipping_attention'] ?? ''; 
      shippingAddress = widget.data?['shipping_address'] ?? '';
      shippingCountryId = widget.data?['shipping_country_id'].toString() ?? '';
      shippingStateId = widget.data?['shipping_state_id'].toString() ?? '';
      shippingCityId = widget.data?['shipping_city_id'].toString() ?? '';
      shippingZip = widget.data?['shipping_zip'] ?? '';
      shippingPhone = widget.data?['shipping_phone'] ?? '';
      shippingFax = widget.data?['shipping_fax'] ?? ''; 
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
        onPressed: () {
          context.read<HrCubit>().createVendor({
            'edit_id': widget.editId,
            'name': name,
            'last_name': lastName,
            'company_name': companyName,
            'vendor_display_name': vendorDisplayName,
            'email': email,
            'phone': phone,
            'mobile': mobile,
            'pan': pan,
            'currency_id': currencyId,
            'payment_term_id': paymentTermId,
            'language_id': languageId,
            'document': document,
            'bank_name': bankName,
            'account_name': accountName,
            'account_number': accountNumber,
            'ifsc_code': ifscCode,
            'billing_attention': billingAttention,
            'billing_address': billingAddress,
            'billing_country_id': billingCountryId,
            'billing_state_id': billingStateId,
            'billing_city_id': billingCityId,
            'billing_zip': billingZip,
            'billing_phone': billingPhone,
            'billing_fax': billingFax,
            'shipping_attention': shippingAttention,
            'shipping_address': shippingAddress,
            'shipping_country_id': shippingCountryId,
            'shipping_state_id': shippingStateId,
            'shipping_city_id': shippingCityId,
            'shipping_zip': shippingZip,
            'shipping_phone': shippingPhone,
            'shipping_fax': shippingFax,
          }).then((value) {
            if (value.status == 'error') {
              errorBags = value.errors!;
              setState(() {
              });
             return;
            }

             ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.message.toString())));
           widget.onSaved != null ? widget.onSaved!() : null;
           context.push('/dashboard');   
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Vendor Update or Create'),
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
        return XContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XInput(
              model: 'name',
              errorBags: errorBags,
              initialValue: name,
              onChanged: (value) {
                context.read<HrCubit>().setValues('name', value);
              },
              isMandatory: true,
              label: 'Name',
              hintText: 'Enter name',
            ),
            XInput(
              initialValue: lastName,
              model: 'last_name',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('last_name', value);
              },
              label: 'Last Name',
              hintText: 'Enter last name',
            ),
            XInput(
              initialValue: companyName,
              model: 'company_name',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('company_name', value);
              },
              label: 'Company Name',
              hintText: 'Enter company name',
            ),
            XInput(
              initialValue: vendorDisplayName,
              model: 'vendor_display_name',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('vendor_display_name', value);
              },
              label: 'Vendor Display Name',
              hintText: 'Enter vendor display name',
            ),
            XInput(
              initialValue: email,
              model: 'email',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('email', value);
              },
              label: 'Email',
              hintText: 'Enter email',
            ),
            XInput(
              initialValue: phone,
              model: 'phone',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('phone', value);
              },
              label: 'Phone',
              hintText: 'Enter phone',
            ),
            XInput(
              initialValue: mobile,
              model: 'mobile',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('mobile', value);
              },
              label: 'Mobile',
              hintText: 'Enter mobile',
            ),
            XInput(
              initialValue: pan,
              model: 'pan',
              errorBags: errorBags,
              onChanged: (value) {
                context.read<HrCubit>().setValues('pan', value);
              },
              label: 'Pan',
              hintText: 'Enter pan',
            ),
            XSelect(
                value: currencyId,
                model: 'currency_id',
                errorBags: errorBags, 
                onChanged: (value) {
                  context.read<HrCubit>().setValues('currency_id', value);
                },
                label: 'Currency',
                options: currency
                    .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                    .toList() 
                ),
            XSelect(
                value: paymentTermId,
                model: 'payment_term_id',
                errorBags: errorBags,
                onChanged: (value) {
                  context.read<HrCubit>().setValues('payment_term_id', value);
                },
                label: 'Payment Term',
                options: paymentTerm
                    .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                    .toList() 
              ),
            XSelect(
                value: languageId,   
                model: 'language_id',
                errorBags: errorBags,
                onChanged: (value) {
                  context.read<HrCubit>().setValues('language_id', value);
                },
                label: 'Language',
                options: language
                    .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                    .toList()
              ), 
              
            XFileImage(
                label: 'Document',
                isMandatory: true,
                onChanged: (value) {
                  document = value;
                }),
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
                Tab(
                  text: 'Bank',
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
                          initialValue: billingAttention,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_attention', value),
                          label: 'Attention',
                          hintText: 'Enter attention',
                        ),
                        XInput(
                          initialValue: billingAddress,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_address', value),
                          height: 0.2,
                          label: 'Address',
                          hintText: 'Enter address',
                        ),
                        
                        XSelect(
                          value: billingCountryId,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_country_id', value),
                          label: 'Country',
                          options: countries
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(), 
                        ),
                        XSelect(
                          value: billingStateId,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_state_id', value),
                          label: 'State',
                          options: states
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(),
                        ),
                        XSelect(
                          value: billingCityId,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_city_id', value),
                          label: 'City',
                          options: cities
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(), 
                        ),
                        XInput(
                          initialValue: billingZip,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_zip', value),
                          label: 'Zip Code',
                          hintText: 'Enter zip code',
                        ),
                        XInput(
                          initialValue: billingPhone,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_phone', value),
                          label: 'Phone',
                          hintText: 'Enter phone',
                        ),
                        XInput(
                          initialValue: billingFax,
                          onChanged: (value) => context.read<HrCubit>().setValues('billing_fax', value),
                          label: 'Fax',
                          hintText: 'Enter fax',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        XInput(
                          initialValue: shippingAttention,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_attention', value),
                          label: 'Attention',
                          hintText: 'Enter attention',
                        ),
                        XInput(
                          initialValue: shippingAddress,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_address', value),
                          height: 0.2,
                          label: 'Address',
                          hintText: 'Enter address',
                        ),
                        XSelect(
                          value: shippingCountryId,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_country_id', value),
                          label: 'Country',
                          options: countries
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(),
                        ),
                        XSelect(
                          value: shippingStateId,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_state_id', value),
                          label: 'State',
                          options: states
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(),
                        ),
                        XSelect(
                          value: shippingCityId,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_city_id', value),
                          label: 'City',
                          options: cities
                              .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                              .toList(),     
                        ),
                        XInput(
                          initialValue: shippingZip,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_zip', value),
                          label: 'Zip Code',
                          hintText: 'Enter zip code',
                        ),
                        XInput(
                          initialValue: shippingPhone,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_phone', value),
                          label: 'Phone',
                          hintText: 'Enter phone',
                        ),
                        XInput(
                          initialValue: shippingFax,
                          onChanged: (value) => context.read<HrCubit>().setValues('shipping_fax', value),
                          label: 'Fax',
                          hintText: 'Enter fax',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        
                         XInput(
                          initialValue: accountName,
                          onChanged: (value) => context.read<HrCubit>().setValues('account_name', value),
                          label: 'Account Name', 
                          hintText: 'Enter Account name',
                        ),
                        
                        XInput(
                          initialValue: bankName,
                          onChanged: (value) => context.read<HrCubit>().setValues('bank_name', value),
                          label: 'Bank Name',
                          hintText: 'Enter bank name',
                        ),
                        XInput(
                          initialValue: accountNumber,
                          onChanged: (value) => context.read<HrCubit>().setValues('account_number', value),
                          label: 'Account Number',
                          hintText: 'Enter account number',
                        ),
                       
                        XInput(
                          initialValue: ifscCode,
                          onChanged: (value) => context.read<HrCubit>().setValues('ifsc_code', value), 
                          label: 'ISFC Code', 
                          hintText: 'Enter ISFC code', 
                        ), 
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ));
      }),
    );
  }
}
