import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parent/constants/constants.dart';
import 'package:parent/constants/db_constants.dart';
import 'package:parent/screens/quiz_report_screen.dart';
import 'package:parent/services/maps_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/profile_screen.dart';
import '../screens/screen_time_report.dart';
import 'drawer_item.dart';
import 'new_quiz.dart';

class HomeAppDrawer extends StatefulWidget {
  final String? uid;
  final String? parentId;
  final String? childId;
  final Map<String, dynamic>? parentData;
  final Map<String, dynamic>? childData;
  const HomeAppDrawer({Key? key, required this.uid, required this.childData,
      required this.parentId,
      required this.childId,
      required this.parentData}) : super(key: key);

  @override
  State<HomeAppDrawer> createState() => _HomeAppDrawerState();
}

class _HomeAppDrawerState extends State<HomeAppDrawer> {
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
  Future exitDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit from the app?'),
        actions: [
          TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: const Text('EXIT')),
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.of(context).pop(false);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   child: ,
    //   onWillPop: (){
    //   exitDialog();
    //   return Future.value(false);
    // },
    return Drawer(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 2),
          child: Column(children: [
            //headerWidget(),
            UserAccountsDrawerHeader(
              accountName: Text(
                widget.parentData?[ParentDataConstant.name] ?? "Parent",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                widget.parentData?[ParentDataConstant.email] ?? "parent@gmail.com",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              currentAccountPicture:  CircleAvatar(
                backgroundColor: Colors.white30,
        
                child: Text(
                  '${widget.parentData?[ParentDataConstant.name][0]}'
                ),
              ),
            ),
            // const Divider(thickness: 1),

            DrawerItem(
              name: 'Home',
              icon: Icons.home,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SelectChild(uid: '')));
              },
            ),
            const Divider(thickness: 1),

          //DONE
            DrawerItem(
              name: 'My Profile',
              icon: Icons.face,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ProfileScreen(
                childData: widget.childData,
                parentId: widget.parentId,
                childId: widget.childId,
                parentData: widget.parentData,
              )));
              },
            ),
            const Divider(thickness: 1),

            DrawerItem(
              name: 'Report',
              icon: Icons.book,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                             ScreenTimeReport(UID: widget.childId,parentData: widget.parentData,)));
              },
            ),
            const Divider(thickness: 1),

            DrawerItem(
              name: 'Quiz',
              icon: Icons.quiz,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizReport(createQuiz: _createQuiz,childData: widget.childData,)));
              },
            ),
            DrawerItem(
              name: 'See Child Location',
              icon: Icons.quiz,
              onPressed: () {
                Navigator.pop(context);
                MapUtils.openMap();
              },
            ),
            const Spacer(),
            DrawerItem(
              name: 'Contat Us',
              icon: Icons.email,
              onPressed: () {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: ' parvarishsih@gmail.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': 'Query/Feedback',
                  }),
                );
                launchUrl(emailLaunchUri);
                Navigator.pop(context);
              },
            ),
            const Divider(thickness: 1),

            DrawerItem(
              name: 'Log out',
              icon: Icons.logout,
              onPressed: () {
                //LocalStorageService.setData("uid", "");
                exitDialog();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import '../screens/quiz_report_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeAppDrawer extends StatefulWidget {
//   const HomeAppDrawer({Key? key}) : super(key: key);

//   @override
//   State<HomeAppDrawer> createState() => _HomeAppDrawerState();
// }

// class _HomeAppDrawerState extends State<HomeAppDrawer> {
//   int _selected=0;
//     void changeSelected(int index){
//       setState(() {
//         _selected=index;
//       });
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: Container(
//         color: Colors.white,
//           child: ListView(
//             children: [
//               const UserAccountsDrawerHeader(
//                 accountName: Text(
//                   "Tarushi",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   ), 
//                 accountEmail: Text("test@gmail.com",
//                 style: TextStyle(
//                     fontSize: 15,
//                   ),
//                   ),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundColor: Colors.white30,
//                   child: Text("TS"),
//                   ),
//                 ),
//                 ListTile(
//                   selected: _selected==0,
//                   leading: const Icon(Icons.home),
//                   title: const Text("Home"),
//                   onTap: () {
//                     changeSelected(0);
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),

//                 ListTile(
//                   selected: _selected==1,
//                   leading: const Icon(Icons.face),
//                   title: const Text("My Profile"),
//                   onTap: () {
//                     changeSelected(1);
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),

//                 ListTile(
//                   selected: _selected==3,
//                   leading: const Icon(Icons.book),
//                   title: const Text("Report"),
//                   onTap: () {
//                     changeSelected(3);
                    
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),
//                 ListTile(
//                   selected: _selected==2,
//                   leading: const Icon(Icons.quiz),
//                   title: const Text("Quiz"),
//                   onTap: () {
//                     changeSelected(2);
//                     Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const QuizReport(),
//                                 ),
//                               );
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),

//                 const SizedBox(
//                   height: 190,
//                 ),
//                 ListTile(
//                   selected: _selected==6,
//                   leading: const Icon(Icons.phone),
//                   title: const Text("Contact Us"),
//                   onTap: () {
//                     changeSelected(6);
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
//                 const Divider(
//                   thickness: 1,
//                   indent: 10,
//                   endIndent: 10,
//                 ),

//                 ListTile(
//                   selected: _selected==7,
//                   leading: const Icon(Icons.logout_sharp),
//                   title: const Text("Logout"),
//                   onTap: () {
//                     changeSelected(7);
//                   } ,
//                   trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                 ),
                
//             ],
//           ),
//         )
//         );
//   }
// }
