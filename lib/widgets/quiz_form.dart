import 'package:flutter/material.dart';

import 'package:parent/services/snackbar_service.dart';
import 'package:parent/widgets/quiz_options.dart';
import '../constants/quiz_constants.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  void _showQuizOptions(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: ((context) => const QuizOptions()),
    );
  }

  String dropdownClassValue = QuizConstants.grade[0];
  String dropdownSubValue = QuizConstants.subjects[0];
  String dropdownTopicValue = QuizConstants.gkTopics[0];
  String dropdownDiffValue = QuizConstants.difficulty[0];
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>>? _getList(subName) {
    if (subName == QuizConstants.subjects[0]) {
      return [];
    } else if (subName == QuizConstants.subjects[1]) {
      return QuizConstants.mathsTopics.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList();
    } else if (subName == QuizConstants.subjects[2]) {
      return QuizConstants.englishTopics.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList();
    } else if (subName == QuizConstants.subjects[3]) {
      return QuizConstants.evsTopics.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList();
    } else if (subName == QuizConstants.subjects[4]) {
      return QuizConstants.computerTopics.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList();
    } else {
      return QuizConstants.gkTopics.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == QuizConstants.grade[0] && value != null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: dropdownClassValue,
            elevation: 10,
            items: QuizConstants.grade.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownClassValue = newValue ?? "";
                },
              );
            },
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == QuizConstants.subjects[0] && value != null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: dropdownSubValue,
            elevation: 10,
            items: QuizConstants.subjects.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownSubValue = newValue ?? " ";
                },
              );
            },
          ),
          DropdownButtonFormField<String>(
            validator: (value) {
              if (value == QuizConstants.gkTopics[0] && value != null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: dropdownTopicValue,
            elevation: 10,
            items: _getList(dropdownSubValue),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownTopicValue = newValue ?? " ";
                },
              );
            },
          ),
          DropdownButtonFormField<String>(
            // onTap: ,
            validator: (value) {
              if (value == QuizConstants.difficulty[0] && value != null) {
                return "Please select a value";
              }
              return null;
            },
            iconSize: 30,
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: dropdownDiffValue,
            elevation: 10,
            items: QuizConstants.difficulty.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownDiffValue = newValue ?? " ";
                },
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SnackbarService.showSuccessSnackbar(
                        context, "Data validated");
                    _showQuizOptions(context);
                  }
                },
                child: Text("Show Quizzes"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
