import 'package:erp_mobile/cubit/main_cubit.dart';
import 'package:erp_mobile/models/production/production_extra_model.dart'
    as production_extra;
import 'package:erp_mobile/models/production/qa_task_model.dart';
import 'package:erp_mobile/screens/common/delete-dialog.dart';
import 'package:erp_mobile/screens/common/x_bage.dart';
import 'package:erp_mobile/screens/common/x_container.dart';
import 'package:erp_mobile/screens/common/x_input.dart';
import 'package:erp_mobile/screens/common/x_select.dart';
import 'package:erp_mobile/screens/production/extra/qa_task_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QaTask extends StatefulWidget {
  QaTask({
    super.key,
    required this.qaId,
  });

  String qaId;

  @override
  State<QaTask> createState() => _QaTaskState();
}

class _QaTaskState extends State<QaTask> {
  Map<String, dynamic> form = {
    'qa_id': '',
    'user_id': '',
    'name': '',
    'description': '',
    'status': '',
    'priority': '',
    'start_date': '',
    'end_date': '',
  };

  List<Data> data = [];
  @override
  void initState() {
    form['qa_id'] = widget.qaId;
    super.initState();
    initData();
  }

  void initData() {
    context
        .read<MainCubit>()
        .get('production/qa/${widget.qaId}/tasks')
        .then((value) {
      QaTaskModel res = QaTaskModel.fromJson(value);
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
        title: const Text('QA Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddOrEdit(
                    form: form,
                    onSaved: initData,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: XContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      title: Column(
                        children: [
                          Text(data[index].createdAt ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          XBadge(
                            label: data[index].name ?? '',
                            icon: const Icon(
                              Icons.calendar_today,
                              size: 15,
                              color: Color.fromARGB(255, 3, 96, 218),
                            ),
                            color: const Color.fromARGB(255, 3, 96, 218),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Center(child: Text('Created By: ${data[index].createdByName ?? ''}')),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              XBadge(
                                label: data[index].status ?? '',
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              XBadge(
                                label: data[index].priority ?? '',
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              XBadge(
                                label: 'START : ${data[index].startDate ?? ''}',
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 5),
                              XBadge(
                                label: 'END : ${data[index].endDate ?? ''}',
                                icon: const Icon(
                                  Icons.calendar_today,
                                  size: 15,
                                  color: Colors.red,
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(child: Text(data[index].description ?? '')),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QaTaskReview(
                                        qaId: widget.qaId,
                                        qaTaskId: data[index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  form['edit_id'] = data[index].id.toString();
                                  form['user_id'] =
                                      data[index].userId.toString();
                                  form['name'] = data[index].name;
                                  form['description'] = data[index].description;
                                  form['status'] = data[index].status;
                                  form['priority'] = data[index].priority;
                                  form['start_date'] = data[index].startDate;
                                  form['end_date'] = data[index].endDate;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AddOrEdit(
                                        form: form,
                                        onSaved: initData,
                                      );
                                    },
                                  );
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
                                                    'production/delete-qa-tasks',
                                                    {
                                                      'ids': [data[index].id]
                                                    },
                                                    context)
                                                .then((value) {
                                              if (value.errors == null) {
                                                initData();
                                              }
                                            })
                                          });
                                },
                              ),
                            ],
                          ),
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

class AddOrEdit extends StatefulWidget {
  Function()? onSaved;
  AddOrEdit({
    super.key,
    required this.form,
    this.onSaved,
  });

  final Map<String, dynamic> form;

  @override
  State<AddOrEdit> createState() => _AddOrEditState();
}

class _AddOrEditState extends State<AddOrEdit> {
  List<production_extra.QaUsers> qaUsers = [];

  @override
  void initState() {
    context.read<MainCubit>().getExtraProduction(query: {
      'qa_id': widget.form['qa_id'],
    }).then((value) {
      if (value.data?.qaUsers != null) {
        setState(() {
          qaUsers = value.data!.qaUsers!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text('Add QA Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            XSelect(
              value: widget.form['user_id'],
              label: 'User',
              onChanged: (value) {
                widget.form['user_id'] = value;
                setState(() {});
              },
              options: qaUsers
                  .map((e) =>
                      DropDownItem(value: e.id.toString(), label: e.name))
                  .toList(),
            ),
            XInput(
              initialValue: widget.form['name'],
              label: 'Name',
              onChanged: (value) {
                widget.form['name'] = value;
              },
            ),
            XInput(
              initialValue: widget.form['description'],
              label: 'Description',
              onChanged: (value) {
                widget.form['description'] = value;
              },
            ),
            XSelect(
              value: widget.form['status'],
              label: 'Status',
              onChanged: (value) {
                widget.form['status'] = value;
                setState(() {});
              },
              options: ['active', 'inactive']
                  .map((e) => DropDownItem(value: e, label: e))
                  .toList(),
            ),
            XSelect(
              value: widget.form['priority'],
              label: 'Priority',
              onChanged: (value) {
                widget.form['priority'] = value;
                setState(() {});
              },
              options: ['low', 'medium', 'high']
                  .map((e) => DropDownItem(value: e, label: e))
                  .toList(),
            ),
            XInput(
              hintText: 'Select Date',
              initialValue: widget.form['start_date'],
              type: 'date',
              label: 'Start Date',
              onChanged: (value) {
                widget.form['start_date'] = value;
                setState(() {});
              },
            ),
            XInput(
              hintText: 'Select Date',
              initialValue: widget.form['end_date'],
              type: 'date',
              label: 'End Date',
              onChanged: (value) {
                widget.form['end_date'] = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<MainCubit>()
                  .postRes('production/update-or-create-qa-tasks', widget.form,
                      context)
                  .then((value) {
                if (value.errors == null) {
                  if (widget.onSaved != null) {
                    widget.onSaved!();
                  }
                  Navigator.pop(context);
                }
              });
              //Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
