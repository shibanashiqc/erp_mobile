// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/hr/hr_cubit.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool loading = false;
  DateTime focusedDay = DateTime.now();
  @override
  void initState() {
    super.initState();
    final departments = context.read<HrCubit>().getDepartments();
    loading = true;
    departments.then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HrCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       context.push('/department/update_or_create');
        //     },
        //   )
        // ],
      ),
      body: BlocConsumer<HrCubit, HrState>(listener: (context, state) {
        if (state is ErrorHrState) {
          log('Error: ${state.message}');
        }

        if (state is LoadedHrState) {
          log('Loaded');
        }

        if (state is LoadingHrState) {
          log('Loading');
        }
      }, builder: (context, state) {
        return XContainer(
            child: loading == true
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        XInput(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: ColorConstants.secondaryColor,
                          ),
                          hintText: 'Search by name',
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            // return XList(
                            //   onTap: () {},
                            //   title: '',
                            //   subtitle: '',
                            //   status: 1,
                            // );
                          },
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XInput(
                        onChanged: (value) {},
                        suffixIcon: const Icon(
                          Icons.search,
                          color: ColorConstants.secondaryColor,
                        ),
                        hintText: 'Search by name',
                      ),
                      // TableCalendar(
                      //   firstDay: DateTime.utc(2010, 10, 16),
                      //   lastDay: DateTime.utc(2030, 3, 14),
                      //   focusedDay: focusedDay,
                      //   onDaySelected: (selectedDay, focusedDay) {
                      //     focusedDay = selectedDay;
                      //     setState(() {
                      //     });  
                      //   },
                      // )
                      XCard( 
                        child: Column(
                          children: [
                            Items(), 
                            
                          ],
                        ),
                      ),
                      
                      
                    ],
                  ));
      }),
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('NAME'),
              Text('ANDREW'),
            ],
          ),
          
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DATE'),
              Text('12/12/2021'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('IN'),
              Text('09:00 AM'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('OUT'),
              Text('06:00 PM'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BREAK STARTED'),
              Text('01:00 PM'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('BREAK ENDED'),
              Text('02:00 PM'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TOTAL WORKING HOURS'),
              Text('8 HOURS'),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('OVERTIME'),
              Text('2 HOURS'),
            ],
          ),
          
          
        ],
      ),
    );
  }
}
