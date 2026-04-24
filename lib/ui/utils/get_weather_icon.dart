import 'package:flutter/material.dart';

// 把天气代码变成图标（临时，后续用 LottieFiles 代替）
IconData getWeatherIcon(int wmoCode) {
  const Map<int, IconData> weatherIcons = {
    0: Icons.wb_sunny, // 晴天
    1: Icons.wb_cloudy_outlined, // 大部分晴天
    2: Icons.cloud_outlined, // 局部多云
    3: Icons.cloud, // 阴天
    45: Icons.cloud_queue, // 雾 (或使用 blur_on)
    48: Icons.ac_unit, // 雾凇
    51: Icons.grain, // 小毛毛雨
    53: Icons.grain, // 中毛毛雨
    55: Icons.grain, // 大毛毛雨
    56: Icons.ac_unit, // 小冻毛毛雨
    57: Icons.ac_unit, // 大冻毛毛雨
    61: Icons.umbrella, // 小雨
    63: Icons.water_drop, // 中雨
    65: Icons.opacity, // 大雨
    66: Icons.ac_unit, // 小冻雨
    67: Icons.ac_unit, // 大冻雨
    71: Icons.snowing, // 小雪
    73: Icons.snowing, // 中雪
    75: Icons.ac_unit, // 大雪
    77: Icons.severe_cold, // 雪粒
    80: Icons.umbrella, // 小阵雨
    81: Icons.water_drop, // 中阵雨
    82: Icons.tsunami, // 大阵雨 (极端降雨)
    85: Icons.snowing, // 小阵雪
    86: Icons.ac_unit, // 大阵雪
    95: Icons.thunderstorm, // 雷暴
    96: Icons.thunderstorm, // 雷暴伴有小冰雹
    99: Icons.thunderstorm, // 雷暴伴有大冰雹
  };

  // 如果没有匹配到，返回一个默认的疑问图标
  return weatherIcons[wmoCode] ?? Icons.help_outline;
}
