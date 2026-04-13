import 'package:abc123/features/home/domain/repositories/i_gamification_persistence.dart';
import 'package:mocktail/mocktail.dart';

/// Merkezi mock sınıfları (`10_testing_standards.md` — mock_helpers).
class MockGamificationPersistence extends Mock
    implements IGamificationPersistence {}

/// [any] ile kullanılacak temel tipler için mocktail kayıtları.
void registerMockFallbackValues() {
  registerFallbackValue('');
  registerFallbackValue(0);
}
