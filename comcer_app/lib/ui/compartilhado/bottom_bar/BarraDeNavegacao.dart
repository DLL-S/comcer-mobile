// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BarraDeNavegacao extends StatelessWidget {

  late List<Icon> iconesMenu;
  late int index;
  late GlobalKey<ScaffoldState> scaffoldKey;

  BarraDeNavegacao({Key? key, required this.iconesMenu, required this.index, required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Theme.of(context).primaryColor,
      items: iconesMenu,
      height: 60,
      index: index,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        switch(index){
          case(0):
            scaffoldKey.currentState!.openDrawer();
            break;
        }
      },
    );
  }
}
