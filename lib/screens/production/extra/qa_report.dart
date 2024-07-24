import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/models/production/qa_report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDisput extends StatefulWidget {
  ReportDisput({
    super.key,
    required this.qaId,
  }); 

  String qaId;

  @override
  State<ReportDisput> createState() => _ReportDisputState();
}

class _ReportDisputState extends State<ReportDisput> {
  Map<String, dynamic> form = {
    'qa_id': '',
    'subject': '',
    'description': '',
  };
   
  List<Data> data = [];
  @override
  void initState() {
    form['qa_id'] = widget.qaId; 
    super.initState();
    context.read<MainCubit>().get('production/qa/${widget.qaId}/reports').then((value) {
      QaReportModel res = QaReportModel.fromJson(value);
      if (res.data != null) {
        setState(() { 
          data = res.data!;
        });
      } 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QA Report'), 
      ),
      body: XContainer(
        
        child: Padding(   
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              XInput(
                label: 'Subject',
                hintText: 'Enter Subject',
                onChanged: (v) {
                  form['subject'] = v;
                },
              ),
              XInput(
                label: 'Description',
                hintText: 'Enter Description',
                onChanged: (v) {
                  form['description'] = v;
                },
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<MainCubit>()
                      .postRes(
                        'production/update-or-create-qa-reports',
                        form,
                        context,
                      )
                      .then((value) => {
                            if (value.errors == null) {Navigator.pop(context)}
                          });
                },
                child: const Text('Save'),
              ),
              
              const SizedBox(height: 10),
              const Text('Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
              const SizedBox(height: 10),            
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(), 
                separatorBuilder: (context, index) => const Divider(), 
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Text(data[index].subject ?? ''),
                      subtitle: Column(
                        children: [
                          Text(data[index].description ?? ''),
                          const SizedBox(height: 10),
                          Text('Created By: ${data[index].createdByName ?? ''}'),
                        ],
                      ),
                      ),
                  );
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}