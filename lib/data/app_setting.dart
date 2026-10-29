import 'package:isar/isar.dart';

part 'app_setting.g.dart';

// 温度单位
enum TemperatureUnit {
  celsius('摄氏度（℃）'),
  fahrenheit('华氏度（℉）');

  final String label;
  const TemperatureUnit(this.label);
}

// 降水量 / 降雪量单位
enum RainfallUnit {
  inchForAll('英寸（雨/雪）'),
  centimeterForAll('厘米（雨/雪）'),
  millimeterForRainAndCentimeterForSnow('毫米（雨）\n厘米（雪）');

  final String label;
  const RainfallUnit(this.label);
}

// 风速单位
enum WindSpeedUnit {
  metersPerSecond('每秒米数'),
  kilometersPerHour('每小时公里数'),
  milesPerHour('每小时英里数'),
  knots('节');

  final String label;
  const WindSpeedUnit(this.label);
}

// 气压单位
enum PressureUnit {
  hPa('百帕'),
  mbar('毫巴'),
  mmHg('毫米汞柱'),
  inHg('英寸汞柱');

  final String label;
  const PressureUnit(this.label);
}

// 能见度单位
enum VisibilityUnit {
  metric('米/公里'),
  imperial('英尺/英里');

  final String label;
  const VisibilityUnit(this.label);
}

@embedded
class WeatherUnits {
  @enumerated
  RainfallUnit rainfall = RainfallUnit.millimeterForRainAndCentimeterForSnow;

  @enumerated
  WindSpeedUnit windSpeed = WindSpeedUnit.kilometersPerHour;

  @enumerated
  PressureUnit pressure = PressureUnit.hPa;

  @enumerated
  VisibilityUnit visibility = VisibilityUnit.metric;

  // 构造函数
  WeatherUnits({
    this.rainfall = RainfallUnit.millimeterForRainAndCentimeterForSnow,
    this.windSpeed = WindSpeedUnit.kilometersPerHour,
    this.pressure = PressureUnit.hPa,
    this.visibility = VisibilityUnit.metric,
  });

  WeatherUnits copyWith({
    RainfallUnit? rainfall,
    WindSpeedUnit? windSpeed,
    PressureUnit? pressure,
    VisibilityUnit? visibility,
  }) {
    return WeatherUnits(
      rainfall: rainfall ?? this.rainfall, // 如果传了新值就用新值，没传就保留原来的值
      windSpeed: windSpeed ?? this.windSpeed,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
    );
  }

  static WeatherUnits get defaultMetric => WeatherUnits();
  static WeatherUnits get defaultImperial => WeatherUnits(
    rainfall: RainfallUnit.inchForAll,
    windSpeed: WindSpeedUnit.milesPerHour,
    pressure: PressureUnit.inHg,
    visibility: VisibilityUnit.imperial,
  );
}

enum ThemeColor { light, dark, auto }

@collection
class AppSetting {
  Id id = 0;

  // 温度单位
  @enumerated
  TemperatureUnit tempUnit = TemperatureUnit.celsius;

  // 其他天气单位
  WeatherUnits weatherUnits = WeatherUnits();

  // 配色方案
  @enumerated
  ThemeColor theme = ThemeColor.auto;

  // 是否每晚接受天气预报通知
  bool notifyNightlyForecast = true;

  // 是否在降水即将到来时接受通知
  bool notifyRainfall = true;
}
