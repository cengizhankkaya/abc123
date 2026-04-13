import 'package:abc123/features/shapes/l10n/generated/shapes_localizations.dart';

/// Model kodları (`DAIRE`, `KARE`, `ÜÇGEN`) → [ShapesLocalizations] metni.
String shapesLabelForCode(ShapesLocalizations l, String rawCode) {
  final code = rawCode.toUpperCase();
  switch (code) {
    case 'DAIRE':
      return l.shapeDaire;
    case 'KARE':
      return l.shapeKare;
    case 'ÜÇGEN':
    case 'UCGEN':
      return l.shapeUcgen;
    default:
      return rawCode;
  }
}
