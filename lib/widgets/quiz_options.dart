import 'package:flutter/material.dart';

class QuizOptions extends StatefulWidget {
  const QuizOptions({Key? key}) : super(key: key);

  @override
  State<QuizOptions> createState() => _QuizOptions();
}

class _QuizOptions extends State<QuizOptions> {
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
                child: const Center(child: Text('Option 1', style: TextStyle(color: Colors.white))),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 29, 63, 122),
                child: const Center(child: Text('Option 2', style: TextStyle(color: Colors.white))),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 29, 63, 122),
                child: const Center(child: Text('Option 3', style: TextStyle(color: Colors.white))),
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
          ),
        ],
      )

    );
  }
}
