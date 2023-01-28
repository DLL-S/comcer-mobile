import 'package:comcer_app/controller/product_controller.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/views/home_screen.dart';
import 'package:comcer_app/views/orders_screen.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:comcer_app/design/core.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  ProductController productController = ProductController();

  String _title = 'Mesas';

  TextEditingController _searchQueryController = TextEditingController();

  AlertDialog showDialogLogOut(BuildContext context) {
    AlertDialog alerta = AlertDialog(
      title: const Text(Constant.sair),
      content: const Text(Constant.confirmacaoSaida),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(Constant.cancelar)),
        TextButton(
            onPressed: () {
              PrefsService.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
            child: const Text(
              Constant.sair,
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
    return alerta;
  }

  void atualizarTitulo(int index, String title) {
    setState(() {
      _title = title;
    });
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [const HomeScreen(), const OrdersScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: (Constant.home),
        activeColorPrimary: CCColors.yellow,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.article),
        title: (Constant.pedidos),
        activeColorPrimary: CCColors.yellow,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        backgroundColor: CCColors.darkRed,
        actions: [
          IconButton(
            onPressed: () {},
            icon: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return {Constant.sair}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (value) {
                if (value == Constant.sair) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showDialogLogOut(context);
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      // drawer: Drawer(
      //   child: Container(
      //     color: Colors.white,
      //   ),
      // ),
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
        navBarStyle: NavBarStyle.style6,
        onItemSelected: (index) {
          switch (index) {
            case 0:
              atualizarTitulo(index, Constant.mesas);
              break;
            case 1:
              atualizarTitulo(index, Constant.pedidosEmAndamento);
              break;
          }
        },
      ),
    );
  }
}
