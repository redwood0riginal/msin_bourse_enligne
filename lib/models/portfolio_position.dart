class PortfolioPosition {
  final String libelle;
  final int quantity;
  final double cmpNet;
  final double coursMarche;
  final double valorisation;
  final double valuesLatentes;
  final double performance;
  final double poids;

  PortfolioPosition({
    required this.libelle,
    required this.quantity,
    required this.cmpNet,
    required this.coursMarche,
    required this.valorisation,
    required this.valuesLatentes,
    required this.performance,
    required this.poids,
  });
}
