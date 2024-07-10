import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/sales/extra/customer_drug_model.dart';
import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/sales/extra/add_drug_widget.dart';
import 'package:flutter/material.dart';

class Drugs extends StatefulWidget {
  String customerId;
  Drugs({
    super.key,
    required this.customerId,
  });

  @override
  State<Drugs> createState() => _DrugsState();
}

class _DrugsState extends State<Drugs> {
  
  List<Data> drugs = [];
  bool loading = false;
  
  initData() async{
    try {
      loading = true;
      setState(() {});
        final response = await MainCubit().get(
            'sales/customer/drugs',); 
        final CustomerDrugModel data = CustomerDrugModel.fromJson(response); 
        setState(() {
          loading = false; 
          drugs = data.data ?? [];   
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Drugs',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const AddDrugWidget();
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add Drug',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),  
          
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: drugs.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return XCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                           Text(drugs[index].name ?? '',
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('TYPE : '.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                               Text(drugs[index].type ?? '',
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('STRENGTH : '.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                               Text(drugs[index].strength ?? '',
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('DOSAGE : '.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                               Text(drugs[index].dosage ?? '',
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('NOTE : '.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                               Text(drugs[index].note ?? '', 
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ])),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
