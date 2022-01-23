import 'package:comcer_app/core/app_colors.dart';
import 'package:comcer_app/ui/components/card/table_card/table_Card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
        child: Container(
          color: AppColors.lightRed,
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
                      TableCard(number: '01', onTap: (){}),
                      TableCard(number: '02', onTap: (){}),
                      TableCard(number: '03', onTap: (){}),
                      TableCard(number: '04', onTap: (){}),
                      TableCard(number: '05', onTap: (){}),
                      TableCard(number: '06', onTap: (){}),
                      TableCard(number: '07', onTap: (){}),
                      TableCard(number: '08', onTap: (){}),
                      TableCard(number: '09', onTap: (){}),
                      TableCard(number: '10', onTap: (){}),
                      TableCard(number: '11', onTap: (){}),
                      TableCard(number: '12', onTap: (){}),
                      TableCard(number: '13', onTap: (){}),
                      TableCard(number: '14', onTap: (){}),
                      TableCard(number: '15', onTap: (){}),
                      TableCard(number: '16', onTap: (){}),
                      TableCard(number: '17', onTap: (){}),
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
