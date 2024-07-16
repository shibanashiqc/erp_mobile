// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart'
    as production_extra_model;
import 'package:erp_mobile/models/production/qa_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/alert.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/production/extra/qa_report.dart';
import 'package:erp_mobile/screens/production/extra/qa_request.dart';
import 'package:erp_mobile/screens/production/extra/qa_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Qa extends StatefulWidget {
  Qa({
    super.key,
  });

  @override
  State<Qa> createState() => _QaState();
}

class _QaState extends State<Qa> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data> data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  // 'project_id' => 'required',
  //           'team_id' => 'required',
  //           'name' => 'required',
  //           'description' => 'required',
  //           'status' => 'required',
  //           'priority' => 'required',
  //           'start_date' => 'required',
  //           'end_date' => 'required',

  Map<String, dynamic> form = {
    'project_id': '',
    'team_id': '',
    'name': '',
    'description': '',
    'status': '',
    'priority': '',
    'start_date': '',
    'end_date': '',
  };

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadData();
    }
  }

  String projectId = '';

  loadData({query}) async {
    isLoad = true;
    setState(() {});
    final d =
        context.read<MainCubit>().get('production/qa', limit: limit, query: {
      'search': query,
    });
    d.then((value) {
      data = QaModel.fromJson(value).data ?? [];
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
        title: const Text('Qa '),
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
                      leading: const Icon(CupertinoIcons.check_mark_circled),
                      trailing: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(100, 100, 0, 0),
                                items: [
                                  PopupMenuItem(
                                    child: ListTile(
                                      title: const Text('Edit'),
                                      onTap: () {
                                        form = {
                                          'edit_id': data[index].id ?? '',
                                          'project_id':
                                              data[index].projectId ?? '',
                                          'team_id': data[index].teamId ?? '',
                                          'name': data[index].name ?? '',
                                          'description':
                                              data[index].description ?? '',
                                          'status': data[index].status ?? '',
                                          'priority':
                                              data[index].priority ?? '',
                                          'start_date':
                                              data[index].startDate ?? '',
                                          'end_date': data[index].endDate ?? '',
                                        };
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
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: ListTile(
                                      title: const Text('Report Dispute'),
                                      onTap: () {
                                        Navigator.pop(context); 
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReportDisput(
                                              qaId: data[index].id.toString(),
                                            ),
                                          ),
                                        );
                                        
                                      },
                                    ),
                                  ),
                                  
                                  PopupMenuItem(
                                    child: ListTile(
                                      title: const Text('Raise a Request'),
                                      onTap: () {
                                        Navigator.pop(context); 
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(  
                                            builder: (context) => QaRequest(
                                              qaId: data[index].id.toString(),
                                            ),
                                          ),
                                        );
                                        
                                      },
                                    ),
                                  ),
                                  
                                  
                                  PopupMenuItem(
                                    child: ListTile(
                                      title: const Text('Tasks'),
                                      onTap: () { 
                                        Navigator.pop(context); 
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QaTask(
                                              qaId: data[index].id.toString(),
                                            ),
                                          ),
                                        );
                                        
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            icon: const Icon(Icons.menu),
                          ),
                        ],
                      ),
                      title: Row(
                        children: [
                          Text(data[index].name ?? ''),
                          //Text(' - ${data[index].projectName ?? ''}'),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Project: ${data[index].projectName ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Team: ${data[index].teamName ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Description: ${data[index].description ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Status: ${data[index].status ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Priority: ${data[index].priority ?? ''}'),
                          const SizedBox(height: 5),
                          Text('Start Date: ${data[index].startDate ?? ''}'),
                          const SizedBox(height: 5),
                          Text('End Date: ${data[index].endDate ?? ''}'),
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
  List<production_extra_model.Teams> teams = [];
  List<production_extra_model.Projects> projects = [];

  @override
  void initState() {
    final getExtraProduction = context.read<MainCubit>().getExtraProduction();
    getExtraProduction.then((value) {
      teams = value.data!.teams ?? [];
      projects = value.data!.projects ?? [];
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: const Text('Add Qa'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              XInput(
                initialValue: widget.form['name'].toString(),
                label: ' Name',
                hintText: 'Enter  Name',
                onChanged: (v) {
                  widget.form['name'] = v;
                },
              ),
              XSelect(
                  value: widget.form['team_id'].toString(),
                  label: 'Tean ',
                  onChanged: (v) {
                    widget.form['team_id'] = v;
                    setState(() {});
                  },
                  options: teams
                      .map((e) =>
                          DropDownItem(value: e.id.toString(), label: e.name))
                      .toList()),
              XSelect(
                  value: widget.form['project_id'].toString(),
                  label: 'Project ',
                  onChanged: (v) {
                    widget.form['project_id'] = v;
                    setState(() {});
                  },
                  options: projects
                      .map((e) =>
                          DropDownItem(value: e.id.toString(), label: e.name))
                      .toList()),
              XInput(
                initialValue: widget.form['description'].toString(),
                label: ' Description',
                hintText: 'Enter  Description',
                onChanged: (v) {
                  widget.form['description'] = v;
                },
              ),
              XSelect(
                  value: widget.form['status'].toString(),
                  label: 'Status ',
                  onChanged: (v) {
                    widget.form['status'] = v;
                    setState(() {});
                  },
                  options: [
                    DropDownItem(value: 'active', label: 'Active'),
                    DropDownItem(value: 'inactive', label: 'Inactive'),
                  ]),
              XSelect(
                  value: widget.form['priority'].toString(),
                  label: 'Priority ',
                  onChanged: (v) {
                    widget.form['priority'] = v;
                    setState(() {});
                  },
                  options: [
                    DropDownItem(value: 'low', label: 'Low'),
                    DropDownItem(value: 'medium', label: 'Medium'),
                    DropDownItem(value: 'high', label: 'High'),
                  ]),
              XInput(
                type: 'date',
                initialValue: widget.form['start_date'].toString(),
                label: ' Start Date',
                hintText: 'Enter  Start Date',
                onChanged: (v) {
                  widget.form['start_date'] = v;
                  setState(() {});
                },
              ),
              XInput(
                type: 'date',
                initialValue: widget.form['end_date'].toString(),
                label: ' End Date',
                hintText: 'Enter  End Date',
                onChanged: (v) {
                  widget.form['end_date'] = v;
                  setState(() {});
                },
              ),
            ],
          ),
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
                  'production/update-or-create-qa',
                )
                .then((value) => {
                      alert(context, value.message ?? ''),
                      if (value.errors != null)
                        {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: Text(
                                    value.errors?.first.message.toString() ??
                                        ''),
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
                          Navigator.pop(context),
                          Navigator.pop(context)
                        }
                    });

            // Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
