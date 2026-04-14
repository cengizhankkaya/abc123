import 'package:abc123/core/application/base/async_use_case.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/error/run_guarded.dart';
import 'package:abc123/core/types/result.dart';
import 'package:abc123/features/home/application/dtos/quest_ledger_write.dart';
import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Görev defterini kalıcılığa yazar (Command).
@injectable
final class PersistQuestLedger implements AsyncCommandResult<QuestLedgerWrite> {
  final IGamificationPersistence _persistence;

  PersistQuestLedger(this._persistence);

  @override
  FutureResult<Unit> call(QuestLedgerWrite input) {
    return runGuarded(() async {
      await _persistence.setString(GamificationConstants.keyQuestsLedger, input.encodedJson);
      return unit;
    });
  }
}
