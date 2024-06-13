// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/models/sales/sales_extra_model.dart' as sales;
import 'package:erp_mobile/screens/common/fields.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_form.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/dynamic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ClientCreateOrEdit extends StatefulWidget {
  dynamic data = {}; 
  String editId = '';
  Function()? onSaved;

  ClientCreateOrEdit({
    super.key,
    this.data,
    this.editId = '', 
    this.onSaved,
  });

  @override
  State<ClientCreateOrEdit> createState() => _ClientCreateOrEditState();
}

class _ClientCreateOrEditState extends State<ClientCreateOrEdit> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Clients> clients = [];
  List<Teams> teams = [];
  List<sales.Country> countries = [];

  Map<String, dynamic> formValues = {
    'edit_id': '',
    'name': '',
    'email': '',
    'address': '',
    'phone': '',
    'image': '',
    'country_id': '',
  };

  List<Fields> fileds = [];

  clear() {
    formValues.forEach((key, value) {
      formValues[key] = '';
    });
    setState(() {});
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      
      final getExtraSales = await context.read<MainCubit>().getExtraSales();
      final data = getExtraSales.data as sales.Data;
      countries = data.country ?? []; 
      
      if (widget.editId.isNotEmpty) {
         Map<String, dynamic> mapData = {};
         mapData =  json.decode(json.encode(widget.data));
         formValues = mapData;  
         formValues['edit_id'] = widget.editId;
      }

      fileds.addAll([
        Fields(
          placeholder: 'Enter Client Name',
          model: 'name',
          label: 'Name',
          type: '',
          xClass: 'XInput',
          value: '',
        ),
        Fields(
          placeholder: 'Enter Client Email',
          model: 'email',
          label: 'Email',
          type: '',
          xClass: 'XInput',
          value: '',
        ),
        Fields(
          placeholder: 'Enter Client Address',
          model: 'address',
          label: 'Address',
          type: '',
          xClass: 'XInput',
          value: '',
        ),
        Fields(
          placeholder: 'Enter Client Phone',
          model: 'phone',
          label: 'Phone',
          type: '',
          xClass: 'XInput',
          value: '',
        ),
        if (countries.isNotEmpty)
          Fields(
            placeholder: 'Select Country',
            model: 'country_id',
            label: 'Country',
            type: '',
            xClass: 'XSelect',
            value: '',
            options: countries
                .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                .toList(),
          ),
      ]);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients Create Or Edit'),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ColorConstants.primaryColor,
        child: TextButton(
          onPressed: () async {
            await context
                .read<MainCubit>()
                .save(formValues, 'production/update-or-create-client')
                .then((value) => {
                      if (value.errors != null)
                        {errorBags = value.errors, setState(() {})}
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data Saved Successfully'),
                            ),
                          ),
                          if (widget.onSaved != null) {widget.onSaved!()},  
                          setState(() {}),
                          if (formValues['edit_id'] == null)
                            {
                              context.pushReplacementNamed(
                                  'project.client_create_or_edit'),
                            },
                        }
                    });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                color: Colors.white,
              ),
              Text(
                'SAVE',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
        if (state is ErrorMainState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedMainState) {
          loading = false;
        }

        if (state is LoadingMainState) {
          loading = true;
        }

        if (state is ValidationErrorState) {
          log('Validation Error');
          errorBags = state.errors;
        }

        if (state is ChangeFormValuesState) {
          formValues[state.type] = state.value;
        }
      }, builder: (context, state) {
        return XContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XForm(
              errorBags: errorBags,
              fields: fileds,
              formValues: formValues,
            ),
            XFileImage(
              label: 'Image',
              onChanged: (value) async {
                formValues['image'] = await MultipartFile.fromFile(value.path);
              },
            ),
            const SizedBox(height: 10),
          ],
        ));
      }),
    );
  }
}

