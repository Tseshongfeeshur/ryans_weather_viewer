import 'package:flutter/material.dart';
import 'package:njord/data/app_setting.dart';

// 内边距
final double horizontalPadding = 8;

class TemperatureSetting extends StatefulWidget {
  const TemperatureSetting({super.key});

  @override
  State<TemperatureSetting> createState() => _TemperatureSettingState();
}

class _TemperatureSettingState extends State<TemperatureSetting> {
  TemperatureUnit _selectedUnit = TemperatureUnit.celsius;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context).textTheme.copyWith(
                headlineMedium: const TextStyle(fontSize: 36),
              ),
            ),
            child: SliverAppBar.large(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text('温度'),
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final unit = TemperatureUnit.values[index];
              return RadioListTile<TemperatureUnit>(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(unit.label),
                ),
                value: unit,
                groupValue: _selectedUnit,
                onChanged: (TemperatureUnit? value) {
                  if (value != null) {
                    setState(() {
                      _selectedUnit = value;
                    });
                    // TODO: 在此处触发 Isar 数据持久化写入
                  }
                },
              );
            }, childCount: TemperatureUnit.values.length),
          ),
        ],
      ),
    );
  }
}
