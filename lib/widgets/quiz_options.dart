import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/local_storage_service.dart';

enum SingingCharacter { option1, option2, option3 }

class QuizOptions extends StatefulWidget {
  const QuizOptions({Key? key}) : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
  final String childFmcToken = LocalStorageService.getFmcToken("fmcToken");

  // @override
  // void initState() {
  //   print(childFmcToken);
  //   super.initState();
  // }

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
          RadioListTile<SingingCharacter>(
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
}
