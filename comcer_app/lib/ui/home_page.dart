
import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/ui/compartilhado/bottom_bar/BarraDeNavegacao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final itensMenu = [
    const Icon(Icons.menu, size: 30, color: Colors.white,),
    const Icon(Icons.home, size: 30, color: Colors.white,),
    const Icon(Icons.article, size: 30, color: Colors.white,),
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(color: AppCores.darkRed,),
      ),
      backgroundColor: AppCores.lightRed,
      bottomNavigationBar: BarraDeNavegacao(scaffoldKey: _scaffoldKey,iconesMenu: itensMenu, index: 1,),
    );
  }
}
