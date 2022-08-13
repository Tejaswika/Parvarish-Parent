import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/constants/db_constants.dart';

import 'package:parent/widgets/quiz_options.dart';
import '../services/snackbar_service.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  List<DropdownMenuItem<String>> grade = [];
  List<DropdownMenuItem<String>> subject = [];
  List<DropdownMenuItem<String>> topic = [];
  List<DropdownMenuItem<String>> difficulty = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _quizCollection =
      _firestore.collection(DBConstants.quizCollectionName);
  Map<String, dynamic> classData = {};
  Map<String, dynamic> subjectData = {};
  Map<String, dynamic> topicData = {};
  Map<String, dynamic> diffData = {};
  Map<String, dynamic> classList = {
    "Class 1": "class_1",
    "Class 2": "class_2",
    "Class 3": "class_3",
    "Class 4": "class_4",
    "Class 5": "class_5",
    "Class 6": "class_6",
    "Class 7": "class_7",
    "Class 8": "class_8",
    "Class 9": "class_9",
    "Class 10": "class_10",
    "Class 11": "class_11",
    "Class 12": "class_12",
  };
  List<DropdownMenuItem<String>> getClassDropdownList() {
    List<DropdownMenuItem<String>> classes = [];
    classList.keys.forEach((grade) {
      classes.add(DropdownMenuItem(child: Text(grade)));
    });
    return classes;
  }

  List<DropdownMenuItem<String>> getSubjectDropDownList() {
    List<DropdownMenuItem<String>> subjects = [];
    classData.keys.forEach((subject) {
      subjects.add(DropdownMenuItem(child: Text(subject)));
    });
    return subjects;
  }

  List<DropdownMenuItem<String>> getTopicDropDownList() {
    List<DropdownMenuItem<String>> topics = [];
    subjectData.keys.forEach((topic) {
      topics.add(DropdownMenuItem(child: Text(topic)));
    });
    return topics;
  }

  List<DropdownMenuItem<String>> getDiffDropDownList() {
    List<DropdownMenuItem<String>> diff = [];
    topicData.keys.forEach((difficulty) {
      diff.add(DropdownMenuItem(child: Text(difficulty)));
    });
    return diff;
  }

  String selectedClass = "",
      selectedSub = "",
      selectedTopic = "",
      selectedDiff = "";
  final _formKey = GlobalKey<FormState>();
  void _showQuizOptions(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: ((context) => const QuizOptions()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: Text("Select class"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: selectedClass,
            elevation: 10,
            items: getClassDropdownList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedClass = newValue;
                });
                _getClassData(newValue);
              }
            },
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: Text("Select subject"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: selectedSub,
            elevation: 10,
            items: classData.isNotEmpty ? getSubjectDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedSub = newValue;
                });
                _getSubjectData(newValue);
              }
            },
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: Text("Select topics"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: selectedTopic,
            elevation: 10,
            items: subjectData.isNotEmpty ? getTopicDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTopic = newValue;
                });
                _getTopicData(newValue);
              }
            },
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: Text("Select difiiculty"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            value: selectedDiff,
            elevation: 10,
            items: subjectData.isNotEmpty ? getDiffDropDownList() : [],
            onChanged: (String? newValue) {
              if (newValue != null) {
                _getDiffData(newValue);
                setState(() {
                  selectedDiff = newValue;
                });
              }
            },
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
                child: const Text("Show Quizzes"),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _getClassData(String grade) async {
    DocumentReference documentReferencer =
        _quizCollection.doc(classList[grade]);
    DocumentSnapshot quizDataSnapshot = await documentReferencer.get();
    Map<String, dynamic>? data =
        quizDataSnapshot.data() as Map<String, dynamic>;
    setState(() {
      classData = data;
    });
    // print(data);
  }

  void _getSubjectData(String subject) {
    setState(() {
      subjectData = classData[subject];
    });
  }

  void _getTopicData(String topic) {
    setState(() {
      topicData = subjectData[topic];
    });
  }

  void _getDiffData(String difficulty) {
    setState(() {
      diffData = topicData[difficulty];
    });
  }
}





// class QuizForm extends StatefulWidget {
//   const QuizForm({Key? key}) : super(key: key);

//   @override
//   State<QuizForm> createState() => _QuizFormState();
// }

// class _QuizFormState extends State<QuizForm> {
  // void _showQuizOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  //     context: context,
  //     builder: ((context) => const QuizOptions()),
  //   );
  // }

