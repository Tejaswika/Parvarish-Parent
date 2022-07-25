import 'package:flutter/material.dart';
import 'package:parent/screens/MyNavPill.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueGrey[800]),
        )),
      ),
      home: SelectChild()));
}

class SelectChild extends StatefulWidget {
  SelectChild({Key? key}) : super(key: key);

  @override
  _SelectChildState createState() => _SelectChildState();
}

class _SelectChildState extends State<SelectChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Child'),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  runSpacing: 5.0,
                  spacing: 10.0,
                  children: [
                    Container(
                        child: RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Select/Add Child \n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ],
                      ),
                    )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/2922/2922561.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyNavPill()));
                                    },
                                    child: Text(
                                      'Neha Singh',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/2922/2922510.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyNavPill()));
                                    },
                                    child: Text(
                                      'Raj Kumar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/1237/1237946.png'),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyNavPill()));
                                    },
                                    child: Text(
                                      'Add Child',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
