import 'package:flutter/material.dart';

// 插件
import 'package:system_theme/system_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// 页面
import 'package:ryans_weather_viewer/ui/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemTheme.fallbackColor = Colors.purple;
  await SystemTheme.accentColor.load();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(
      builder: (context, accent) {
        final FlexSchemeData materialFlexScheme = FlexSchemeData(
          name: 'Material',
          description: 'Material Flex Colors.',
          light: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.light,
          ),
          dark: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.dark,
          ),
        );
        return MaterialApp(
          theme: FlexThemeData.light(
            colors: materialFlexScheme.light,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
            fontFamily: 'MiSans',
          ),
          darkTheme: FlexThemeData.dark(
            colors: materialFlexScheme.dark,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
            fontFamily: 'MiSans',
          ),
          themeMode: ThemeMode.system,
          home: Home(),
        );
      },
    );
  }
}
