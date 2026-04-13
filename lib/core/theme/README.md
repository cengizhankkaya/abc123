# Tema (`core/theme`)

- **FlexColorScheme** + Material 3: `AppTheme.lightTheme` / `AppTheme.darkTheme`
- **Semantik renkler**: `context.semanticColors` (`SemanticColors` ThemeExtension)
- **Tema modu**: `ThemeModeProvider` + `SharedPreferences` (ADR’deki HydratedBloc + Cubit yerine mevcut Provider yığını)

```dart
import 'package:abc123/core/theme/theme.dart';

final ok = context.semanticColors.success;
```

Metin stilleri için `ColorScheme.of(context)` / `AppTheme.headingLarge(context)` kullanın.
