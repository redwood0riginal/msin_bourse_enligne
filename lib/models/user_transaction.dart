enum TransactionType {
  action,
  opcvm,
  opv,
}

enum TransactionSens {
  achat,
  vente,
}

enum StatutSys {
  saisi,
  annule,
}

enum StatutMarche {
  annule,
  expire,
  totalementExecute,
  rejete,
  partialementExecute,
}

enum TypeOrder {
  limite,
  marche,
  seuil,
}

class UserTransaction {
  final String nOrder;
  final String libelle;
  final DateTime dateOrder;
  final TransactionSens sens;
  final double cours;
  final int qtyRestant;
  final int qtyExecute;
  final StatutSys statutSys;
  final StatutMarche statutMarche;
  final TypeOrder typeOrder;
  final DateTime dateExpiration;
  final TransactionType transactionType;

  UserTransaction({
    required this.nOrder,
    required this.libelle,
    required this.dateOrder,
    required this.sens,
    required this.cours,
    required this.qtyRestant,
    required this.qtyExecute,
    required this.statutSys,
    required this.statutMarche,
    required this.typeOrder,
    required this.dateExpiration,
    required this.transactionType,
  });

  int get qtyTotal => qtyRestant + qtyExecute;

  String get sensLabel {
    switch (sens) {
      case TransactionSens.achat:
        return 'Achat';
      case TransactionSens.vente:
        return 'Vente';
    }
  }

  String get statutSysLabel {
    switch (statutSys) {
      case StatutSys.saisi:
        return 'Saisi';
      case StatutSys.annule:
        return 'Annulé';
    }
  }

  String get statutMarcheLabel {
    switch (statutMarche) {
      case StatutMarche.annule:
        return 'Annulé';
      case StatutMarche.expire:
        return 'Expiré';
      case StatutMarche.totalementExecute:
        return 'Totalement exécuté';
      case StatutMarche.rejete:
        return 'Rejeté';
      case StatutMarche.partialementExecute:
        return 'Partiellement exécuté';
    }
  }

  String get typeOrderLabel {
    switch (typeOrder) {
      case TypeOrder.limite:
        return 'Limite';
      case TypeOrder.marche:
        return 'Marché';
      case TypeOrder.seuil:
        return 'Seuil';
    }
  }

  String get transactionTypeLabel {
    switch (transactionType) {
      case TransactionType.action:
        return 'Action';
      case TransactionType.opcvm:
        return 'OPCVM';
      case TransactionType.opv:
        return 'OPV';
    }
  }
}
