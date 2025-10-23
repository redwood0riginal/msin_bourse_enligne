import 'portfolio_position.dart';

class PortfolioAccount {
  final String accountId;
  final String accountName;
  final List<PortfolioPosition> positions;

  PortfolioAccount({
    required this.accountId,
    required this.accountName,
    required this.positions,
  });
}
