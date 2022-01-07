import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/ui/filter_card/fiter_card.dart';
import 'package:comcer_app/util/Constantes.dart';
import 'package:flutter/material.dart';

class FazerPedido extends StatefulWidget {
  const FazerPedido({Key? key}) : super(key: key);

  @override
  _FazerPedidoState createState() => _FazerPedidoState();
}

class _FazerPedidoState extends State<FazerPedido> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppCores.lightRed,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: Constantes.DIST_PADRAO_WIDGETS, horizontal: 8),
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(child: Text("Filtros:", style: TextStyle(color: AppCores.darkRed, fontSize: 14, fontWeight: FontWeight.bold,))),
                        FilterCard(filtro: 'Bebidas', cor: Colors.blue, tap: false ,onTap: (){}),
                        FilterCard(filtro: 'Entrada', cor: Colors.red, tap: false ,onTap: (){}),
                        FilterCard(filtro: 'Menu Principal', cor: Colors.green, tap: false ,onTap: (){}),
                        FilterCard(filtro: 'Sobremesa', cor: Colors.orange, tap: false ,onTap: (){}),
                        FilterCard(filtro: 'Adicionais', cor: Colors.grey, tap: false ,onTap: (){}),
                      ],
                    ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
