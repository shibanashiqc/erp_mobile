// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/teams_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Teams extends StatefulWidget {
  const Teams({
    super.key,
  });

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data> data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadData();
    }
  }

  loadData({query}) {
    isLoad = true;
    setState(() {});
    final clients = context.read<MainCubit>().getTeams(limit: limit, query: {
      'search': query,
    });
    clients.then((value) {
      data = value.data ?? [];
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
        title: const Text('Teams'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed('project.team_create_or_edit');
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
              children: [
                  XCard(
                    child: Table(
                      // border: 
                      children: [
                        const TableRow(children: [
                          TableCell(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('ID'),
                          )),
                          TableCell(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Name'),
                          )),
                          TableCell(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Action'),
                          )),
                        ]),
                        ...data.map((e) {
                          return TableRow(children: [
                            TableCell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.id.toString()),
                            )),
                            TableCell(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.name ?? ''),
                            )),
                            TableCell(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          'project.team_create_or_edit',
                                          extra: {
                                            'id': e.id,
                                            'extra': e, 
                                            'onSaved': loadData
                                          });  
                                    },
                                    icon: const Icon(CupertinoIcons.pencil),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     context
                                  //         .read<MainCubit>()
                                  //         .deleteTeams(id: e.id);
                                  //   },
                                  //   icon: const Icon(Icons.delete),
                                  // ),
                                ],
                              ),
                            ),
                          ]);
                        }).toList(),
                      ],
                    ),
                  ),
              ]
            ));
      }),
    );
  }
}
