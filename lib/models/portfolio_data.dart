import 'portfolio_account.dart';

class PortfolioData {
  final double valeurTotalePortefeuille;
  final double valeurTotaleTitres;
  final double soldeEnEspeces;
  final List<PortfolioAccount> accounts;

  PortfolioData({
    required this.valeurTotalePortefeuille,
    required this.valeurTotaleTitres,
    required this.soldeEnEspeces,
    required this.accounts,
  });
}
