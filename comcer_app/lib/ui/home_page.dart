import 'package:comcer_app/core/app_cores.dart';
import 'package:comcer_app/ui/card/table_Card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child: Container(
          color: AppCores.lightRed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      TableCard(numero: '01', onTap: (){}),
                      TableCard(numero: '02', onTap: (){}),
                      TableCard(numero: '03', onTap: (){}),
                      TableCard(numero: '04', onTap: (){}),
                      TableCard(numero: '05', onTap: (){}),
                      TableCard(numero: '06', onTap: (){}),
                      TableCard(numero: '07', onTap: (){}),
                      TableCard(numero: '08', onTap: (){}),
                      TableCard(numero: '09', onTap: (){}),
                      TableCard(numero: '10', onTap: (){}),
                      TableCard(numero: '11', onTap: (){}),
                      TableCard(numero: '12', onTap: (){}),
                      TableCard(numero: '13', onTap: (){}),
                      TableCard(numero: '14', onTap: (){}),
                      TableCard(numero: '15', onTap: (){}),
                      TableCard(numero: '16', onTap: (){}),
                      TableCard(numero: '17', onTap: (){}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
