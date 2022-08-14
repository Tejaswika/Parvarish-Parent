import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parent/widgets/quiz_single_option.dart';

import '../constants/db_constants.dart';
import '../services/local_storage_service.dart';

enum SingingCharacter { option1, option2, option3 }

Map<String, dynamic> assignQuizData = {
  "diffculty_level": "",
  "is_attempted": null,
  "is_blocked": null,
  "min_score": null,
  "quiz_id": null,
  "scores": [],
  "total_attempts": null,
  "total_score": null,
};

class QuizOptions extends StatefulWidget {
  Map<String, dynamic>? childData;
  final List<dynamic> quizOption;
  String? diffLevel;
   QuizOptions({Key? key, required this.quizOption, required this.childData, required this.diffLevel}) : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _childCollection =
      _firestore.collection(DBConstants.childCollectionName);
  final String childFmcToken = LocalStorageService.getFmcToken("fmcToken");
   bool isBlocked=false;

  //  @override
  //  void initState() {
  //    print(childFmcToken);
  //    super.initState();
  //  }

  void sendPushMessage() async {
    print("####################################");
    print(childFmcToken);
    print("####################################");
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

  SingingCharacter? _character = SingingCharacter.option1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 81, 170, 243),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(30),
          ),
          /*RadioListTile<SingingCharacter>(
            title: const Text('Option 1'),
            value: SingingCharacter.option1,
            groupValue: _character,
            activeColor: Colors.black,
            tileColor: Colors.green,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            title: const Text('Option 2'),
            value: SingingCharacter.option2,
            groupValue: _character,
            activeColor: Colors.black,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            title: const Text('Option 3'),
            value: SingingCharacter.option3,
            groupValue: _character,
            activeColor: Colors.black,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),*/
          ListView.builder(
            itemBuilder: (context, index) {
              return QuizSingleOption(currIndex: index);
            },
            shrinkWrap: true,
            itemCount: widget.quizOption.length,
          ),

          Row(
            children: [
              Checkbox(
      checkColor: Colors.white,
      //fillColor: Theme.of(context).colorScheme.primary,
      value: isBlocked,
      onChanged: (bool? value) {
        setState(() {
              isBlocked = value!;
        });
      },
    ),
    const Text("Do you want to block your child's phone"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                sendPushMessage();
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
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
  void assignQuiz(){
    setState(() {
      assignQuizData["diffculty_level"]=widget.diffLevel;
      assignQuizData["is_attempted"]=false;
      assignQuizData["is_blocked"]=isBlocked;
  assignQuizData["min_score"]=0;
  assignQuizData["quiz_id"];
  assignQuizData["scores"]=0;
  assignQuizData["total_attempts"]=0;
  assignQuizData["total_score"]=0;
    });
  }
}
