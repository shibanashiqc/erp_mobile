import 'package:erp_mobile/screens/common/x_card.dart';
import 'package:erp_mobile/screens/sales/extra/add_drug_widget.dart';
import 'package:flutter/material.dart';

class Drugs extends StatefulWidget {
  const Drugs({
    super.key,
  });

  @override
  State<Drugs> createState() => _DrugsState();
}

class _DrugsState extends State<Drugs> {


  @override
  Widget build(BuildContext context) {
    return Column(
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
          itemCount: 2,
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
                        const Text('Test drug',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TYPE : '.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            const Text('CAPSULE',
                                style: TextStyle(
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
                            const Text('10',
                                style: TextStyle(
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
                            const Text('mg',
                                style: TextStyle(
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
                            const Text('test note	',
                                style: TextStyle(
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
    );
  }
}
