import 'app/app.dart';
import 'bootstrap.dart';

void main() {
  bootstrap(
    (themeStorageService, initialThemeMode) => SpideyTrackerApp(
      themeStorageService: themeStorageService,
      initialThemeMode: initialThemeMode,
    ),
  );
}
