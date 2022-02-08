
import 'package:intl/intl.dart';

class Util {
  static String formataValorProdutoParaBR(double preco) {
    String valor;
    valor = preco.toStringAsFixed(2);
    valor.replaceAll(".", ",");
    return valor;
  }

  static String formatarDataHora(DateTime data){
    String dataFormatada = DateFormat('yyyy-MM-ddThh:mm:ss').format(data).toString();
    return dataFormatada;
  }


}
