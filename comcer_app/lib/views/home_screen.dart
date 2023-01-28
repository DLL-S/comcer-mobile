import 'package:comcer_app/controller/table_controller.dart';
import 'package:comcer_app/views/components/card/table_card/table_card.dart';
import 'package:comcer_app/views/do_request_screen.dart';
import 'package:comcer_app/views/order_pad_screen.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:comcer_app/design/core.dart';
import 'package:comcer_app/model/api_response.dart';
import 'package:comcer_app/model/table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final tableController = TableController();
  APIResponse<Mesa> _apiResponse = APIResponse<Mesa>();
  List<Mesa> tables = <Mesa>[];

  void showLoading() {
    if (mounted){
      setState(() {
      });
    }
  }

  void hideLoading() {
    if(mounted) {
      setState(() {
      });
    }
  }

  Future<List<Mesa>> listarMesas() async {
    showLoading();
    _apiResponse = await tableController.listarMesas();
    if (_apiResponse.data != null) {
      tables = _apiResponse.data!.resultados as List<Mesa>;
    } else if (_apiResponse.error!) {
      hideLoading();
    }
    return tables;
  }

  Widget bottomSheetItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: CCColors.darkRed,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: CCStyles.size22DarkRedBold,
        ),
      ],
    );
  }

  void showModalBottomSheetOptions(Mesa mesa) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: mesa.disponivel ? 80 : 140,
            color: CCColors.lightRed,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 80,
                  color: CCColors.darkRed,
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  child: bottomSheetItem(Icons.edit, Constant.fazerPedido),
                  onTap: () {
                    pushNewScreen(context,
                        screen: DoRequestScreen(table: mesa),
                        withNavBar: false);
                  },
                ),
                Visibility(
                    visible: mesa.disponivel ? false : true,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Divider(
                          color: CCColors.darkRed,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          child: bottomSheetItem(
                              Icons.article_outlined, Constant.verComanda),
                          onTap: () {
                            pushNewScreen(context,
                                screen: OrderPadScreen(table: mesa),
                                withNavBar: false);
                          },
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listarMesas();
    });
  }

  @override
  void deactivate() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listarMesas();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          listarMesas();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: FutureBuilder(
          future: listarMesas(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && _apiResponse.error == false) {
              return Container(
                color: CCColors.lightRed,
                child: RefreshIndicator(
                  onRefresh: () async {
                    listarMesas();
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            children: tables
                                .map((mesa) => TableCard(
                                    number: mesa.numero,
                                    status: mesa.disponivel,
                                    onTap: () {
                                      showModalBottomSheetOptions(mesa);
                                    }))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if(_apiResponse.error == true){
              return Container(
                color: CCColors.lightRed,
                child: Center(
                    child: Text(
                      "Houve um problema ao carregar os dados do serviço.\n " +
                          _apiResponse.errorMessage.toString(),
                      style: CCStyles.size14BlackBold,
                      textAlign: TextAlign.center,
                    )),
              );
            } else {
              return Container(
                color: CCColors.lightRed,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: CCColors.darkRed,
                  ),
                ),
              );
            }
          },
        ));
  }
}
