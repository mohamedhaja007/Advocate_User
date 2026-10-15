import 'package:flutter_test/flutter_test.dart';
import 'package:advocate_user_app/main.dart';
import 'package:advocate_user_app/core/di/service_locator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App smoke test', (WidgetTester tester) async {
    await initServiceLocator();
    await tester.pumpWidget(const AvvocatUserApp());
    expect(find.byType(AvvocatUserApp), findsOneWidget);
  });
}
