import 'package:flutter/material.dart';
import '../widgets/home_appdrawer.dart';
import '../screens/screen_time_report.dart';
import './profile_screen.dart';
import './quiz_report_screen.dart';
import '../widgets/new_quiz.dart';

//Store this globally
final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class MyNavPill extends StatefulWidget {
  final String? parentId;
  final Map<String, dynamic>? childData;
  final String? childId;
  final Map<String, dynamic>? parentData;
  const MyNavPill(
      {Key? key,
      required this.parentId,
      required this.childData,
      required this.childId,
      required this.parentData})
      : super(key: key);

  @override
  _MyNavPillState createState() => _MyNavPillState();
}

class _MyNavPillState extends State<MyNavPill>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  void _createQuiz(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (_) {
          return NewQuiz(childData: widget.childData, childId: widget.childId);
          // behavior: HitTestBehavior.deferToChild,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: const Text(
          'Parvarish',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text('Report'),
            ),
            Tab(
              child: Text('Quiz'),
            ),
            Tab(
              child: Text('Profile'),
            ),
          ],
        ),
      ),
      drawer: HomeAppDrawer(
        uid: widget.childId,
        childData: widget.childData,
        parentId: widget.parentId,
        childId: widget.childId,
        parentData: widget.parentData,
      ),
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => TabBarView(
            controller: _tabController,
            children: [
              ScreenTimeReport(
                parentData: widget.parentData,
                UID: widget.childId,
              ),
              QuizReport(createQuiz: _createQuiz, childData: widget.childData),
              ProfileScreen(
                childData: widget.childData,
                parentId: widget.parentId,
                childId: widget.childId,
                parentData: widget.parentData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
