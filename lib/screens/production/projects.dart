// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/projects_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Projects extends StatefulWidget {
  Projects({
    super.key,
  });

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool loading = false;
  List<Errors>? errorBags = [];
  List<Data>? data = [];

  int limit = 10;
  late ScrollController controller;
  bool isLoad = false;

  void _scrollListener() {
    if (controller.position.extentAfter == 0.0) {
      limit = limit + 10;
      loadData();
    }
  }

  loadData({query}) async {
    isLoad = true;
    setState(() {});
    MainCubit cubit = BlocProvider.of<MainCubit>(context);
    data = await cubit.getProjects(query: query).then((value) {
      return value.data;
    });
    isLoad = false;
    setState(() {});
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                XInput(
                  label: 'Search',
                  onChanged: (value) {
                    loadData(query: value);
                  },
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return XCard(
                        child: ListTile(
                          leading: CircleAvatar(
                            // backgroundColor: , 
                            child: Text(data?[index].name?[0] ?? ''),
                          ), 
                          title: Text(data?[index].name ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 5),
                                  const Text('Client : '),
                                  Text(data?[index].clientName ?? ''),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(CupertinoIcons.person_2, size: 16),
                                  const SizedBox(width: 5),
                                  const Text('Team : '),
                                  Text(data?[index].teamName ?? ''),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.money, size: 16),
                                  const SizedBox(width: 5),
                                  const Text('Budget : '),
                                  Text(data?[index].budget ?? ''),
                                ],
                              ),
                              
                              const SizedBox(height: 10),    
                              
                              Container(
                                height: 10,
                                width: screenWidth * 0.7,  
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                ), 
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: double.parse(data?[index].progress ?? '0') / 100, 
                                  child: Container( 
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ), 
                                    child: Center(child: Text('${data?[index].progress} %', style: const TextStyle(color: Colors.white, fontSize: 8))),
                                  ),
                                ),
                              ),  
                              
                              
                               const SizedBox(height: 10),  
                               
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 5),
                                   Text('Start Date : '.toUpperCase(), style: const TextStyle( fontSize: 10)),
                                  Text(data?[index].startDate ?? '', style: const TextStyle( fontSize: 10)),
                                ],
                              ),
                              
                              const SizedBox(height: 10),
                              
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 5),
                                  Text('End Date : '.toUpperCase(), style: const TextStyle( fontSize: 10)), 
                                  Text(data?[index].deadline ?? '', style: const TextStyle( fontSize: 10)),
                                ],
                              ),
                              
                              const SizedBox(height: 10),
                              
                              
                               Row(
                                children: [
                                  const Icon(CupertinoIcons.tag, size: 16),  
                                  const SizedBox(width: 5),
                                  Text('Tasks: '.toUpperCase(), style: const TextStyle( fontSize: 10)), 
                                  Text(data?[index].tasksCount.toString() ?? '', style: const TextStyle( fontSize: 10)),
                                ],
                              ),
                              
                              
                              const SizedBox(height: 20), 
                              
                              
                             
                              
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // context.go('project.chat', params: {'id': data?[index].id.toString() ?? ''});
                                      },
                                      icon: const Icon(Icons.chat),
                                      label: const Text('Chat'),
                                      style: ElevatedButton.styleFrom(
                                        // backgroundColor: Colors.blue, 
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // context.go('project.process', params: {'id': data?[index].id.toString() ?? ''});
                                      },
                                      icon: const Icon(Icons.settings),
                                      label: const Text('Process'),
                                      style: ElevatedButton.styleFrom(
                                        // primary: Colors.green,
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              
                                 Row(
                                  
                                  children: [
                                    
                                    SizedBox(
                                      width: screenWidth * 0.3, 
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          // context.go('project.progress', params: {'id': data?[index].id.toString() ?? ''});
                                        }, 
                                        icon: const Icon(Icons.trending_up, size: 16), 
                                        label: const Text('Progress', style: TextStyle(fontSize: 10)), 
                                        style: ElevatedButton.styleFrom(
                                          // primary: Colors.green,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // context.go('project.add_task', params: {'id': data?[index].id.toString() ?? ''});
                                      },
                                      icon: const Icon(Icons.add),
                                      label: const Text('Add Task'),
                                      style: ElevatedButton.styleFrom(
                                        // primary: Colors.green,
                                      ),
                                    ),
                                    
                                  ],
                                 ),
                                 
                                 
                                  Row(
                                    children: [
                                      
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          // context.go('project.work_update', params: {'id': data?[index].id.toString() ?? ''});
                                        },
                                        icon: const Icon(Icons.update),
                                        label: const Text('Work Update'),
                                        style: ElevatedButton.styleFrom(
                                          // primary: Colors.green,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                 
                              
                              
                              
                            ],
                          ),
                          onTap: () {
                            // context.go('project.detail', params: {'id': data[index].id.toString()});
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: data?.length ?? 0),
                if (isLoad)
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth,
                      color: Colors.white,
                    ),
                  ),
              ],
            ));
      }),
    );
  }
}
