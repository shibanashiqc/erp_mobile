// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:calendar_view/calendar_view.dart';
import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/appointments/appointment_extra_model.dart'
    as extra;
import 'package:erp_mobile/models/appointments/appointments_model.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EventController controller = EventController();

  Color getColor(index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.orange;
      case 6:
        return Colors.pink;
      case 7:
        return Colors.indigo;
      case 8:
        return Colors.teal;
      case 9:
        return Colors.brown;
      case 10:
        return Colors.grey;
      case 11:
        return Colors.cyan;
      case 12:
        return Colors.lime;
      case 13:
        return Colors.amber;
      case 14:
        return Colors.deepOrange;
      case 15:
        return Colors.lightGreen;
      case 16:
        return Colors.deepPurple;
      case 17:
        return Colors.lightBlue;
      case 18:
        return Colors.indigoAccent;
      case 19:
        return Colors.tealAccent;
      case 20:
        return Colors.purpleAccent;
      case 21:
        return Colors.pinkAccent;
      case 22:
        return Colors.amberAccent;
      case 23:
        return Colors.deepOrangeAccent;
      case 24:
        return Colors.lightGreenAccent;
      case 25:
        return Colors.deepPurpleAccent;
      case 26:
        return Colors.lightBlueAccent;
      case 27:
        return Colors.indigoAccent;
      case 28:
        return Colors.tealAccent;
      case 29:
        return Colors.purpleAccent;
      case 30:
        return Colors.pinkAccent;
      case 31:
        return Colors.amberAccent;
      case 32:
        return Colors.deepOrangeAccent;
      case 33:
        return Colors.lightGreenAccent;
      case 34:
        return Colors.deepPurpleAccent;
      case 35:
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }

  List<Data> event = [];
  List<extra.Doctors> doctors = [];
  List<extra.Branches> branches = [];
  List<extra.AppointmentTypes> appointmentTypes = [];
  List<extra.Customers> customers = [];

  refresh() async {
    final cubit = BlocProvider.of<MainCubit>(context);

    await cubit.getAppointmentExtra().then((value) {
      if (value.data != null) {
        doctors = value.data?.doctors ?? [];
        branches = value.data?.branches ?? [];
        appointmentTypes = value.data?.appointmentTypes ?? [];
        customers = value.data?.customers ?? []; 
      }
    });

    await cubit.getAppointments().then((value) {
      if (value.data != null) {
        event = value.data ?? [];
        value.data?.forEach((element) {
          final appointment = CalendarEventData(
            date: DateTime.parse(element.start ?? ''),
            event: element.start.toString(),
            title: element.title ?? '',
          );
          controller.add(appointment);
        });
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    //controller.addAll(event);
    super.initState();
    refresh();
    // loading = true;
    // departments.then((value) {
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     GoRouter.of(context).go('/add-appointment');
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          refresh();
        },
        child: BlocConsumer<MainCubit, MainState>(listener: (context, state) {
          if (state is ErrorMainState) {
            log('Error: ${state.message}');
          }

          if (state is LoadedMainState) {
            if (state.data != null) {
              setState(() {});
            }
          }

          if (state is LoadingMainState) {
            log('Loading');
          }

          if (state is ChangeFormValuesState) {
            log('Form Values: ${state.type} ${state.value}');
            // setValue = state;
          }

          if (state is RefreshMainState) {}
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.purpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return CreateAppointment(
                                  customers: customers,
                                  doctors: doctors,
                                  branches: branches,
                                  appointmentTypes: appointmentTypes,
                                  refresh: refresh,
                                );
                              },
                            );
                          },
                          child: const Text('Create Appointment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: XCard(
                    child: MonthView(
                      headerStyle: const HeaderStyle(
                        headerTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      key: _formKey,
                      controller: controller,
                      // to provide custom UI for month cells.
                      cellBuilder: (date, events, isToday, isInMonth) {
                        // Return your widget to display as month cell.
                        return Column(
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isToday ? Colors.black : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Display events on the cell.
                            // if (events.isNotEmpty)
                            // Expanded(
                            //   child: ListView.builder(
                            //     itemCount: events.length,
                            //     itemBuilder: (context, index) {
                            //       return Container(
                            //           decoration: BoxDecoration(
                            //             color: Colors.red.withOpacity(0.2),
                            //             borderRadius: BorderRadius.circular(5),
                            //           ),
                            //           child: Text(events[index].title));
                            //     },
                            //   ),
                            // ),
                          ],
                        );
                      },

                      cellAspectRatio: 0.8,
                      borderSize: 0.5,
                      onPageChange: (date, pageIndex) =>
                          print("$date, $pageIndex"),
                      onCellTap: (events, date) {
                        if (events.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No appointment on this date'),
                            ),
                          );
                          return;
                        }
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height *
                                  0.8, // Adjust height as needed
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: EventView(
                                    refresh: refresh,  
                                    events: event
                                        .where((element) =>
                                            element.start.toString() ==
                                            events.first.event)
                                        .toList(),
                                    getColor: getColor,
                                    date: date.toString()),
                              ),
                            );
                          },
                        );

                        // showBottomSheet(
                        //   context: context,
                        //   builder: (context) {
                        //     return Container(
                        //       height: screenHeight * 0.4,
                        //       color: Colors.white,
                        //       child: Column(
                        //         children: [
                        //           const SizedBox(height: 10),
                        //           const Text('CUSTOMER IMRAN',
                        //               style: TextStyle(
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.bold)),
                        //           const SizedBox(height: 10),
                        //           const Row(
                        //             children: [
                        //               SizedBox(width: 10),
                        //               Text('14 Years',
                        //                   style: TextStyle(
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.grey)),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 10),
                        //           const Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.phone,
                        //               ),
                        //               SizedBox(width: 10),
                        //               Text('071 123 4567',
                        //                   style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold,
                        //                   )),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 10),
                        //           const Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.calendar_today,
                        //               ),
                        //               SizedBox(width: 10),
                        //               Text('14:00 - 15:00',
                        //                   style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.bold,
                        //                   )),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 10),
                        //           const Divider(),
                        //           const Row(
                        //             children: [
                        //               SizedBox(width: 10),
                        //               Text('Docter:',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold)),
                        //               SizedBox(width: 10),
                        //               Text('Dr. John Doe',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.grey)),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 10),
                        //           const Row(
                        //             children: [
                        //               SizedBox(width: 10),
                        //               Text('Branch:',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold)),
                        //               SizedBox(width: 10),
                        //               Text('Tamilnadu',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.grey)),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 10),
                        //           const Row(
                        //             children: [
                        //               SizedBox(width: 10),
                        //               Text('Service:',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold)),
                        //               SizedBox(width: 10),
                        //               Text('Root canal',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.grey)),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 10),
                        //           const Row(
                        //             children: [
                        //               SizedBox(width: 10),
                        //               Text('Duration:',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold)),
                        //               SizedBox(width: 10),
                        //               Text('0:00',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.grey)),
                        //             ],
                        //           ),
                        //           const SizedBox(width: 10),
                        //           const Divider(),
                        //           Row(children: [
                        //             const SizedBox(width: 10),
                        //             ElevatedButton(
                        //                 onPressed: () {},
                        //                 child: const Text('Collect Payment'))
                        //           ])
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                      startDay: WeekDays
                          .sunday, // To change the first day of the week.
                      // This callback will only work if cellBuilder is null.
                      onEventTap: (event, date) => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(event.title),
                              // content: Text(event.event),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          },
                        ),
                      },
                      onDateLongPress: (date) => {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Long Press"),
                              content: Text(date.toString()),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          },
                        ),
                      },
                      //headerBuilder: MonthHeader.hidden // To hide month header
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CreateAppointment extends StatefulWidget {
  CreateAppointment({
    super.key,
    required this.doctors,
    required this.branches,
    required this.appointmentTypes,
    required this.refresh,
    required this.customers,
  });

  List<extra.Doctors> doctors = [];
  List<extra.Branches> branches = [];
  List<extra.AppointmentTypes> appointmentTypes = [];
  List<extra.Customers> customers = [];
  Function refresh;

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  Map<String, dynamic> form = {
    'phone': '',
    'patient_name': '',
    'doctor_id': '',
    'branch_id': '',
    'appointment_type_id': '',
    'appointment_date': '',
    'appointment_time': '',
  };

  List<Errors> errors = [];

  set setValue(ChangeFormValuesState state) {
    setState(() {
      form.update(state.type, (value) => state.value,
          ifAbsent: () => state.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Create Appointment',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              XSelect(
                reset: (){
                  setState(() {
                    form['phone'] = '';
                    form['patient_name'] = '';
                  }); 
                },
                value: form['phone'], 
                errorBags: errors,
                color: Colors.grey[200]!, 
                options: widget.customers.map((e) { 
                  return DropDownItem(value: e.phone.toString(), label: e.phone);
                }).toList(), 
                label: 'Phone Number',
                model: 'phone',
                onChanged: (value) {
                  setValue = ChangeFormValuesState(type: 'phone', value: value);
                  form['patient_name'] = widget.customers.firstWhere((element) => element.phone == value).name; 
                  setState(() {
                  }); 
                },
              ),
              XInput(  
                type: form['phone'] != '' ? 'none' : '',
                initialValue: form['patient_name'],      
                errorBags: errors,
                color: Colors.grey[200]!,
                hintText: 'Patient Name',
                label: 'Patient Name',
                model: 'patient_name',
                onChanged: (value) {
                  setValue =
                      ChangeFormValuesState(type: 'patient_name', value: value);
                },
              ),
              XSelect(
                  model: 'doctor_id',
                  errorBags: errors,
                  value: form['doctor_id'],
                  color: Colors.grey[200]!,
                  label: 'Select Doctor',
                  options: widget.doctors.map((e) {
                    return DropDownItem(value: e.id.toString(), label: e.name);
                  }).toList(),
                  onChanged: (value) {
                    setValue =
                        ChangeFormValuesState(type: 'doctor_id', value: value);
                  }),
              XSelect(
                  model: 'branch_id',
                  errorBags: errors,
                  value: form['branch_id'],
                  color: Colors.grey[200]!,
                  label: 'Select Branch',
                  options: widget.branches.map((e) {
                    return DropDownItem(value: e.id.toString(), label: e.name);
                  }).toList(),
                  onChanged: (value) {
                    setValue =
                        ChangeFormValuesState(type: 'branch_id', value: value);
                  }),
              XSelect(
                  model: 'appointment_type_id',
                  errorBags: errors,
                  value: form['appointment_type_id'],
                  color: Colors.grey[200]!,
                  label: 'Select Appointment Type',
                  options: widget.appointmentTypes.map((e) {
                    return DropDownItem(value: e.id.toString(), label: e.name);
                  }).toList(),
                  onChanged: (value) {
                    setValue = ChangeFormValuesState(
                        type: 'appointment_type_id', value: value);
                  }),
              XInput(
                initialValue: form['appointment_date'],
                errorBags: errors,
                color: Colors.grey[200]!,
                hintText: 'Appointment Date',
                label: 'Appointment Date',
                type: 'date',
                onChanged: (value) {
                  setValue = ChangeFormValuesState(
                      type: 'appointment_date', value: value);
                },
              ),
              XInput(
                initialValue: form['appointment_time'],
                errorBags: errors,
                color: Colors.grey[200]!,
                hintText: 'Appointment Time',
                label: 'Appointment Time',
                type: 'time',
                onChanged: (value) {
                  setValue = ChangeFormValuesState(
                      type: 'appointment_time', value: value);
                },
              ),
              XButton(
                label: 'Create Appointment',
                color: Colors.purple,
                onPressed: () async {
                  await context
                      .read<MainCubit>()
                      .createAppointment(form)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value.message ?? '')));

                    if (value.status == 'success') {
                      widget.refresh();
                      context.pop();
                      return;
                    }

                    errors = value.errors ?? [];
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventView extends StatelessWidget {
  List<Data> events;
  String date;
  Function getColor;
  Function refresh;
  EventView({
    super.key,
    required this.events,
    required this.date,
    required this.getColor,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(date,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 10),
        SizedBox(
          height: 500,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 100,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Text(events[index].title.toString()),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(events[index].age.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(events[index].phone.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(events[index].start.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Divider(),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Text('Docter:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  Text(events[index].doctorName.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Text('Branch:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  Text(events[index].branchName.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  const Text('Service:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 10),
                                  Text(
                                      events[index]
                                          .appointmentTypeName
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text('Duration:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  Text('0:00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(width: 10),
                              const Divider(),
                              Row(children: [
                                const SizedBox(width: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Colors.yellow,
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Collect Payment'))
                              ])
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: getColor(index),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 5,
                              color: Colors.yellow,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(events[index].title.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          ],
                        ),
                        
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Are you sure you want to delete?'),
                                  // content: Text(event.event),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await context.read<MainCubit>().deleteAppointment(events[index].id.toString()).then((value) async {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(value.message ?? ''))
                                          );
                                          
                                          refresh();   
                                          if (value.status == 'success')  {
                                            Navigator.pop(context);
                                            Navigator.pop(context); 
                                            return;
                                          }
                                        });
                                      },
                                      child: const Text("Delete"),
                                    ), 
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.playlist_remove_outlined, color: Colors.white),  
                        ), 
                      ],
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
