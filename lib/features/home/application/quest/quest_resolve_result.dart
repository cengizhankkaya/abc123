import 'package:abc123/features/home/application/dtos/quest_ledger.dart';

/// [QuestRolloverResolver] çıktısı.
final class QuestResolveResult {
  final QuestLedger ledger;
  final bool didRollover;

  const QuestResolveResult({
    required this.ledger,
    required this.didRollover,
  });
}
