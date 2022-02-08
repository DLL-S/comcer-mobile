import 'package:comcer_app/controller/table_controller.dart';
import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/dominio/models/ApiResponse.dart';
import 'package:comcer_app/dominio/models/mesa.dart';
import 'package:comcer_app/ui/components/card/table_card/table_Card.dart';
import 'package:comcer_app/ui/do_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final tableController = TableController();
  APIResponse<Mesa> _apiResponse = APIResponse<Mesa>();
  List<Mesa> tables = <Mesa>[];
  bool _isLoading = false;

  void showLoading(){
    setState(() {
      _isLoading = true;
    });
  }
  void hideLoading(){
    setState(() {
      _isLoading = false;
    });
  }
  void listarMesas() async {
    showLoading();
    _apiResponse = await tableController.listarMesas();
    if(_apiResponse.data != null){
      tables = _apiResponse.data!.resultados as List<Mesa>;
    } else if (_apiResponse.error!){
      hideLoading();
    }
    hideLoading();
  }


  @override
  void initState() {
    super.initState();
    listarMesas();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child: Container(
          color: AppColors.lightRed,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children:tables.map((mesa) => TableCard(number: mesa.numero, status: mesa.disponivel, onTap: (){pushNewScreen(context, screen: DoRequestScreen(tableNumber: mesa.numero),withNavBar: false);})).toList(),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}



