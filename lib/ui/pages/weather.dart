import 'package:flutter/material.dart';

// 工具
import 'package:ryans_weather_viewer/ui/utils/get_date_from_period.dart';

// 插件
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

// 最上面天气概览
class _WeatherOverview extends StatelessWidget {
  final Icon icon;
  final String desc;
  final int temp;
  final int bodyTemp;
  final int topTemp;
  final int bottomTemp;

  const _WeatherOverview({
    required this.icon,
    required this.desc,
    required this.temp,
    required this.bodyTemp,
    required this.topTemp,
    required this.bottomTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 26, 18, 38),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.only(right: 14), child: icon),
              Text(desc, style: TextStyle(fontSize: 22)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '°',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w700,
                  color: Colors.transparent,
                ),
              ),
              Text(
                '$temp',
                style: TextStyle(fontSize: 120, fontWeight: FontWeight.w500),
              ),
              Text(
                '°',
                style: TextStyle(fontSize: 100, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text('体感温度：$bodyTemp°', style: TextStyle(fontSize: 22)),
          ),
          Text(
            '最高 $topTemp° · 最低 $bottomTemp°',
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

// 卡套
class _DetailCard extends StatelessWidget {
  final Widget child;

  const _DetailCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: child,
      ),
    );
  }
}

// 普通信息展示卡
class _StaticWeatherCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String text;

  const _StaticWeatherCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 8), child: icon),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight(450)),
                  ),
                ],
              ),
            ),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// 横向滚动信息展示卡
class _ScrollableWeatherCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final double innerHeight;
  final List<Widget> children;

  const _ScrollableWeatherCard({
    required this.icon,
    required this.title,
    this.innerHeight = 100,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 8), child: icon),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight(450),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {},
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_left,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {},
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.arrow_right,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: innerHeight,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 每小时天气预报滚动卡里面的磁贴
class _WeatherPerHourTile extends StatelessWidget {
  final int temp;
  final Icon icon;
  final int happenRate;
  final int hour;

  const _WeatherPerHourTile({
    required this.temp,
    required this.icon,
    this.happenRate = 0,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$temp°'),
          icon,
          Text(happenRate == 0 ? '' : '$happenRate%'),
          Text('${hour.toString().padLeft(2, '0')}:00'),
        ],
      ),
    );
  }
}

// 未来 10 天天气预报滚动卡里面的磁贴
class _WeatherFutureDayTile extends StatelessWidget {
  final int topTemp;
  final int bottomTemp;
  final Icon icon;
  final int happenRate;
  final int daysFromNow;

  const _WeatherFutureDayTile({
    required this.topTemp,
    required this.bottomTemp,
    required this.icon,
    required this.happenRate,
    required this.daysFromNow,
  });

  @override
  Widget build(BuildContext context) {
    final dateInfo = getDateFromPeriod(daysFromNow);

    return Padding(
      padding: const EdgeInsets.only(top: 6, right: 3),
      child: SizedBox(
        width: 60,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: 1.6,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('$topTemp°'),
                    Text(
                      '$bottomTemp°',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                icon,
                Text(happenRate == 0 ? '' : '$happenRate%'),
                Column(
                  children: [
                    Text(
                      dateInfo.weekday,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface
                            .withValues(alpha: daysFromNow == 0 ? 1 : 0.7),
                      ),
                    ),
                    Text(
                      dateInfo.date,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 小卡片
// class _RainfallMiniCard extends StatelessWidget {
// }

// 天气页
class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    const overview = ReorderableStaggeredScrollViewGridExtentItem(
      key: ValueKey('value'),
      mainAxisExtent: 341,
      crossAxisCellCount: 2,
      widget: _WeatherOverview(
        icon: Icon(Icons.cloud_outlined, size: 28),
        desc: '局部多云',
        temp: 16,
        bodyTemp: 16,
        topTemp: 18,
        bottomTemp: 3,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: Text('大同市平城区', style: TextStyle(fontWeight: FontWeight(450))),
        backgroundColor: Colors.transparent,
      ),
      body: ReorderableStaggeredScrollView.grid(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        crossAxisCount: 2,
        draggingWidgetOpacity: 0.3,
        edgeScroll: 0.1,
        edgeScrollSpeedMilliseconds: 400,
        isNotDragList: [overview],
        children: [
          overview,
          ReorderableStaggeredScrollViewGridExtentItem(
            key: ValueKey('天气分析'),
            mainAxisExtent: 115,
            crossAxisCellCount: 2,
            widget: _StaticWeatherCard(
              icon: Icon(Icons.show_chart),
              title: '天气分析',
              text: '预计未来 2 天会升温',
            ),
          ),
          ReorderableStaggeredScrollViewGridExtentItem(
            key: ValueKey('每小时天气预报'),
            mainAxisExtent: 212,
            crossAxisCellCount: 2,
            widget: _ScrollableWeatherCard(
              icon: Icon(Icons.access_time_outlined),
              title: '每小时天气预报',
              innerHeight: 120,
              children: List.generate(
                24,
                (index) => _WeatherPerHourTile(
                  temp: 16 + index,
                  icon: Icon(Icons.cloud_outlined),
                  happenRate: 10,
                  hour: index,
                ),
              ),
            ),
          ),
          ReorderableStaggeredScrollViewGridExtentItem(
            key: ValueKey('未来 10 天天气预报'),
            mainAxisExtent: 288,
            crossAxisCellCount: 2,
            widget: _ScrollableWeatherCard(
              icon: Icon(Icons.date_range),
              title: '未来 10 天天气预报',
              innerHeight: 196,
              children: List.generate(
                10,
                (index) => _WeatherFutureDayTile(
                  topTemp: 15 + index,
                  bottomTemp: 5 + index,
                  icon: Icon(Icons.cloud_outlined),
                  happenRate: 10,
                  daysFromNow: index,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
