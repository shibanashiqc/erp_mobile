import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_note_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClinicalNotes extends StatefulWidget {
  String customerId;
  ClinicalNotes({
    super.key,
    required this.customerId,
  });

  @override
  State<ClinicalNotes> createState() => _ClinicalNotesState();
}

class _ClinicalNotesState extends State<ClinicalNotes> {
  List<Data> notes = [];
  bool loading = false;
  Data form = Data();

  initData() {
    try {
      loading = true;
      setState(() {});
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        final response = await MainCubit().get(
            'sales/customer/${widget.customerId}/note',);
        final CustomerNotesModel data = CustomerNotesModel.fromJson(response); 
        setState(() {
          loading = false; 
          notes = data.data ?? [];   
        }); 
        
      });
    } catch (e) {
      print('Error: $e');
    }
  }
  
  @override
  void initState() {
    initData(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return XContainer(
      showShimmer: loading,
      child: Column(
        children: [
          Column(
            children: [
              XInput(
                onChanged: (value) {
                  form.note = value;
                },
                initialValue: form.note ?? '', 
                height: 0.1,
                label: 'Note',
                hintText: 'Enter note',
              ),
              XButton(
                label: 'Save', 
                onPressed: () async {
                  try {
                    form.customerId = int.parse(widget.customerId); 
                    final res = await MainCubit().postRes(
                        'sales/customer/${widget.customerId}/update-or-create-note',
                        form.toJson(), context);
                        
                    if(res.status == 'success') {
                      form = Data(); 
                      initData();
                    }
                  } catch (e) { 
                    print('Error: $e');
                  }
                },
              ),
            ],
          ),
          
          XCard(
            child: Column(
              children: notes.map((note) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      Text(note.note ?? ''),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          try { 
                            form = note;
                            initData();  
                          } catch (e) { 
                            print('Error: $e');
                          }
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(note.createdAt ?? ''),
                );
              }).toList() 
            ),
          ),
        ],
      ),
    );
  }
}
