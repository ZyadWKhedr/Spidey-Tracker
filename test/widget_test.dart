import 'package:flutter_test/flutter_test.dart';
import 'package:spidey_tracker/core/constants/app_strings.dart';
import 'package:spidey_tracker/app/app.dart';

void main() {
  testWidgets('Spidey Tracker App smoke test - Splash Page loads', (WidgetTester tester) async {
    // Build SpideyTrackerApp and trigger a frame.
    await tester.pumpWidget(const SpideyTrackerApp());

    // Verify that App name and tagline are present
    expect(find.text(AppStrings.appName.toUpperCase()), findsOneWidget);
    expect(find.text(AppStrings.appTagline), findsOneWidget);
  });
}
