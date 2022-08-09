import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizOptions extends StatefulWidget {
  const QuizOptions({Key? key}) : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
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
            "to":
                'dh7oGSz6S022du4fb0g4B8:APA91bG-TiSFe_sO4GACivBnyC-vRoIzzp_AXH6hNJxNEg0ahOI1PDXFF-AgCFzYDK9Fn0ytW4c3IFGwdVevp6_QGeJZ1WIhvcFiZUPxnUo8I7pkKP4UP8WbgD1eCppDqhP6ek_aiX0W',
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

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
        child: Row(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 29, 63, 122),
                    child: const Center(
                        child: Text('Option 1',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 29, 63, 122),
                    child: const Center(
                        child: Text('Option 2',
                            style: TextStyle(color: Colors.white))),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 29, 63, 122),
                    child: const Center(
                        child: Text('Option 3',
                            style: TextStyle(color: Colors.white))),
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
            ),
          ],
        ));
  }
}
