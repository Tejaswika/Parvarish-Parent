import 'package:flutter/material.dart';

class LinkedLabelRadio extends StatelessWidget {
   LinkedLabelRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  bool groupValue=false;
  bool value=false;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              }),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}

class QuizSingleOption extends StatefulWidget {
  final int currIndex;
  const QuizSingleOption({Key? key, required this.currIndex}) : super(key: key);

  @override
  State<QuizSingleOption> createState() => _QuizSingleOptionState();
}

class _QuizSingleOptionState extends State<QuizSingleOption> {
  bool _isRadioSelected = false;
  bool defaultValue=false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        LinkedLabelRadio(
            label: "Quiz ${widget.currIndex+1}",
            padding: const EdgeInsets.all(10.0),
            value: true,
            groupValue: _isRadioSelected,
            //value: defaultValue,
            onChanged: (bool newValue) {
              setState(() {
                _isRadioSelected = newValue;
                defaultValue=newValue;
              });
            },),

            Container(
              margin: const EdgeInsets.only(left: 150.0),
              padding: const EdgeInsets.all(6.0),
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 32, 146),
                borderRadius: BorderRadius.circular(12),
                
              ),
              child: const Text(
                "Attempted",
                style:TextStyle(
                  color: Colors.white,
                ) ,
                ),
            )

      ],
    );
  }
}
