// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/clients_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Clients extends StatefulWidget {
  const Clients({
    super.key,
  });

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
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
    final clients = context.read<MainCubit>().getClients(limit: limit, query: {
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
        title: const Text('Clients'),
        actions: [
          TextButton(
              onPressed: () {
                context.pushNamed('project.client_create_or_edit', extra: {
                  'onSaved': loadData
                }); 
              },
              child: Text('Add Client', )),

          // IconButton(
          //   onPressed: () {
          //     context.pushNamed('project.client_create_or_edit');
          //   },
          //   icon: const Icon(Icons.add),
          // ),
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
                      leading: CircleAvatar(
                        child: data[index].image != null
                            ? Image.network(data[index].image!)
                            : Text(data[index].name![0]),
                      ),
                      title: Text(data[index].name ?? ''),
                      subtitle: Text(data[index].address ?? ''),
                      onTap: () {
                        context.pushNamed('project.client_create_or_edit',
                            extra: {
                              'id': data[index].id,
                              'extra': data[index],
                              'onSaved': loadData
                            });
                      },
                    ),
                  ),
                );
              }),
            ));
      }),
    );
  }
}
