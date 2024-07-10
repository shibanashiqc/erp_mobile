import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_appointment_model.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appointment extends StatefulWidget {
   String customerId;
   Appointment({
    super.key,
    required this.customerId,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  
  dynamic totalAppointments = 0;
  dynamic completedAppointments = 0;
  dynamic uncomfirmedAppointments = 0;
  dynamic comfirmedAppointments = 0;
  
  
  @override
  void initState() {
    context.read<MainCubit>().get('sales/customer/${widget.customerId}/appointments').then((value) {
      final appointmentInvoice = CustomerAppointmentModel.fromJson(value);
      if (appointmentInvoice.data != null) { 
        setState(() {
          totalAppointments = appointmentInvoice.data?.totalAppointments ?? 0;
          completedAppointments = appointmentInvoice.data?.completedAppointments ?? 0;
          uncomfirmedAppointments = appointmentInvoice.data?.uncomfirmedAppointments ?? 0;
          comfirmedAppointments = appointmentInvoice.data?.comfirmedAppointments ?? 0;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return XContainer(
      child: Column(
        children: [
          // cards - appointment
          // Total - 0, Confirmed - 0, Pending - 0, Completed - 0
          
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width:  0.1), 
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Text('Appointments'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child:  Column(
                    children: [
                      // appointment cards
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text('Total', style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('$totalAppointments', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Confirmed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('$comfirmedAppointments', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Pending', style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('$uncomfirmedAppointments', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Completed', style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                              Text('$completedAppointments', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ]
                      ),  
                      
                    ],
                  ),
                ),
              ],
            ),
          ), 
          
        ],
      ),
    );
  }
}
