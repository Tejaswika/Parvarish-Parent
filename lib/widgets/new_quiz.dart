import 'package:flutter/material.dart';
import 'quiz_form.dart';

// ignore: must_be_immutable
class NewQuiz extends StatefulWidget {
  final Map<String, dynamic>? childData;
  final String? childId;
  const NewQuiz({Key? key, required this.childData, required this.childId}) : super(key: key);

  @override
  State<NewQuiz> createState() => _NewQuizState();
}

class _NewQuizState extends State<NewQuiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 81, 170, 243),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        children: [
          Text(
            "Create Quiz",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          QuizForm(childData: widget.childData,childId: widget.childId),
        ],
      ),
    );
  }
}
