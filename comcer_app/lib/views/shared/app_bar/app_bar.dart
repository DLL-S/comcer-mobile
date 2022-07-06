import 'package:comcer_app/core/core.dart';
import 'package:comcer_app/service/prefs_service.dart';
import 'package:comcer_app/util/constants.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends PreferredSize {
  final String titulo;

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

  AppBarCustom({Key? key, required this.titulo})
      : super(key: key,
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            title: Text(titulo),
            centerTitle: true,
            backgroundColor: AppColors.darkRed,
          ),
        );
}
