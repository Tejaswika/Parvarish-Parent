import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({Key? key, required this.name, required this.icon, required this.onPressed}) : super(key: key);
    final String name;
  final IconData icon;
  final Function onPressed;
  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {

  _DrawerItemState();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed(),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Icon(widget.icon, size: 20,color: const Color.fromARGB(255, 163, 153, 153),),
            const SizedBox(width: 30,),
            Text(
              widget.name, 
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 71, 71),
                ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,size: 20,color:  Color.fromARGB(255, 163, 153, 153)),
          ],
        ),
      ),
    );
  }
}