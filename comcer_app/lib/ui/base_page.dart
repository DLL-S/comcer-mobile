import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/ui/fazer_pedido_page.dart';
import 'package:comcer_app/ui/home_page.dart';
import 'package:comcer_app/ui/pedidos_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BasePage extends StatefulWidget {
  BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {

  static const String home = 'Mesas';
  static const String fazerPedido = 'Fazer um Pedido';
  static const String pedidosEmAndamento = 'Pedidos em Andamento';
  String _title = "Mesas";


  void atualizarTitulo(int index, String title){
    setState(() {
      _title = title;
    });
  }


  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      PedidosPage(),
      FazerPedido(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add, color: AppCores.darkRed, size: 45),
        title: ("Fazer Pedido"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.article),
        title: ("Pedidos"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title), centerTitle: true, backgroundColor: AppCores.darkRed, actions: [IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))], ),
      drawer: Drawer(child: Container(color: Colors.white,),),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).primaryColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.5),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
        onItemSelected: (index){
          switch(index){
            case 0:
              atualizarTitulo(index, home);
              break;
            case 1:
              atualizarTitulo(index, fazerPedido);
              break;
            case 2:
              atualizarTitulo(index, pedidosEmAndamento);
              break;
          }
        },
      ),
    );
  }
}
