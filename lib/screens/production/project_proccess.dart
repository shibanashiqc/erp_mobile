// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart'
    as production_extra_model;
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../models/production/project_proccess_model.dart';

class ProjectProccess extends StatefulWidget {
  Object? extra;
  ProjectProccess({
    super.key,
    this.extra,
  });

  @override
  State<ProjectProccess> createState() => _ProjectProccessState();
}

class _ProjectProccessState extends State<ProjectProccess> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data> data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  Map<String, dynamic> form = {
    'project_id': '',
    'process_name': '',
    'process_description': '',
    'staff_id': '',
  };

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadData();
    }
  }

  String projectId = '';

  loadData({query}) {
    var map = widget.extra as Map<String, dynamic>;
    projectId = map['id'].toString();
    isLoad = true;

    setState(() {});
    final d = context
        .read<MainCubit>()
        .get('production/project/$projectId/proccess', limit: limit, query: {
      'search': query,
    });
    d.then((value) {
      data = ProjectProccessModel.fromJson(value).data ?? [];
      isLoad = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    loadData();
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
        title: const Text('Project Proccess'),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return Form( 
                    onSave: loadData,   
                    projectId: projectId,
                    form: form,
                  ); 
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
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

        if (state is ChangeFormValuesState) {}
      }, builder: (context, state) {
        return XContainer(
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(data.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: XCard(
                    child: ListTile(
                      leading: const Icon(Icons.production_quantity_limits), 
                      trailing: IconButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                onSave: loadData,
                                projectId: projectId,
                                form: {
                                  'edit_id': data[index].id, 
                                  'project_id': data[index].projectId,
                                  'process_name': data[index].processName,
                                  'process_description': data[index].processDescription,
                                  'staff_id': data[index].staffId,
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(data[index].processName ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Staff: ${data[index].staffName ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Created By: ${data[index].createdByName ?? ''}'),
                          const SizedBox(height: 5),
                          Text(
                              'DESCRIPTION: ${data[index].processDescription ?? ''}'),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ));
      }),
    );
  }
}

class Form extends StatefulWidget {
  Map<String, dynamic> form = {};
  String projectId = '';
  Function? onSave;
  Form({
    required this.projectId,
    required this.form,
    super.key,
    this.onSave,
  });

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  List<production_extra_model.Staffs> staffs = [];

  @override
  void initState() {
    widget.form['project_id'] = widget.projectId;
    final getExtraProduction = context.read<MainCubit>().getExtraProduction();
    getExtraProduction.then((value) {
      staffs = value.data!.staffs ?? [];
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: const Text('Add Project Proccess'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            XInput(
              initialValue: widget.form['process_name'].toString(),
              label: 'Process Name',
              hintText: 'Enter Process Name',
              onChanged: (v) {
                widget.form['process_name'] = v;
              },
            ),
            
            XInput(
              initialValue: widget.form['process_description'].toString(),
              label: 'Process Description',
              hintText: 'Enter Process Description',
              onChanged: (v) {
                widget.form['process_description'] = v;
              },
            ),
            XSelect(
                value: widget.form['staff_id'].toString(),
                label: 'Staff',
                onChanged: (v) {
                  widget.form['staff_id'] = v;  
                  setState(() {
                  });
                },
                options: staffs
                    .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                    .toList()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context
                .read<MainCubit>()
                .save(
                  widget.form,
                  'production/project/update-or-create-process',
                )
                .then((value) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(value.message.toString()),
                        ),
                      ),
                      if (value.errors != null)
                        {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: Text(
                                    value.errors?.first.message.toString() ?? ''),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          )
                        }
                      else
                        {
                          widget.onSave!(), 
                          Navigator.pop(context)}
                    });

            // Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
