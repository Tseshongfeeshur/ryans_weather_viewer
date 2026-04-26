import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// 工具
import 'package:ryans_weather_viewer/ui/utils/get_weather_desc.dart';
import 'package:ryans_weather_viewer/ui/utils/get_weather_icon.dart';
import 'package:ryans_weather_viewer/data/location.dart';
import 'package:geolocator/geolocator.dart';

// 页面
import 'package:ryans_weather_viewer/ui/pages/settings.dart';
import 'package:ryans_weather_viewer/ui/pages/search.dart';
import 'package:ryans_weather_viewer/ui/pages/weather.dart';
import 'package:ryans_weather_viewer/ui/test/color_scheme.dart';

/// 一单位 天气 的数据结构
class _WeatherData {
  final int code;
  final int currentTemp;
  final int maxTemp;
  final int minTemp;

  _WeatherData({
    required this.code,
    required this.currentTemp,
    required this.maxTemp,
    required this.minTemp,
  });
}

/// 一单位 天气预览卡信息 的数据结构
class _WeatherCardInfo {
  final String position;
  final _WeatherData weather;

  _WeatherCardInfo(this.position, this.weather);
}

/// 位置服务权限请求卡
class _RequirePositionAccessCard extends StatelessWidget {
  /// 显示用于请求权限的底部弹出栏
  Future<dynamic> showPositionAccessRequireBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 26,
            bottom: 48,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 26),
                child: Text('获取最新天气信息', style: TextStyle(fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '如需接收您当前所在位置的最新天气资讯，请允许“Ryan\'s Weather Viewer”应用访问精确位置信息。',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight(380),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '“Ryan\'s Weather Viewer”应用会收集位置数据，以便在应用关闭或不使用时也能提供本地实时天气预报。',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight(380),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('取消'),
                    ),
                  ),
                  FilledButton(
                    onPressed: () async {
                      final int code = await getPositionAccess();
                      if (!context.mounted) return;
                      final shouldCheckAccessAgainToUpdateState =
                          await showNextPositionAccessRequireDialog(
                            context,
                            code,
                          );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      if (shouldCheckAccessAgainToUpdateState == true) {
                        getPositionAccess();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text('继续'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> showNextPositionAccessRequireDialog(
    BuildContext context,
    int code,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
              bottom: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '需要位置信息访问权限',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '如需获取您当前所在位置的天气预报，请将位置信息权限更新为“始终允许”和“使用精确位置”',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight(350),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text("取消"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                        if (code == 1) {
                          await Geolocator.openLocationSettings();
                        } else if (code == 2) {
                          getPositionAccess();
                        } else if (code == 3) {
                          await Geolocator.openAppSettings();
                        } else {
                          await Geolocator.openAppSettings();
                        }
                      },
                      child: Text("更新权限"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        child: InkWell(
          onTap: () {
            showPositionAccessRequireBottomSheet(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              children: [
                Icon(
                  Icons.my_location,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                SizedBox(width: 24),
                Text(
                  '更新位置信息权限',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight(450),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 天气预览卡
class _WeatherCard extends StatelessWidget {
  final _WeatherCardInfo item;
  final void Function(DismissDirection direction)? onDismissed;
  final bool isDragging;
  final VoidCallback? onTap;

  const _WeatherCard({
    // super.key,
    required this.item,
    this.onDismissed,
    this.isDragging = false,
    this.onTap,
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
              // 让圆角同时切除内容，好像有一定性能开销？
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              child: InkWell(
                onTap: onTap,
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
                                  fontWeight: FontWeight(450),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text(
                                getWeatherDesc(item.weather.code),
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
                            ),
                            Text(
                              '${item.weather.maxTemp}° ${item.weather.minTemp}°',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                            fontWeight: FontWeight.w500,
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

/// 小标题
class ListSubtitle extends StatelessWidget {
  final IconData icon;
  final String text;

  const ListSubtitle({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(right: 8), child: Icon(icon)),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight(450)),
          ),
        ],
      ),
    );
  }
}

/// 主页
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// 要显示的数据作为状态
class _HomeState extends State<Home> {
  // 占位数据
  final _WeatherCardInfo _dataCurrent = _WeatherCardInfo(
    '大同市平城区',
    _WeatherData(code: 2, currentTemp: 13, maxTemp: 17, minTemp: 3),
  );
  final List<_WeatherCardInfo> _dataList = [
    _WeatherCardInfo(
      '大同市平城区',
      _WeatherData(code: 2, currentTemp: 13, maxTemp: 17, minTemp: 3),
    ),
    _WeatherCardInfo(
      '小店区',
      _WeatherData(code: 0, currentTemp: 20, maxTemp: 22, minTemp: 8),
    ),
    _WeatherCardInfo(
      '海淀区',
      _WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
    ),
    _WeatherCardInfo(
      '海淀2区',
      _WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
    ),
    _WeatherCardInfo(
      '海淀3区',
      _WeatherData(code: 53, currentTemp: 12, maxTemp: 12, minTemp: 7),
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
            child: ListSubtitle(icon: Icons.my_location, text: '当前位置'),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _WeatherCard(
                  item: _dataCurrent,
                  isDragging: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Weather()),
                    );
                  },
                ),
                _RequirePositionAccessCard(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ListSubtitle(icon: Icons.location_on, text: '保存的地点'),
          ),
          SliverReorderableList(
            itemCount: _dataList.length,
            itemBuilder: (context, index) {
              final item = _dataList[index];

              return ReorderableDelayedDragStartListener(
                key: ValueKey(item.position), // 生成唯一 key
                index: index,
                child: _WeatherCard(
                  item: item,
                  onDismissed: (direction) {
                    // UI 被取消后同步取消数据
                    setState(() {
                      _dataList.removeAt(index);
                    });
                  },
                  onTap: () {
                    // 进入天气页面
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
                final _WeatherCardInfo item = _dataList.removeAt(oldIndex);
                _dataList.insert(newIndex, item);
              });
            },
            onReorderStart: (oldIndex) {
              HapticFeedback.vibrate();
              // setState(() {});
            },
            onReorderEnd: (newIndex) {
              // setState(() {});
            },
            proxyDecorator: (child, index, animation) {
              return Material(
                color: Colors.transparent, // 必须包裹 Material
                child: Column(
                  children: [
                    _WeatherCard(
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          );
        },
      ),
    );
  }
}
