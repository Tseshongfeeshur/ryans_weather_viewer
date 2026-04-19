import 'package:flutter/material.dart';
import 'package:ryans_weather_viewer/pages/home.dart';

// 把天气代码变成文字描述
String getWeatherDescription(int wmoCode) {
  const Map<int, String> weatherDescriptions = {
    0: '晴天',
    1: '大部分晴天',
    2: '局部多云',
    3: '阴天',
    45: '雾',
    48: '雾凇',
    51: '小毛毛雨',
    53: '中毛毛雨',
    55: '大毛毛雨',
    56: '小冻毛毛雨',
    57: '大冻毛毛雨',
    61: '小雨',
    63: '中雨',
    65: '大雨',
    66: '小冻雨',
    67: '大冻雨',
    71: '小雪',
    73: '中雪',
    75: '大雪',
    77: '雪粒',
    80: '小阵雨',
    81: '中阵雨',
    82: '大阵雨',
    85: '小阵雪',
    86: '大阵雪',
    95: '雷暴',
    96: '雷暴伴有小冰雹',
    99: '雷暴伴有大冰雹',
  };

  return weatherDescriptions[wmoCode] ?? '未知天气：$wmoCode';
}

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

class WeatherCard extends StatelessWidget {
  final WeatherCardInfo item;
  final void Function(DismissDirection direction)? onDismissed;
  final bool isDragging;

  const WeatherCard({
    super.key,
    required this.item,
    this.onDismissed,
    this.isDragging = false,
  });

  @override
  Widget build(BuildContext context) {
    // 便于简短地取配色
    final colorScheme = Theme.of(context).colorScheme;

    return
    // 两侧内边距，为了滑走的部分不被切掉
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        // 栈，为了在可取消项后面叠加一个背景，用来替代组件默认的不优雅的实现
        children: [
          // Position.fill 可以铺满当前盒子
          Positioned.fill(
            child: Container(
              // 比卡片默认间距大 1px，避免背景无法被完全遮挡
              margin: EdgeInsets.all(4 + 1),
              decoration: BoxDecoration(
                color: colorScheme.error,
                borderRadius: BorderRadius.circular(999),
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: colorScheme.onError),
            ),
          ),
          // 叠在背景上的可取消项
          Dismissible(
            key: ValueKey(item.position), // 生成唯一 key
            direction:
                onDismissed !=
                    null // 若传入了取消函数
                ? DismissDirection
                      .endToStart // 则只响应左滑
                : DismissDirection.none, //否则不允许滑动
            onDismissed: onDismissed,
            child: Card.filled(
              color: isDragging
                  ? colorScheme.tertiaryContainer
                  : colorScheme.surfaceContainerHigh,
              elevation: isDragging ? 2.4 : 0.0,
              // 让圆角同时切除内容，不过暂时不用了，好像有一定性能开销
              // clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              child: InkWell(
                onTap: () {
                  // TODO: 进入对应城市的天气页面
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Ink(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Icon(
                            getWeatherIcon(item.weather.code),
                            size: 32,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(
                                item.position,
                                maxLines: 1,
                                style: TextStyle(
                                  color: isDragging
                                      ? colorScheme.tertiary
                                      : colorScheme.onSurface,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(
                                getWeatherDescription(item.weather.code),
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      (isDragging
                                              ? colorScheme.tertiary
                                              : colorScheme.onSurface)
                                          .withValues(alpha: 0.68),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Text(
                              '${item.weather.maxTemp}° ${item.weather.minTemp}°',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    (isDragging
                                            ? colorScheme.tertiary
                                            : colorScheme.onSurface)
                                        .withValues(alpha: 0.68),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          '${item.weather.currentTemp}°',
                          style: TextStyle(
                            color: isDragging
                                ? colorScheme.tertiary
                                : colorScheme.onSurface,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
