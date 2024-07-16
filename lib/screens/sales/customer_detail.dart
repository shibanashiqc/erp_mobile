// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/response_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/sales/extra/appointment.dart';
import 'package:erp_mobile/screens/sales/extra/c_invoice.dart';
import 'package:erp_mobile/screens/sales/extra/clinical_notes.dart';
import 'package:erp_mobile/screens/sales/extra/drugs.dart';
import 'package:erp_mobile/screens/sales/extra/files.dart';
import 'package:erp_mobile/screens/sales/extra/payments.dart';
import 'package:erp_mobile/screens/sales/extra/prescription.dart';
import 'package:erp_mobile/screens/sales/extra/proceedure.dart';
import 'package:erp_mobile/screens/sales/extra/profile_detail.dart';
import 'package:erp_mobile/screens/sales/extra/timeline_screen.dart';
import 'package:erp_mobile/screens/sales/extra/treatments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetail extends StatefulWidget {
  Object? extra;
  CustomerDetail({
    super.key,
    required this.extra,
  });

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  List<Errors>? errorBags = [];
  String title = 'Customer Detail';
  late TabController tabController;
  String customerId = '';

  @override
  void initState() {
    try {
      final extra = widget.extra as Map<String, dynamic>;
      title = extra['name'].toString();
      customerId = extra['id'].toString(); 

      tabController = TabController(length: 12, vsync: this);
      tabController.addListener(() {
        setState(() {});
      });
    } catch (e) {
      log('Error: $e');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit(), child: buildScaffold(context));
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: XCard(
          child: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Profile',
                icon: Icon(CupertinoIcons.person),
              ),
              Tab(
                text: 'Treatment Plans',
                icon: Icon(CupertinoIcons.text_badge_checkmark),
              ),
              Tab(
                text: 'Invoice',
                icon: Icon(CupertinoIcons.money_dollar_circle_fill),
              ),
              Tab(
                text: 'Appointment',
                icon: Icon(CupertinoIcons.calendar_today),
              ),
              Tab(
                text: 'Clinical notes',
                icon: Icon(CupertinoIcons.doc_text_fill),
              ),
              Tab(
                text: 'Drugs',
                icon: Icon(Icons.medication),
              ),
              Tab(
                text: 'Prescription',
                icon: Icon(CupertinoIcons.doc_on_clipboard),
              ),
              Tab(
                text: 'Procudure',
                icon: Icon(CupertinoIcons.doc_on_clipboard),
              ),
              Tab(
                text: 'Completed Procudure',
                icon: Icon(CupertinoIcons.doc_on_clipboard),
              ),
              Tab(
                text: 'Payments',
                icon: Icon(CupertinoIcons.money_dollar_circle_fill),
              ),
              Tab(text: 'Files', icon: Icon(CupertinoIcons.doc_on_clipboard)),
              Tab(text: 'Timeline', icon: Icon(Icons.timeline)),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(title),
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(controller: tabController, children: [
             ProfileView(
              customerId: customerId, 
            ),
            Treatments(
               customerId: customerId, 
            ),
             CInvoices(
              customerId: customerId, 
            ),
             Appointment(
              customerId: customerId, 
             ),
             ClinicalNotes(
               customerId: customerId, 
            ),
             Drugs( 
              customerId: customerId, 
             ),
             Prescription(
              customerId: customerId, 
            ), 
             Procudure(
               customerId: customerId, 
             ),
            // const CompltedProcudure(),
             Treatments(
               isCompleted: true,
               customerId: customerId, 
            ), 
             Payments(
               customerId: customerId, 
            ),
             Files(
              customerId: customerId, 
            ),
             TimelineScreen(
              customerId: customerId, 
            ),
          ]),
        );
      }),
    );
  }
}



