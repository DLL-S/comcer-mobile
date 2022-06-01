import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends PreferredSize {
  final String titulo;

  AlertDialog showDialogLogOut(BuildContext context) {
    AlertDialog alerta = AlertDialog(
      title: const Text("Sair"),
      content: const Text("Você deseja realmente sair?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              PrefsService.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
            child: const Text(
              "Sair",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
    return alerta;
  }

  AppBarCustom({required this.titulo})
      : super(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            title: Text(titulo),
            centerTitle: true,
            backgroundColor: AppColors.darkRed,
          ),
        );
}
