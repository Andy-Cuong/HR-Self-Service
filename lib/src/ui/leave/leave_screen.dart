import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hr_self_service/src/ui/leave/leave_action.dart';
import 'package:hr_self_service/src/ui/leave/leave_provider.dart';
import 'package:hr_self_service/src/ui/leave/leave_state.dart';

class LeaveScreen extends ConsumerStatefulWidget {
  const LeaveScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends ConsumerState<LeaveScreen> {
  final _reasonController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(leaveViewModelProvider, (previous, next) {
      if (previous != null && previous.loading && !next.loading && !next.applicationSent) {
        Fluttertoast.showToast(
          msg: 'Failed to send leave application. Please try again.',
          toastLength: Toast.LENGTH_SHORT
        );
      }

      if (!next.loading && next.applicationSent) {
        Fluttertoast.showToast(
          msg: 'Application sent.',
          toastLength: Toast.LENGTH_SHORT
        );
      }
    });

    final state = ref.watch(leaveViewModelProvider);
    final viewModel = ref.read(leaveViewModelProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: state.loading,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  DropdownButtonFormField<LeaveType>(
                    initialValue: state.leaveType,
                    decoration: const InputDecoration(labelText: 'Leave Type'),
                    items: LeaveType.values.map((leaveType) =>
                      DropdownMenuItem(
                        value: leaveType,
                        child: Text(leaveType.name[0].toUpperCase() + leaveType.name.substring(1)),
                      )
                    ).toList(),
                    onChanged: (newLeaveType) {
                      if (newLeaveType != null) {
                        viewModel.onAction(OnUpdatingFields(newLeaveType: newLeaveType));
                      }
                    }
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: TextEditingController(
                      text: "From ${state.startDate.toLocal().toString().split(' ')[0]} to ${state.endDate.toLocal().toString().split(' ')[0]}" // Get only the date part
                    ),
                    decoration: const InputDecoration(labelText: 'Choose the day(s) you want to take leave'),
                    readOnly: true,
                    onTap: () async {
                      final selectedDateRange = await showDateRangePicker(
                        context: context,
                        initialDateRange: DateTimeRange(start: state.startDate, end: state.endDate),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365))
                      );
                      if (selectedDateRange != null) {
                        viewModel.onAction(OnUpdatingFields(
                          newStartDate: selectedDateRange.start,
                          newEndDate: selectedDateRange.end
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: TextEditingController(
                      text: state.numberOfDays.toString()
                    ),
                    decoration: const InputDecoration(labelText: 'Number of Days'),
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _reasonController,
                    decoration: const InputDecoration(labelText: 'Reason*'),
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    onChanged: (value) {
                      viewModel.onAction(OnUpdatingFields(newReason: value));
                    }
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(labelText: 'Contact during leave'),
                    onChanged: (value) {
                      viewModel.onAction(OnUpdatingFields(newContact: value));
                    }
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: state.reason.isEmpty? null : () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: Icon(Icons.send),
                          title: Text('Send Leave Request?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Review')
                                ),
                                SizedBox(width: 16),
                                
                                FilledButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text('Send')
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                      if (result == true) {
                        viewModel.onAction(OnSendClick());
                        _reasonController.clear();
                        _contactController.clear();
                      }
                    },
                    child: const Text('Submit Application')
                  ),
                ],
              ),
            ),
          ),

          if (state.loading)
            Container(
              color: Colors.black38,
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }
}