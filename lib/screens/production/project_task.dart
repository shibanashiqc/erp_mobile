// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart'
    as production_extra_model;
import 'package:erp_mobile/models/production/project_task_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class ProjectTask extends StatefulWidget {
  Object? extra;
  ProjectTask({
    super.key,
    this.extra,
  }); 

  @override
  State<ProjectTask> createState() => _ProjectTaskState();
}

class _ProjectTaskState extends State<ProjectTask> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data> data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  Map<String, dynamic> form = {
    'name' : '', 
    'project_id': '',
    'user_id': '',
    'description': '',
    'status': '',
    'priority': 'low',
    'start_date': '',
    'deadline': '',
    'completion_date': '',
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
        .get('production/project/$projectId/tasks', limit: limit, query: {
      'search': query,
    });
    d.then((value) {
      data = ProjectTaskModel.fromJson(value).data ?? [];
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
        title: const Text('Tasks'),
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
                                  'user_id': data[index].userId,
                                  'name' : data[index].name,  
                                  'project_id': data[index].projectId,
                                  'description': data[index].description,
                                  'status': data[index].status,
                                  'priority': data[index].priority,
                                  'start_date': data[index].startDate,
                                  'deadline': data[index].deadline,
                                  'completion_date': data[index].completionDate,
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(data[index].name ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('STATUS: ${data[index].status ?? ''}'),
                          const SizedBox(height: 5),
                          Text('DESCRIPTION: ${data[index].description ?? ''}'),
                          const SizedBox(height: 5),
                          Text('PRIORITY: ${data[index].priority ?? ''}'),
                          const SizedBox(height: 5),
                          Text('START DATE: ${data[index].startDate ?? ''}'),
                          const SizedBox(height: 5),
                          Text('DEADLINE: ${data[index].deadline ?? ''}'),
                          const SizedBox(height: 5),
                          Text('COMPLETION DATE: ${data[index].completionDate ?? ''}'),
                          
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
  List<production_extra_model.User> users = [];

  @override
  void initState() {
    widget.form['project_id'] = widget.projectId;
    final getExtraProduction = context.read<MainCubit>().getExtraProduction();
    getExtraProduction.then((value) {
      users = value.data!.users ?? []; 
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: const Text('Add Tasks'),
      content: SingleChildScrollView( 
        child: Column(
          children: [
            XInput(
              initialValue: widget.form['name'].toString(),
              label: 'Name',
              hintText: 'Enter Name',
              onChanged: (v) {
                widget.form['name'] = v;
              },
            ),
            
            XInput(
              initialValue: widget.form['description'].toString(),
              label: 'Description',
              hintText: 'Enter  Description',
              onChanged: (v) {
                widget.form['description'] = v;
              },
            ),
            XSelect(
                value: widget.form['user_id'].toString(),
                label: 'User',
                onChanged: (v) {
                  widget.form['user_id'] = v;  
                  setState(() {
                  }); 
                },
                options: users
                    .map((e) => DropDownItem(value: e.id.toString(), label: e.name))
                    .toList()),
                    
            XSelect(
                value: widget.form['status'].toString(),
                label: 'Status',
                onChanged: (v) {
                  widget.form['status'] = v;  
                  setState(() {
                  }); 
                },
                options: [
                  DropDownItem(value: 'pending', label: 'Pending'),
                  DropDownItem(value: 'in_progress', label: 'In Progress'),
                  DropDownItem(value: 'completed', label: 'Completed'),
                ]),
                
            XSelect(
                value: widget.form['priority'].toString(),
                label: 'Priority',
                onChanged: (v) {
                  widget.form['priority'] = v;  
                  setState(() {
                  }); 
                },
                options: [
                  DropDownItem(value: 'low', label: 'Low'),
                  DropDownItem(value: 'medium', label: 'Medium'),
                  DropDownItem(value: 'high', label: 'High'),
                ]),
                
            XInput(
              type: 'date',
              initialValue: widget.form['start_date'].toString(),
              label: 'Start Date',
              hintText: 'Enter Start Date',
              onChanged: (v) {
                widget.form['start_date'] = v;
                setState(() {
                  }); 
              },
            ),
            
            XInput(
              type: 'date',
              initialValue: widget.form['deadline'].toString(),
              label: 'Deadline',
              hintText: 'Enter Deadline',
              onChanged: (v) {
                widget.form['deadline'] = v;
                setState(() {
                  }); 
              },
            ),
            
            XInput(
              type: 'date',
              initialValue: widget.form['completion_date'].toString(),
              label: 'Completion Date',
              hintText: 'Enter Completion Date', 
              onChanged: (v) {
                widget.form['completion_date'] = v;
                setState(() {
                  }); 
              },
            ), 
            
            
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
                  'production/project/update-or-create-task', 
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
