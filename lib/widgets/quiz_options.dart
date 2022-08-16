import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parent/services/snackbar_service.dart';
import '../constants/db_constants.dart';
import '../services/local_storage_service.dart';

class RadioItem {
  String name;
  int index;
  RadioItem({required this.name, required this.index});
}
//enum SingingCharacter { option1, option2, option3 }

Map<String, dynamic> assignQuizData = {
  ChildDataConstants.difficultyLevel: "",
  ChildDataConstants.attempted: null,
  ChildDataConstants.blocked: null,
  ChildDataConstants.minScore: null,
  ChildDataConstants.quizId: null,
  ChildDataConstants.scores: [],
  ChildDataConstants.totalAttempts: null,
  ChildDataConstants.totalScores: null,
};

class QuizOptions extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final List<dynamic> quizOption;
  final String? diffLevel;
  final String? childId;
  const QuizOptions(
      {Key? key,
      required this.quizOption,
      required this.childData,
      required this.diffLevel,
      required this.childId})
      : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
  bool _isAssigningData = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  final String childFmcToken = LocalStorageService.getFmcToken("fmcToken");
  bool isBlocked = false;
  List<RadioItem> items = <RadioItem>[];
  int groupValue = 0;
  @override
  void initState() {
    for (int i = 0; i < widget.quizOption.length; i++) {
      items.add(RadioItem(index: i, name: 'Quiz' + (i + 1).toString()));
    }
    super.initState();
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAN6PDOmY:APA91bFQ9RmZ9z6t2uwqy695724nwjnm5XPdTmygjL1R54T4AHdIQJAhRKteK4agmEfY87pTNYV22v9DPc__GMObXdvbR_8SHsL_6o_ec8ohyU9XwJ_Dh9xgm3LP2S_1VGB3k4QiQIWe',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'A quiz has been alloted to you',
              'title': 'New Quiz',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": childFmcToken,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  bool _isAttempted(int index) {
    return widget.childData?[ChildDataConstants.quizes][index]
        [ChildDataConstants.attempted];
  }

  bool _isQuizPresent(int index) {
    // print(widget.quizOption);
    if (widget.childData?[ChildDataConstants.quizes] == null) {
      return false;
    } else {
      for (var x in widget.childData?[ChildDataConstants.quizes]) {
        if (x[ChildDataConstants.quizId] == widget.quizOption[index]) {
          return true;
        }
      }
      return false;
    }
  }

  //SingingCharacter? _character = SingingCharacter.option1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 81, 170, 243),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          ...items
              .map(
                (data) => Card(
                  elevation: 3,
                  shadowColor: const Color(0xFFAAAAAA),
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent, width: 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        groupValue = data.index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      // child: Directionality(
                      //   textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Radio(
                            groupValue: groupValue,
                            value: data.index,
                            onChanged: (index) {
                              setState(() {
                                groupValue = int.parse(index.toString());
                                // print(groupValue);
                              });
                            },
                          ),
                          Text(data.name),
                          _isQuizPresent(data.index)
                              ? _isAttempted(data.index)
                                  ? Container(
                                      padding: const EdgeInsets.all(6.0),
                                      height: 30,
                                      // width: 80,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        "Attempted",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(6.0),
                                      height: 25,
                                      // width: 10,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        "Not attempted",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          Container(
            margin: const EdgeInsets.only(left: 35, top: 15),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: Theme.of(context).colorScheme.primary,
                  value: isBlocked,
                  onChanged: (bool? value) {
                    setState(() {
                      isBlocked = value ?? isBlocked;
                    });
                  },
                ),
                const Text("Do you want to block your child's phone"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                sendPushMessage();
                setState(() {
                  _isAssigningData = true;
                });
                assignData(groupValue);
                // if (!_isAssigningData) {
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                // }
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isAssigningData
                  ? Center(
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : const Text(
                      'Create quiz',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void assignData(int index) async {
    assignQuizData[ChildDataConstants.difficultyLevel] = widget.diffLevel;
    assignQuizData[ChildDataConstants.attempted] = false;
    assignQuizData[ChildDataConstants.blocked] = isBlocked;
    assignQuizData[ChildDataConstants.minScore] = 0;
    assignQuizData[ChildDataConstants.quizId] = widget.quizOption[index];
    assignQuizData[ChildDataConstants.scores] = 0;
    assignQuizData[ChildDataConstants.totalAttempts] = 0;
    assignQuizData[ChildDataConstants.totalScores] = 0;
    bool isQuizIdPresent = false;
    print(widget.quizOption[index]);
    if (widget.childData != null) {
      for (var x in widget.childData![ChildDataConstants.quizes]) {
        // print(x[ChildDataConstants.quizId]);
        if (x[ChildDataConstants.quizId] == widget.quizOption[index]) {
          x = assignQuizData;
          isQuizIdPresent = true;
        } else {
          isQuizIdPresent = false;
        }
      }
      if (!isQuizIdPresent) {
        widget.childData![ChildDataConstants.quizes].add(assignQuizData);
      }
    }
    DocumentReference documentReferencer = _childCollection.doc(widget.childId);
    await documentReferencer
        .set(widget.childData as Map<String, Object>)
        .whenComplete(() {
      setState(() {
        _isAssigningData = false;
      });
      SnackbarService.showSuccessSnackbar(
          context, "Quiz assigned successfully");
    }).onError((error, stackTrace) {
      setState(() {
        _isAssigningData = false;
      });
      SnackbarService.showErrorSnackbar(context, "Some error occured");
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
