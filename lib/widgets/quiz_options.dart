import 'package:flutter/material.dart';

enum SingingCharacter { option1, option2, option3 }
class QuizOptions extends StatefulWidget {
  const QuizOptions({Key? key}) : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
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