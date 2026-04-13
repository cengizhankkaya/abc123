import 'package:abc123/app/app.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/pump_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('Uygulama ağacı oluşur', (tester) async {
    await tester.pumpAppWithDefaultProviders();
    await tester.pump();
    expect(find.byType(MyApp), findsOneWidget);
  });
}
