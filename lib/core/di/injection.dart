import 'package:abc123/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Uygulama genelinde tek GetIt örneği (`09_dependency_injection.md`).
final GetIt getIt = GetIt.instance;

/// Injectable kayıtlarını yükler; `@preResolve` modülleri burada tamamlanır.
@InjectableInit(
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() => init(getIt);