//   String dropdownClassValue = QuizConstants.grade[0];
//   String dropdownSubValue = QuizConstants.subjects[0];
//   String dropdownTopicValue = QuizConstants.gkTopics[0];
//   String dropdownDiffValue = QuizConstants.difficulty[0];
  // final _formKey = GlobalKey<FormState>();

//   List<DropdownMenuItem<String>>? _getList(subName) {
//     if (subName == QuizConstants.subjects[0]) {
//       return [];
//     } else if (subName == QuizConstants.subjects[1]) {
//       return QuizConstants.mathsTopics.map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList();
//     } else if (subName == QuizConstants.subjects[2]) {
//       return QuizConstants.englishTopics.map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList();
//     } else if (subName == QuizConstants.subjects[5]) {
//       return QuizConstants.evsTopics.map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList();
//     } else if (subName == QuizConstants.subjects[3]) {
//       return QuizConstants.computerTopics.map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList();
//     } else if (subName == QuizConstants.subjects[4]) {
//       return QuizConstants.gkTopics.map<DropdownMenuItem<String>>(
//         (String value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(value),
//           );
//         },
//       ).toList();
//     } else {
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
          // DropdownButtonFormField<String>(
          //   validator: (value) {
          //     if (value == QuizConstants.grade[0] && value != null) {
          //       return "Please select a value";
          //     }
          //     return null;
          //   },
          //   iconSize: 30,
          //   iconEnabledColor: Theme.of(context).colorScheme.primary,
          //   isExpanded: true,
          //   value: dropdownClassValue,
          //   elevation: 10,
          //   items: QuizConstants.grade.map<DropdownMenuItem<String>>(
          //     (String value) {
          //       return DropdownMenuItem(
          //         value: value,
          //         child: Text(value),
          //       );
          //     },
          //   ).toList(),
          //   onChanged: (String? newValue) {
          //     setState(
          //       () {
          //         dropdownClassValue = newValue ?? "";
                  
          //       },
          //     );
          //   },
          // ),
//           DropdownButtonFormField<String>(
//             validator: (value) {
//               if (value == QuizConstants.subjects[0] && value != null) {
//                 return "Please select a value";
//               }
//               return null;
//             },
//             iconSize: 30,
//             iconEnabledColor: Theme.of(context).colorScheme.primary,
//             isExpanded: true,
//             value: dropdownSubValue,
//             elevation: 10,
//             items: QuizConstants.subjects.map(
//               (String value) {
//                 return DropdownMenuItem(
//                   value: value,
//                   child: Text(value),
//                 );
//               },
//             ).toList(),
//             onChanged: (String? newValue) {
//               setState(
//                 () {
//                   dropdownSubValue = newValue ?? " ";
//                   dropdownTopicValue = QuizConstants.gkTopics[0];
//                 },
//               );
//             },
//           ),
//           DropdownButtonFormField<String>(
//             validator: (value) {
//               if (value == QuizConstants.gkTopics[0] && value != null) {
//                 return "Please select a value";
//               }
//               return null;
//             },
//             iconSize: 30,
//             iconEnabledColor: Theme.of(context).colorScheme.primary,
//             isExpanded: true,
//             value: dropdownTopicValue,
//             elevation: 10,
//             items: _getList(dropdownSubValue),
//             onChanged: (String? newValue) {
//               setState(
//                 () {
//                   dropdownTopicValue = newValue ?? " ";
//                 },
//               );
//             },
//           ),
//           DropdownButtonFormField<String>(
//             // onTap: ,
//             validator: (value) {
//               if (value == QuizConstants.difficulty[0] && value != null) {
//                 return "Please select a value";
//               }
//               return null;
//             },
//             iconSize: 30,
//             iconEnabledColor: Theme.of(context).colorScheme.primary,
//             isExpanded: true,
//             value: dropdownDiffValue,
//             elevation: 10,
//             items: QuizConstants.difficulty.map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem(
//                   value: value,
//                   child: Text(value),
//                 );
//               },
//             ).toList(),
//             onChanged: (String? newValue) {
//               setState(
//                 () {
//                   dropdownDiffValue = newValue ?? " ";
//                 },
//               );
//             },
//           ),
//           const SizedBox(
//             height: 10,
//           ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     TextButton(
          //       onPressed: () => Navigator.pop(context),
          //       child: const Text("Cancel"),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         if (_formKey.currentState!.validate()) {
          //           SnackbarService.showSuccessSnackbar(
          //               context, "Data validated");
          //           _showQuizOptions(context);
          //         }
          //       },
          //       child: const Text("Show Quizzes"),
          //     )
          //   ],
          // ),
//         ],
//       ),
//     );
//   }
// }
