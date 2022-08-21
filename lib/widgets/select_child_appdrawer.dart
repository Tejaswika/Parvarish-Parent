import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/db_constants.dart';
import 'drawer_item.dart';

class SelectChildAppDrawer extends StatefulWidget {
  final Map<String, dynamic>? parentData;
  const SelectChildAppDrawer({Key? key, required this.parentData}) : super(key: key);

  @override
  State<SelectChildAppDrawer> createState() => _SelectChildAppDrawerState();
}

class _SelectChildAppDrawerState extends State<SelectChildAppDrawer> {
  Future exitDialog() {
    return showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit from app?'),
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
    return Drawer(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 2),
          child: Column(children: [
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

            DrawerItem(
              name: 'Home',
              icon: Icons.home,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Divider(thickness: 1),

           
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

// class SelectChildAppDrawer extends StatefulWidget {
//   const SelectChildAppDrawer({Key? key}) : super(key: key);

//   @override
//   State<SelectChildAppDrawer> createState() => _SelectChildAppDrawerState();
// }

// class _SelectChildAppDrawerState extends State<SelectChildAppDrawer> {
//   int _selected=0;
//     void changeSelected(int index){
//       setState(() {
//         _selected=index;
//       });
//     }
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Drawer(
//               child: ListView(
//                 children: [
//                   const UserAccountsDrawerHeader(
//                     accountName: Text(
//                       "Tarushi",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       ), 
//                     accountEmail: Text("test@gmail.com",
//                     style: TextStyle(
//                         fontSize: 15,
//                       ),
//                       ),
//                     currentAccountPicture: CircleAvatar(
//                       backgroundColor: Colors.white30,
//                       child: Text("TS"),
//                       ),
//                     ),

//                     ListTile(
//                       selected: _selected==0,
//                       leading: const Icon(Icons.home),
//                       title: const Text("Home"),
//                       onTap: () {
//                         changeSelected(0);
//                       } ,
//                       trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       indent: 10,
//                       endIndent: 10,
//                     ),

//                     ListTile(
//                       selected: _selected==1,
//                       leading: const Icon(Icons.face),
//                       title: const Text("My Profile"),
//                       onTap: () {
//                         changeSelected(1);
//                       } ,
//                       trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       indent: 10,
//                       endIndent: 10,
//                     ),

//                      const SizedBox(
//                       height:335,
//                     ),

//                     ListTile(
//                       selected: _selected==6,
//                       leading: const Icon(Icons.phone),
//                       title: const Text("Contact Us"),
//                       onTap: () {
//                         changeSelected(6);
//                       } ,
//                       trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       indent: 10,
//                       endIndent: 10,
//                     ),

//                     ListTile(
//                       selected: _selected==7,
//                       leading: const Icon(Icons.logout_sharp),
//                       title: const Text("Logout"),
//                       onTap: () {
//                         changeSelected(7);
//                       } ,
//                       trailing: const Icon(Icons.arrow_forward_ios_rounded),
//                     ),
                    
//                 ],
//               ),
//             ),
//       ],
//     );
//   }
// }