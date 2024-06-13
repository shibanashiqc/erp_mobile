// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/fields.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_form.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:erp_mobile/models/production/team_users_model.dart' as team;

class TeamCreateOrEdit extends StatefulWidget {
  dynamic data = {};
  String editId = '';
  Function()? onSaved;

  TeamCreateOrEdit({
    super.key,
    this.data,
    this.editId = '',
    this.onSaved,
  });

  @override
  State<TeamCreateOrEdit> createState() => _TeamCreateOrEditState();
}

class _TeamCreateOrEditState extends State<TeamCreateOrEdit> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<User> users = [];
  List<team.Data> data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadData();
    }
  }

  Map<String, dynamic> formValues = {
    'edit_id': '',
    'name': '',
  };

  List<Fields> fileds = [];

  clear() {
    formValues.forEach((key, value) {
      formValues[key] = '';
    });
    setState(() {});
  }

  loadData({query}) {
    final getTeamUsers = context.read<MainCubit>().getTeamMembers(
          widget.editId,
          limit: limit,
        );
    getTeamUsers.then((value) {
      data = value.data ?? [];
      setState(() {});
    });
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    final getExtraProduction = context.read<MainCubit>().getExtraProduction();
    getExtraProduction.then((value) {
      final data = value.data as Data;
      users = data.users ?? [];
      setState(() {});
    });

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.editId.isNotEmpty) {
        await loadData();
        Map<String, dynamic> mapData = {};
        mapData = json.decode(json.encode(widget.data));
        formValues = mapData;
        formValues['edit_id'] = widget.editId;
      }

      fileds.addAll([
        Fields(
          placeholder: 'Enter Team Name',
          model: 'name',
          label: 'Name',
          type: '',
          xClass: 'XInput',
          value: '',
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
                .save(formValues, 'production/update-or-create-team')
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
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XForm(
                  errorBags: errorBags,
                  fields: fileds,
                  formValues: formValues,
                ),
                const SizedBox(height: 10),
                if (data.isNotEmpty) ...[
                  XCard(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Team Members',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ModalItems( 
                                        teamId: widget.editId,
                                        users: users, 
                                        onSaved: () {
                                        loadData();
                                      });
                                    }, 
                                  );
                                  // context.pushNamed('production.team_users');
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        for (var index = 0; index < data.length; index++) ...[
                          XCard(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(data[index].name?[0] ?? ''),
                              ),
                              title: Text(data[index].name ?? ''),
                              subtitle: Text(data[index].role ?? ''),
                              onTap: () {
                                // context.pushNamed('project.client_create_or_edit',
                                //     extra: {
                                //       'id': data[index].id,
                                //       'extra': data[index],
                                //       'onSaved': loadData
                                //     });
                              },
                            ),
                          )
                        ],
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
                const SizedBox(height: 10),
              ],
            ));
      }),
    );
  }
}

class ModalItems extends StatefulWidget {
  List<User> users = [];
  Function()? onSaved;
  String teamId = '';

  ModalItems({
    super.key,
    this.users = const [],
    this.onSaved,
    this.teamId = '',  
  });

  @override
  State<ModalItems> createState() => _ModalItemsState();
}

class _ModalItemsState extends State<ModalItems> {
  Map<String, dynamic> formValues = {
    'role': '',
    'user_id': '',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () async {
            formValues['team_id'] = widget.teamId; 
            await context.read<MainCubit>().save(formValues, 'production/team/update-or-create-team-member').then((value) => {
              if (value.errors != null)
                {log('Error: ${value.errors}')}
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data Saved Successfully'),
                    ),
                  ),
                  if (widget.onSaved != null) {widget.onSaved!()},
                  setState(() {}),
                }
            });
            
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
      title: const Text('Add Team Members'),
      content: Column(
        children: [
          XInput(
            initialValue: formValues['role'],
            hintText: 'Enter Role',
            label: 'Role',
            onChanged: (value) {
              formValues['role'] = value;
            },
          ),
          XSelect(
            value: formValues['user_id'],
            label: 'Select User',
            options: widget.users
                .map((e) => DropDownItem(
                      value: e.id.toString(),
                      label: e.name,
                    ))
                .toList(),
            onChanged: (value) {
              formValues['user_id'] = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
