// ignore_for_file: file_names

import 'dart:io';

class Constant {
  //Título do App
  static const String title = "COMCER - Comanda Certa";

  //API
  static const String localBaseUrl = "189.63.74.198:5000";
  static const String localBaseUrlProd = "comcer-api.herokuapp.com";
  static const String localBaseUrlDev = "comcer-api-dev.herokuapp.com";
  static final headers = {HttpHeaders.contentTypeHeader: "application/json"};

  //Messages

  static String suporte =
      "Ocorreu um erro na conexão com o serviço,\n por favor entre em contato com o suporte";

  //Login Screen
  static const String email = "Email";
  static const String senha = "Senha";
  static const String sair = "Sair";

  //Title of Screens
  static const String home = "Home";
  static const String fazerPedido = "Fazer Pedido";
  static const String pedidos = "Pedidos";

  //Order in Progress Screen
  static const String pedidoFeito = "Pedido feito";
  static const String emPreparo = "Em prepraro";
  static const String pedidoPronto = "Pedido pronto";
  static const String status1 = "1";
  static const String status2 = "2";
  static const String status3 = "3";

  //Others
  static const double FONT_LABEL_TEXT_SIZE = 18;
  static const double ROUNDING_EDGE_CONTAINER_VALUE = 8;
  static const double DEFAULT_DISTANCE_BETWEEN_WIDGETS = 8;
}
