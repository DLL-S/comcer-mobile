import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/ui/components/card/filter_card/fiter_card.dart';
import 'package:comcer_app/util/constant.dart';
import 'package:flutter/material.dart';

class DoRequestScreen extends StatefulWidget {
  const DoRequestScreen({Key? key}) : super(key: key);

  @override
  _DoRequestScreenState createState() => _DoRequestScreenState();
}

class _DoRequestScreenState extends State<DoRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.lightRed,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: Constant.DEFAULT_DISTANCE_BETWEEN_WIDGETS, horizontal: 4),
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(child: Text("Filtros:", style: TextStyle(color: AppColors.darkRed, fontSize: 14, fontWeight: FontWeight.bold,))),
                        FilterCard(filter: 'Bebidas', color: Colors.blue, isTapped: false ,onTap: (){}),
                        FilterCard(filter: 'Entrada', color: Colors.red, isTapped: false ,onTap: (){}),
                        FilterCard(filter: 'Menu Principal', color: Colors.green, isTapped: false ,onTap: (){}),
                        FilterCard(filter: 'Sobremesa', color: Colors.orange, isTapped: false ,onTap: (){}),
                        FilterCard(filter: 'Adicionais', color: Colors.grey, isTapped: false ,onTap: (){}),
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
