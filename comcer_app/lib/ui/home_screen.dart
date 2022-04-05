import 'dart:convert';

import 'package:comcer_app/controller/table_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/mesa.dart';
import 'package:comcer_app/ui/components/card/table_card/table_Card.dart';
import 'package:comcer_app/ui/do_request_screen.dart';
import 'package:comcer_app/ui/order_pad_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final tableController = TableController();
  APIResponse<Mesa> _apiResponse = APIResponse<Mesa>();
  List<Mesa> tables = <Mesa>[];
  bool _isLoading = false;



  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  void listarMesas() async {
    showLoading();
    _apiResponse = await tableController.listarMesas();
    if (_apiResponse.data != null) {
      tables = _apiResponse.data!.resultados as List<Mesa>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    hideLoading();
  }

  void showOptionsDialog(int mesa, bool disponivel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            insetPadding: disponivel ? const EdgeInsets.symmetric(horizontal: 100) : const EdgeInsets.symmetric(horizontal: 0),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Mesa " + mesa.toString(),
                      style: AppStyles.size18DarkRedBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 35,
                            width: 115,
                            decoration: BoxDecoration(
                                color: AppColors.darkRed,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Fazer Pedido",
                              style: AppStyles.size14WhiteBold,
                            ),
                            alignment: Alignment.center,
                          ),
                          onTap: () {
                            pushNewScreen(context,
                                screen: DoRequestScreen(tableNumber: mesa));
                          },
                        ),
                        Visibility(
                          visible: disponivel ? false : true,
                          child: const SizedBox(
                            width: 24,
                          ),
                        ),
                        Visibility(
                          visible: disponivel ? false : true,
                          child: GestureDetector(
                            child: Container(
                              height: 35,
                              width: 115,
                              decoration: BoxDecoration(
                                  color: AppColors.darkRed,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Ver Comanda",
                                style: AppStyles.size14WhiteBold,
                              ),
                              alignment: Alignment.center,
                            ),
                            onTap: () {
                              pushNewScreen(context,
                                  screen: OrderPadScreen(tableNumber: mesa));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    listarMesas();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if( state == AppLifecycleState.resumed) {
      setState(() {
        listarMesas();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Container(
          color: AppColors.lightRed,
          child: RefreshIndicator(
            onRefresh: () async {
              listarMesas();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                children: [
                  Expanded(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.darkRed,
                            ),
                          )
                        : GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: tables
                                .map((mesa) => TableCard(
                                    number: mesa.numero,
                                    status: mesa.disponivel,
                                    onTap: () {
                                      showOptionsDialog(mesa.numero, mesa.disponivel);
                                    }))
                                .toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
