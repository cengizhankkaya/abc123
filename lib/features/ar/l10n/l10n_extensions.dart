import 'package:abc123/features/ar/l10n/generated/ar_localizations.dart';
import 'package:flutter/widgets.dart';

extension ArLocalizationsX on BuildContext {
  ArLocalizations get arL10n => ArLocalizations.of(this)!;

  String getArModelName(String id) {
    switch (id) {
      case 'at': return arL10n.arModelNameAt;
      case 'balik': return arL10n.arModelNameBalik;
      case 'civciv': return arL10n.arModelNameCivciv;
      case 'cicek': return arL10n.arModelNameCicek;
      case 'domuz': return arL10n.arModelNameDomuz;
      case 'elma': return arL10n.arModelNameElma;
      case 'fil': return arL10n.arModelNameFil;
      case 'gemi': return arL10n.arModelNameGemi;
      case 'gunes': return arL10n.arModelNameGunes;
      case 'horoz': return arL10n.arModelNameHoroz;
      case 'irgatci': return arL10n.arModelNameIrgatci;
      case 'inek': return arL10n.arModelNameInek;
      case 'jaguar': return arL10n.arModelNameJaguar;
      case 'kedi': return arL10n.arModelNameKedi;
      case 'limon': return arL10n.arModelNameLimon;
      case 'muz': return arL10n.arModelNameMuz;
      case 'nar': return arL10n.arModelNameNar;
      case 'ordek': return arL10n.arModelNameOrdek;
      case 'panda': return arL10n.arModelNamePanda;
      case 'robot': return arL10n.arModelNameRobot;
      case 'sincap': return arL10n.arModelNameSincap;
      case 'sampinyon': return arL10n.arModelNameSampinyon;
      case 'tavuk': return arL10n.arModelNameTavuk;
      case 'uzayli': return arL10n.arModelNameUzayli;
      case 'uzum': return arL10n.arModelNameUzum;
      case 'vagon': return arL10n.arModelNameVagon;
      case 'yildiz': return arL10n.arModelNameYildiz;
      case 'zurafa': return arL10n.arModelNameZurafa;
      default: return id;
    }
  }

  String getArAnimalFact(String id) {
    switch (id) {
      case 'at': return arL10n.arFactAt;
      case 'balik': return arL10n.arFactBalik;
      case 'civciv': return arL10n.arFactCivciv;
      case 'domuz': return arL10n.arFactDomuz;
      case 'kedi': return arL10n.arFactKedi;
      case 'elma': return arL10n.arFactElma;
      default: return '';
    }
  }
}
