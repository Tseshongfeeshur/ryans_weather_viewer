import 'dart:ui';
import 'package:isar/isar.dart';
import 'package:njord/data/app_setting.dart'; // 模型

class SettingsDbService {
  final Isar isar;

  SettingsDbService(this.isar);

  /// 初始化
  Future<AppSetting> getOrInitSettings() async {
    AppSetting? settings = await isar.appSettings.get(0);

    if (settings != null) {
      return settings;
    }

    // 首次启动推断
    settings = _createInitialSettingsByRegion();

    await isar.writeTxn(() async {
      await isar.appSettings.put(settings!);
    });

    return settings;
  }

  /// 监听设置变化，用于 UI 响应式刷新
  Stream<AppSetting> watchSettings() {
    return isar.appSettings
        .watchObject(0, fireImmediately: true)
        .map((s) => s ?? AppSetting());
  }

  /// 更新设置的通用工具函数
  Future<void> updateSettings(Function(AppSetting settings) builder) async {
    final settings = await getOrInitSettings();
    builder(settings);

    await isar.writeTxn(() async {
      await isar.appSettings.put(settings);
    });
  }

  /// 根据地区推断默认值
  AppSetting _createInitialSettingsByRegion() {
    final settings = AppSetting();

    try {
      final locale = PlatformDispatcher.instance.locale;
      final countryCode = locale.countryCode?.toUpperCase();

      const usSystemCountries = {'US', 'MM', 'LR', 'BS', 'BZ', 'KY', 'PW'};

      if (countryCode != null && usSystemCountries.contains(countryCode)) {
        settings.tempUnit = TemperatureUnit.fahrenheit;
        settings.weatherUnits = WeatherUnits.defaultImperial;
      }
    } catch (_) {
      // 出现异常时保持公制默认值
    }

    return settings;
  }
}
