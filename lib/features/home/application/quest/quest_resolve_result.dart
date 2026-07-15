import 'package:abc123/features/home/application/dtos/quest_ledger.dart';
import 'package:abc123/features/home/application/quest/quest_rollover_resolver.dart'
    show QuestRolloverResolver;

/// [QuestRolloverResolver] çıktısı.
final class QuestResolveResult {
  const QuestResolveResult({
    required this.ledger,
    required this.didRollover,
  });
  final QuestLedger ledger;
  final bool didRollover;
}
