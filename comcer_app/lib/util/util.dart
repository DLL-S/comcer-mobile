class Util {
  static String formataValorProdutoParaBR(double preco) {
    String valor = preco.toStringAsFixed(2);
    valor.replaceAll(".", ",");
    return valor;
  }
}
