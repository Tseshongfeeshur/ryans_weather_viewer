import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:ryans_weather_viewer/pages/utils/weather_card.dart';
import 'package:ryans_weather_viewer/pages/utils/list_title.dart';

import 'package:ryans_weather_viewer/pages/settings.dart';
import 'package:ryans_weather_viewer/test/color_scheme.dart';

// 一单位 天气 的数据结构
class WeatherData {
  final int code;
  final int currentTemp;
  final int maxTemp;
  final int minTemp;

  WeatherData({
    required this.code,
    required this.currentTemp,
    required this.maxTemp,
    required this.minTemp,
  });
}

// 一单位 天气预览卡信息 的数据结构
class WeatherCardInfo {
  final String position;
  final WeatherData weather;

  WeatherCardInfo(this.position, this.weather);
}

// 主页
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// 要显示的数据作为状态
class _HomeState extends State<Home> {
  // 占位数据
  final WeatherCardInfo _dataCurrent = WeatherCardInfo(
    '大同市平城区',
    WeatherData(code: 2, currentTemp: 13, maxTemp: 17, minTemp: 3),
  );
  final List<WeatherCardInfo> _dataList = [
    WeatherCardInfo(
      '大同市平城区',
      WeatherData(code: 2, currentTemp: 13, maxTemp: 17, minTemp: 3),
    ),
    WeatherCardInfo(
      '小店区',
      WeatherData(code: 0, currentTemp: 20, maxTemp: 22, minTemp: 8),
    ),
    WeatherCardInfo(
      '海淀区',
      WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
    ),
    WeatherCardInfo(
      '海淀2区',
      WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
    ),
    WeatherCardInfo(
      '海淀3区',
      WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorSchemeDebugger()),
            );
          },
          child: const Text('天气'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 顶部间距
          SliverToBoxAdapter(child: Padding(padding: EdgeInsets.only(top: 6))),
          SliverToBoxAdapter(
            child: ListTitle(icon: Icons.my_location, text: '当前位置'),
          ),
          SliverToBoxAdapter(
            child: WeatherCard(item: _dataCurrent, isDragging: false),
          ),
          SliverToBoxAdapter(
            child: ListTitle(icon: Icons.location_on, text: '保存的地点'),
          ),
          SliverReorderableList(
            itemCount: _dataList.length,
            itemBuilder: (context, index) {
              // TODO: 菜单
              final item = _dataList[index];

              return ReorderableDelayedDragStartListener(
                key: ValueKey(item.position), // 生成唯一 key
                index: index,
                child: WeatherCard(
                  item: item,
                  onDismissed: (direction) {
                    // UI 被取消后同步取消数据
                    setState(() {
                      _dataList.removeAt(index);
                    });
                  },
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                // 如果往后拖，newIndex 会多算一个位移
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                // 先移除再插入
                final WeatherCardInfo item = _dataList.removeAt(oldIndex);
                _dataList.insert(newIndex, item);
              });
            },
            onReorderStart: (oldIndex) {
              HapticFeedback.vibrate();
              setState(() {});
            },
            onReorderEnd: (newIndex) {
              setState(() {});
            },
            proxyDecorator: (child, index, animation) {
              return Material(
                color: Colors.transparent, // 必须包裹 Material
                child: Column(
                  children: [
                    WeatherCard(
                      item: _dataList[index],
                      onDismissed: (direction) {
                        // UI 被取消后同步取消数据
                        setState(() {
                          _dataList.removeAt(index);
                        });
                      },
                      isDragging: true,
                    ),
                  ],
                ),
              );
            },
          ),
          // 底部间距
          SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.only(top: 160)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(Icons.search),
        onPressed: () {
          // TODO: 进入搜索界面
        },
      ),
    );
  }
}
