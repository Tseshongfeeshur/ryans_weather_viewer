import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class ColorSchemeDebugger extends StatelessWidget {
  const ColorSchemeDebugger({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // 将 ColorScheme 中的颜色映射为列表，方便展示
    final List<MapEntry<String, Color>> colors = [
      MapEntry('primary', colorScheme.primary),
      MapEntry('onPrimary', colorScheme.onPrimary),
      MapEntry('primaryContainer', colorScheme.primaryContainer),
      MapEntry('onPrimaryContainer', colorScheme.onPrimaryContainer),

      MapEntry('secondary', colorScheme.secondary),
      MapEntry('onSecondary', colorScheme.onSecondary),
      MapEntry('secondaryContainer', colorScheme.secondaryContainer),
      MapEntry('onSecondaryContainer', colorScheme.onSecondaryContainer),

      MapEntry('tertiary', colorScheme.tertiary),
      MapEntry('onTertiary', colorScheme.onTertiary),
      MapEntry('tertiaryContainer', colorScheme.tertiaryContainer),
      MapEntry('onTertiaryContainer', colorScheme.onTertiaryContainer),

      MapEntry('error', colorScheme.error),
      MapEntry('onError', colorScheme.onError),

      MapEntry('surface', colorScheme.surface),
      MapEntry('onSurface', colorScheme.onSurface),
      MapEntry('outline', colorScheme.outline),
      MapEntry('surfaceContainerHighest', colorScheme.surfaceContainerHighest),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('调色盘')),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final entry = colors[index];
          final color = entry.value;
          final name = entry.key;

          final textColor =
              ThemeData.estimateBrightnessForColor(color) == Brightness.dark
              ? Colors.white
              : Colors.black;

          return Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${color.value32bit.toRadixString(16).toUpperCase().padLeft(8, '0')}',
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.8),
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
