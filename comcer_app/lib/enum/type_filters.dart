enum TypeFilter { tradicionais, especiais, doces, adicionais, bebidas }

extension TypeFilterExtension on TypeFilter {
  String get value {
    switch(this) {
      case TypeFilter.tradicionais:
        return 'Tradicionais';
      case TypeFilter.especiais:
        return 'Especiais';
      case TypeFilter.doces:
        return 'Doces';
      case TypeFilter.adicionais:
        return 'Adicionais';
      case TypeFilter.bebidas:
        return 'Bebidas';
    }
  }
}
