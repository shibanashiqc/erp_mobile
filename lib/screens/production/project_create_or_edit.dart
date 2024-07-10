// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_file_image.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ProjectCreateOrEdit extends StatefulWidget {
  ProjectCreateOrEdit({
    super.key,
  });

  @override
  State<ProjectCreateOrEdit> createState() => _ProjectCreateOrEditState();
}

class _ProjectCreateOrEditState extends State<ProjectCreateOrEdit> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Clients> clients = [];
  List<Teams> teams = [];

  Map<String, dynamic> formValues = {
    'team_id': '',
    'client_id': '',
    'name': '',
    'tags': '',
    'description': '',
    'start_date': DateTime.now().toString().substring(0, 10), 
    'deadline': DateTime.now().toString().substring(0, 10),
    'budget': '0.00',
    'documents': [],
  };

  
  loadData()
  {
     final getExtraProduction = context.read<MainCubit>().getExtraProduction();
    getExtraProduction.then((value) {
      final data = value.data as Data;
      clients = data.clients ?? [];
      teams = data.teams ?? [];
      setState(() {});
    });
  }
  
  @override
  void initState() {
    loadData();
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
      appBar: AppBar(
        title: const Text('Project Create Or Edit'),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: ColorConstants.primaryColor,
        child: TextButton(
          onPressed: () async {
            
            Map<String, dynamic> data = formValues;
            data['documents'] = data['documents'].map((e) => e as MultipartFile).toList(); 
            
            await context
                .read<MainCubit>()
                .createOrUpdateProject(data, context) 
                .then((value) => {
                      if (value.errors != null)
                        {errorBags = value.errors, setState(() {})}
                      else
                        {
                          formValues = {
                            'team_id': '',
                            'client_id': '',
                            'name': '',
                            'tags': '',
                            'description': '',
                            'start_date': DateTime.now().toString(),
                            'deadline': DateTime.now().toString(),
                            'budget': '0.00',
                            'documents': [],
                          }, 
                         
                          setState(() {}), 
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
            //  formValues

            Row(
              children: [
                XSelect(
                  errorBags: errorBags,
                  model: 'team_id',
                  label: 'Team',
                  value: formValues['team_id'],
                  width: 0.47,
                  height: 0.04,
                  placeholder: 'Select Team',
                  options: teams.map((e) {
                    return DropDownItem(value: e.id.toString(), label: e.name);
                  }).toList(),
                  onChanged: (value) {
                    context
                        .read<MainCubit>()
                        .changeFormValues('team_id', value);
                  },
                ),
                const SizedBox(width: 5),
                Column(
                  children: [
                    InkWell(
                      onTap: () { 
                        context.pushNamed('project.client_create_or_edit', extra: {'onSaved' : loadData});  
                      },  
                      child: const Text('Add New Client', style: TextStyle(color: ColorConstants.primaryColor, fontSize: 8),)), 
                    
                    XSelect(
                      errorBags: errorBags,
                      model: 'client_id',
                      label: 'Client',
                      value: formValues['client_id'],
                      width: 0.47,
                      height: 0.04,
                      placeholder: 'Select Client',
                      options: clients.map((e) {
                        return DropDownItem(value: e.id.toString(), label: e.name);
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<MainCubit>()
                            .changeFormValues('client_id', value);
                      },
                    ),
                    
                    
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            XInput(
              errorBags: errorBags,
              model: 'name',
              height: 0.1,
              label: 'Project Name',
              initialValue: formValues['name'],
              onChanged: (value) {
                context.read<MainCubit>().changeFormValues('name', value);
              },
            ),

            const SizedBox(height: 10),

            XInput(
              errorBags: errorBags,
              model: 'tags',
              height: 0.1,
              label: 'Tags',
              initialValue: formValues['tags'],
              onChanged: (value) {
                context.read<MainCubit>().changeFormValues('tags', value);
              },
            ),

            const SizedBox(height: 5),

            XInput(
              height: 0.1, 
              errorBags: errorBags,
              model: 'description', 
              label: 'Project Overview',
              initialValue: formValues['description'],
              onChanged: (value) {
                context
                    .read<MainCubit>()
                    .changeFormValues('description', value);
              },
            ),

            XInput(
              errorBags: errorBags,
              model: 'start_date',
              label: 'Start Date',
              type: 'date',
              initialValue: formValues['start_date'],
              onChanged: (value) {
                context.read<MainCubit>().changeFormValues('start_date', value);
              },
            ),

            XInput(
              errorBags: errorBags,
              model: 'deadline',
              label: 'Deadline',
              type: 'date',
              initialValue: formValues['deadline'],
              onChanged: (value) {
                context.read<MainCubit>().changeFormValues('deadline', value);
              },
            ),

            XInput(
              errorBags: errorBags,
              model: 'budget',
              label: 'Budget',
              initialValue: formValues['budget'],
              onChanged: (value) {
                context.read<MainCubit>().changeFormValues('budget', value);
              },
            ),
 
            XFileImage(
                allowMultiple: true, 
                onChanged: (file) async {
                  List files = []; 
                  files.add(await MultipartFile.fromFile(file.path));
                  formValues['documents'] = files;  
                },
                label: 'Documents'),

            const SizedBox(height: 10),
          ],
        ));
      }),
    );
  }
}
