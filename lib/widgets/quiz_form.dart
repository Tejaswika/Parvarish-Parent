import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parent/constants/db_constants.dart';

import 'package:parent/widgets/quiz_options.dart';
import '../services/snackbar_service.dart';

class QuizForm extends StatefulWidget {
  Map<String, dynamic>? childData;
  QuizForm({Key? key, required this.childData}) : super(key: key);

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
  List<dynamic> diffData = [];
  Map<String, dynamic> classList = {
    "Class 1": "Class 1",
    "Class 2": "Class 2",
    "Class 3": "Class 3",
    "Class 4": "Class 4",
    "Class 5": "Class 5",
    "Class 6": "Class 6",
    "Class 7": "Class 7",
    "Class 8": "Class 8",
    "Class 9": "Class 9",
    "Class 10": "Class 10",
    "Class 11": "Class 11",
    "Class 12": "Class 12",
  };
  List<DropdownMenuItem<String>> getClassDropdownList() {
    List<DropdownMenuItem<String>> classes = [];
    for (var grade in classList.keys) {
      classes.add(DropdownMenuItem(child: Text(grade), value: grade));
    }
    // print(classes);
    return classes;
  }

  List<DropdownMenuItem<String>> getSubjectDropDownList() {
    List<DropdownMenuItem<String>> subjects = [];
    for (var subject in classData.keys) {
      subjects.add(DropdownMenuItem(child: Text(subject), value: subject));
    }
    // print(subjects);
    return subjects;
  }

  List<DropdownMenuItem<String>> getTopicDropDownList() {
    List<DropdownMenuItem<String>> topics = [];
    for (var topic in subjectData.keys) {
      topics.add(DropdownMenuItem(
        child: Text(topic),
        value: topic,
      ));
    }
    // print(topics);
    return topics;
  }

  List<DropdownMenuItem<String>> getDiffDropDownList() {
    List<DropdownMenuItem<String>> diff = [];
    for (var difficulty in topicData.keys) {
      diff.add(DropdownMenuItem(
        child: Text(difficulty),
        value: difficulty,
      ));
    }
    // print(diff);
    return diff;
  }

  String? selectedClass = "Class 1";
  String? selectedSub;
  String? selectedTopic;
  String? selectedDiff;
  final _formKey = GlobalKey<FormState>();
  void _showQuizOptions(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: ((context) => QuizOptions(
          quizOption: diffData,
          childData: widget.childData,
          diffLevel: selectedDiff)),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(classData);
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
            hint: const Text("Select class"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
            elevation: 10,
            items: getClassDropdownList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _getClassData(newValue);
              }
            },
            value: selectedClass,
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: const Text("Select subject"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
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
            value: selectedSub,
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: const Text("Select topics"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
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
            value: selectedTopic,
          ),
          DropdownButtonFormField<String>(
            // validator: (value) {
            //   if (value == QuizConstants.grade[0] && value != null) {
            //     return "Please select a value";
            //   }
            //   return null;
            // },
            iconSize: 30,
            hint: const Text("Select difiiculty"),
            iconEnabledColor: Theme.of(context).colorScheme.primary,
            isExpanded: true,
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
            value: selectedDiff,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                minWidth: double.infinity,
                height: 30,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SnackbarService.showSuccessSnackbar(
                        context, "Data validated");
                    _showQuizOptions(context);
                  }
                },
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Show Quizes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              // Sign-up Button
              // const SizedBox(
              //   height: 8,
              // ),
              MaterialButton(
                minWidth: double.infinity,
                height: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              )
              // TextButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       SnackbarService.showSuccessSnackbar(
              //           context, "Data validated");
              //       _showQuizOptions(context);
              //     }
              //   },
              //   child: const Text("Show Quizzes",
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 15,
              //         backgroundColor: Colors.white,
              //       )),
              // ),
              // TextButton(
              //   onPressed: () => Navigator.pop(context),
              //   child: const Text("Cancel",
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 15,
              //         backgroundColor: Colors.white,
              //       )),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  void _getClassData(String grade) async {
    DocumentReference documentReferencer =
        _quizCollection.doc(classList[grade]);
    await documentReferencer.get().then((DocumentSnapshot quizDataSnapshot) {
      Map<String, dynamic>? data =
          quizDataSnapshot.data() as Map<String, dynamic>;
      setState(() {
        selectedClass = grade;
        classData = data;
      });
      print(data);
    });
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
