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
  static String tokenExpirado =
      "Token expirado, por favor faça o login novamente.";
  static String suporte =
      "Ocorreu um erro na conexão com o serviço,\n por favor entre em contato com o suporte";

  //Login Screen
  static const String email = "Email";
  static const String senha = "Senha";
  static const String sair = "Sair";
  static const String emailVazio = "O E-mail deve ser informado.";
  static const String senhaVazia = "A senha deve ser informada.";
  static const String emailInvalido = "O E-mail inserido é inválido.";
  static const String senhaInvalida =
      "A senha deve possuir no mínimo 8 caracteres.";
  static const String entrar = "Entrar";

  //Base Screen
  static const String mesas = "Mesas";
  static const String pedidosEmAndamento = "Pedidos em Andamento";

  //Dialog
  static const String confirmacaoSaida = "Você deseja realmente sair?";
  static const String cancelar = "Cancelar";

  //Home Screen
  static const String fazerPedido = "Fazer Pedido";
  static const String verComanda = "Ver Comanda";

  //Do Request Screen
  static const String filtros = "Filtros:";
  static const String houveUmProblema =
      "Houve um problema ao carregar os dados do serviço.\n ";

  //Title of Screens
  static const String home = "Home";
  static const String pedidos = "Pedidos";

  //Order Pad Screen
  static const String confirmacao = "Confirmação";
  static const String fecharComanda = "Deseja realmente fechar a comanda?";
  static const String sim = "Sim";
  static const String comandaDaMesa = "Comanda da Mesa ";
  static const String atencao = "Atenção";
  static const String naoPodeSerEncerrada =
      "A comanda não pode ser encerrada pois ainda existem pedidos que não foram finalizados.";
  static const String fechar = "Fechar";
  static const String pedidoNumero = "Pedido n. ";
  static const String produto = "Produto: ";
  static const String quantidade = "Quantidade: ";
  static const String valorTotalComDoisPontos = "Valor Total:";

  //Orders creen
  static const String ultimaAtualizacao = "Última atualização em ";
  static const String horas = "hrs";
  static const String nenhumPedidoASerFinalizado = "Nenhum pedido a ser finalizado!";

  //Product of Order Screen
  static const String produtosDoPedido = "Produtos do Pedido";
  static const String status = "Status: ";
  static const String marcarComoEntregue = "Marcar como entregue";

  //Order in Progress Screen
  static const String statusPendente = 'Pendente';
  static const String statusCozinhando = 'Em preparo';
  static const String statusPronto = 'Pronto';
  static const String statusEntregue = 'Entregue';
  static const String statusDesconhecido = 'Status Desconhecido';

  //Order Resume Screen
  static const String mesa = "Mesa ";
  static const String pedidoRealizadoComSucesso =
      "Pedido realizado com sucesso!";
  static const String finalizarPedido = "Finalizar Pedido";
  static const String resumoDoPedido = "Resumo do Pedido";
  static const String valorTotal = "Valor Total";
  static const String itensDoPedido = "Itens do Pedido";
  static const String nenhumItemAdicionado =
      "Nenhum item adicionado ao pedido.";

  //Table Controller
  static const String mesaVazia = "Não há nenhuma mesa a ser exibida.";

  //Product Controller
  static const String produtosVazio = "Não há nenhum produto a ser exibido.";

  //Order Product Controller
  static const String statusAlterado = "Alteração executada com sucesso!";

  //Order Product Card
  static const String valorUnitario = "Valor unitário:";
  static const String mesaUpperCase = "MESA";

  //Order Card
  static const String pedidoComEspaco = "Pedido ";
  static const String tresZeros = "000";
  static const String verProdutos = "Ver produtos";

  //Others
  static const double FONT_LABEL_TEXT_SIZE = 18;
  static const double ROUNDING_EDGE_CONTAINER_VALUE = 8;
  static const double DEFAULT_DISTANCE_BETWEEN_WIDGETS = 8;
}
