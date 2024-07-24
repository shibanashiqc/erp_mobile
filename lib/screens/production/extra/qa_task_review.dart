import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/screens/common/delete-dialog.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/models/production/qa_task_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QaTaskReview extends StatefulWidget {
  QaTaskReview({
    super.key,
    required this.qaId,
    required this.qaTaskId,
  });

  String qaId;
  String qaTaskId;

  @override
  State<QaTaskReview> createState() => _QaTaskReviewState();
}

class _QaTaskReviewState extends State<QaTaskReview> {
  Map<String, dynamic> form = {
    'edit_id': '',
    'qa_task_id': '',
    'subject': '',
    'review': '',
  };

  bool loading = false;

  List<Data> data = [];
  @override
  void initState() {
    form['qa_task_id'] = widget.qaTaskId;
    super.initState();
    initData();
  }

  void initData() {
    context
        .read<MainCubit>()
        .get('production/qa/${widget.qaId}/tasks/${widget.qaTaskId}/reviews')
        .then((value) {
      QaTaskReviewModel res = QaTaskReviewModel.fromJson(value);
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
        title: const Text('QA Task Reviews'),
      ),
      body: XContainer(
        showShimmer: loading,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              XInput(
                initialValue: form['subject'] ?? '',
                label: 'Subject',
                hintText: 'Enter Subject', 
                onChanged: (v) { 
                  form['subject'] = v;
                },
              ),
              XInput(
                initialValue: form['review'] ?? '',
                label: 'Review',
                hintText: 'Enter Review',
                onChanged: (v) {
                  form['review'] = v;
                },
              ),
              TextButton(
                onPressed: () async {
                  context
                      .read<MainCubit>()
                      .postRes(
                        'production/update-or-create-qa-task-reviews',
                        form,
                        context,
                      )
                      .then((value) => {
                            if (value.errors == null)
                              {
                                form['edit_id'] = '',
                                form['subject'] = '',
                                form['review'] = '',
                                loading = true,
                                setState(() {}),
                                initData(),
                                Future.delayed(const Duration(seconds: 1), () {
                                  loading = false;
                                  setState(() {});
                                })
                              }
                          });
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 10),
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
                          Text(data[index].review ?? ''),
                          const SizedBox(height: 10),
                          Text('Created By: ${data[index].createdByName ?? ''}'),
                          const SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    loading = true;
                                    setState(() {});
                                    form['edit_id'] = data[index].id.toString();
                                    form['subject'] = data[index].subject;
                                    form['review'] = data[index].review;
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      loading = false;
                                      setState(() {});
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteDialog(
                                        context,
                                        () => {
                                              context
                                                  .read<MainCubit>()
                                                  .postRes(
                                                    'production/delete-qa-task-reviews',
                                                    {
                                                      'ids': [
                                                        data[index]
                                                            .id
                                                            .toString()
                                                      ]
                                                    },
                                                    context,
                                                  )
                                                  .then((value) => {
                                                        if (value.errors ==
                                                            null)
                                                          {
                                                            loading = true,
                                                            setState(() {}),
                                                            initData(),
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () {
                                                              loading = false;
                                                              setState(() {});
                                                            })
                                                          }
                                                      })
                                            });
                                  },
                                ),
                              ]),
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
