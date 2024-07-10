import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_proceedure_model.dart';
import 'package:erp_mobile/screens/common/x_button.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:flutter/material.dart';

class Procudure extends StatefulWidget {
  String customerId;
  Procudure({
    super.key,
    required this.customerId,
  });

  @override
  State<Procudure> createState() => _ProcudureState();
}

class _ProcudureState extends State<Procudure> {
  
  List<Data> procceedure = [];
  bool loading = false;
  Data form = Data();
  
  initData() async{
    try {
      loading = true;
      setState(() {});
        final response = await MainCubit().get(
            'sales/customer/proceedures',); 
        final CustomerProceedureModel data = CustomerProceedureModel.fromJson(response); 
        setState(() {
          loading = false; 
          procceedure = data.data ?? [];   
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
                initialValue: form.name ?? '',
                onChanged: (value) {
                  form.name = value;
                },
                label: 'Name',
                hintText: 'Enter name',
              ),
              XInput(
                initialValue: form.price ?? '',
                onChanged: (value) {
                  form.price = value;
                },
                label: 'Price',
                hintText: 'Enter price',
              ),
              XButton(
                label: 'Save',
                onPressed: () async {
                  try {
                    final res = await MainCubit().postRes(
                        'sales/customer/update-or-create-proceedure',
                        form.toJson(),
                        context);

                    if (res.status == 'success') {
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
          Column(
            children: [
              XCard(
                child: Column(
                  children: procceedure.map((e) {
                    return ListTile(
                      title: Text(e.name ?? ''), 
                      subtitle: Text(e.price ?? ''),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () async {
                      //     try {
                      //       final res = await MainCubit().delete(
                      //           'sales/customer/delete-proceedures/${e.id}',
                      //           context);

                      //       if (res.status == 'success') {
                      //         initData();
                      //       }
                      //     } catch (e) {
                      //       print('Error: $e');
                      //     }
                      //   },
                      // ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

