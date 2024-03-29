import 'package:comcer_app/controller/table_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/core/app_styles.dart';
import 'package:comcer_app/dominio/models/api_response.dart';
import 'package:comcer_app/dominio/models/table_model.dart';
import 'package:comcer_app/views/components/card/table_card/table_card.dart';
import 'package:comcer_app/views/do_request_screen.dart';
import 'package:comcer_app/views/order_pad_screen.dart';
import 'package:comcer_app/util/constants.dart';
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
    if (mounted){
      setState(() {
        _isLoading = true;
      });
    }
  }

  void hideLoading() {
    if(mounted) {
      setState(() {
        _isLoading = false;
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
          color: AppColors.darkRed,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: AppStyles.size22DarkRedBold,
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
            color: AppColors.lightRed,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 3,
                  width: 80,
                  color: AppColors.darkRed,
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
                          color: AppColors.darkRed,
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
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      listarMesas();
    });
  }

  @override
  void deactivate() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      listarMesas();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
                color: AppColors.lightRed,
                child: Center(
                    child: Text(
                      "Houve um problema ao carregar os dados do serviço.\n " +
                          _apiResponse.errorMessage.toString(),
                      style: AppStyles.size14BlackBold,
                      textAlign: TextAlign.center,
                    )),
              );
            } else {
              return Container(
                color: AppColors.lightRed,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.darkRed,
                  ),
                ),
              );
            }
          },
        ));
  }
}
