import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parent/services/snackbar_service.dart';
import '../constants/db_constants.dart';
import '../services/local_storage_service.dart';
import 'new_quiz.dart';

class RadioItem {
  String name;
  int index;
  RadioItem({required this.name, required this.index});
}
//enum SingingCharacter { option1, option2, option3 }

Map<String, dynamic> assignQuizData = {
  ChildDataConstants.difficultyLevel: "",
  ChildDataConstants.topicName: "",
  ChildDataConstants.attempted: null,
  ChildDataConstants.blocked: null,
  ChildDataConstants.minScore: null,
  ChildDataConstants.quizId: null,
  ChildDataConstants.scores: [],
  ChildDataConstants.totalAttempts: null,
  ChildDataConstants.totalScores: null,
};

class QuizOptions extends StatefulWidget {

   Map<String, dynamic>? childData;
  final List<dynamic> quizOption;
  final String? topicName;
  final String? diffLevel;
  final String? childId;
   QuizOptions(
      {Key? key,
      required this.topicName,
      required this.quizOption,
      // required this.childData,
      required this.diffLevel,
      required this.childId})
      : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
  bool _isAssigningData = false;
  bool _isDataLoading = true;
  Map<String, dynamic> childData={};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  final String childFmcToken = LocalStorageService.getFmcToken("fmcToken");
     
  bool isBlocked = false;
  List<RadioItem> items = <RadioItem>[];
  int groupValue = 0;
  void readChildData() async{
    DocumentReference documentReferencer= _childCollection.doc(widget.childId);
    DocumentSnapshot childDataSnapshot = await documentReferencer.get();
    
    setState(() {
      childData = childDataSnapshot.data() as Map<String,dynamic>;
      _isDataLoading=false;
    });
  }

  @override
  void initState() {
    for (int i = 0; i < widget.quizOption.length; i++) {
      items.add(RadioItem(index: i, name: 'Quiz no. ' + (i + 1).toString()));
    }
    print(items);
    readChildData();
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
    bool isAttempted = false;
    String quizId = widget.quizOption[index];
    childData[ChildDataConstants.quizes].forEach((dynamic quiz) {
      if (quiz[ChildDataConstants.quizId] == quizId) {
        isAttempted = quiz[ChildDataConstants.attempted];
      }
    });
    return isAttempted;
    // print(childData?[ChildDataConstants.quizes][index]);
    // return true;
    // return childData?[ChildDataConstants.quizes][index]
    //     [ChildDataConstants.attempted];
  }

  bool _isQuizPresent(int index) {
    // print(widget.quizOption);
    if (childData[ChildDataConstants.quizes] == null) {
      return false;
    } else {
      for (var x in childData[ChildDataConstants.quizes]) {
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
      padding: const EdgeInsets.only(
        top: 10,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 81, 170, 243),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),

      child: Column(  
        children: [
          Text(
            "Select Quiz",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: items
                  .map(
                    (data) => Card(
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      elevation: 5,
                      color: Colors.white,
                      child: ListTile(
                        leading: Radio(
                          groupValue: groupValue,
                          value: data.index,
                          onChanged: (index) {
                            setState(() {
                              groupValue = int.parse(index.toString());
                              // print(groupValue);
                            });
                          },
                        ),
                        title: Text(data.name),
                        trailing: _isDataLoading? const CircularProgressIndicator() : _isQuizPresent(data.index)
                            ? _isAttempted(data.index)
                                // ? true
                                ? Container(
                                    padding: const EdgeInsets.all(6.0),
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.circular(8),
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
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "Not attempted",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                            : Container(
                                width: 80,
                              ),
                        onTap: () {
                          setState(() {
                            groupValue = data.index;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
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
    assignQuizData[ChildDataConstants.topicName] = widget.topicName;
    assignQuizData[ChildDataConstants.attempted] = false;
    assignQuizData[ChildDataConstants.blocked] = isBlocked;
    assignQuizData[ChildDataConstants.minScore] = 0;
    assignQuizData[ChildDataConstants.quizId] = widget.quizOption[index].trim();
    assignQuizData[ChildDataConstants.scores] = [];
    assignQuizData[ChildDataConstants.totalAttempts] = 0;
    assignQuizData[ChildDataConstants.totalScores] = 0;
    bool isQuizIdPresent = false;
    DocumentReference documentReferencer=_childCollection.doc(widget.childId);
    print(widget.quizOption[index]);
      for (var x in childData[ChildDataConstants.quizes]) {
        // print(x[ChildDataConstants.quizId]);
        if (x[ChildDataConstants.quizId] == widget.quizOption[index]) {
          x = assignQuizData;
          isQuizIdPresent = true;
        } else {
          isQuizIdPresent = false;
        }
      }
      if (!isQuizIdPresent) {
        childData[ChildDataConstants.quizes].add(assignQuizData);
      }
    await documentReferencer.update(childData).whenComplete(() {
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
