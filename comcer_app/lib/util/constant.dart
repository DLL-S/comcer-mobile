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
  static const String statusPendente = 'Pendente';
  static const String statusCozinhando = 'Em preparo';
  static const String statusPronto = 'Pronto';
  static const String statusEntregue = 'Entregue';
  static const String statusDesconhecido = 'Status Desconhecido';

  //Order Resume Screen
  static const String mesa = "Mesa ";
  static const String pedidoRealizadoComSucesso = "Pedido realizado com sucesso!";
  static const String finalizarPedido = "Finalizar Pedido";
  static const String resumoDoPedido = "Resumo do Pedido";
  static const String valorTotal = "Valor Total";
  static const String itensDoPedido = "Itens do Pedido";
  static const String nenhumItemAdicionado = "Nenhum item adicionado ao pedido.";

  //Others
  static const double FONT_LABEL_TEXT_SIZE = 18;
  static const double ROUNDING_EDGE_CONTAINER_VALUE = 8;
  static const double DEFAULT_DISTANCE_BETWEEN_WIDGETS = 8;
}
