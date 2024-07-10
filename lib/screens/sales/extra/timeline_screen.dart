import 'package:erp_mobile/contants/color_constants.dart';
import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/sales/extra/customer_timeline_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimelineScreen extends StatefulWidget {
  String customerId;
  TimelineScreen({
    super.key,
    required this.customerId,
  });

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Data> timeline = [];

  @override
  void initState() {
    context
        .read<MainCubit>()
        .get('sales/customer/${widget.customerId}/timeline')
        .then((value) {
      final response = CustomerTimelineModel.fromJson(value);
      if (response.data != null) {
        setState(() {
          timeline = response.data ?? [];
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
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10), 
            shrinkWrap: true,
            itemCount: timeline.length,
            itemBuilder: (context, index) {
              return TimelineCard(data: timeline[index]);
            },
          ),
          TimelineCard(),
        ],
      ),
    );
  }
}

class TimelineCard extends StatelessWidget {
  Data? data;
  TimelineCard({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(data?.date ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 10), 
          shrinkWrap: true,
          itemCount: data?.items?.length ?? 0,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // circle
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: ColorConstants.timelineColor,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                     Text(data?.items?[index].createdAt ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            color: ColorConstants.timelineColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: 0.08 * MediaQuery.of(context).size.width,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${data?.items?[index].module ?? ''} Created'.toUpperCase(),
                                   style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 4,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorConstants.timelineColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
