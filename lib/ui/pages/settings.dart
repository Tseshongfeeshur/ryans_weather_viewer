import 'package:flutter/material.dart';

// 内边距
final double horizontalPadding = 8;

class SettingSubtitle extends StatelessWidget {
  final String text;

  const SettingSubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Text(text),
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final GestureTapCallback onTap;
  final Widget? trailing;

  const SettingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          6,
          horizontalPadding,
          8,
        ),
        child: Text(title),
      ),
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      subtitle: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          0,
          horizontalPadding,
          12,
        ),
        child: Text(subtitle),
      ),
      subtitleTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.68),
      ),
      onTap: onTap,
      trailing: trailing,
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

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
                child: Text('设置'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SettingSubtitle(text: '常规'),
              SettingItem(
                title: '温度',
                subtitle: '摄氏度',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SettingItem(
                title: '天气单位',
                subtitle: '能见度、风速等',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SettingItem(
                title: '主题',
                subtitle: '系统默认设置',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SettingSubtitle(text: '通知'),
              SettingItem(
                title: '天气预报',
                subtitle: '每晚接收您当前所在地点的天气预报通知',
                onTap: () {
                  // TODO: 进入对应页面
                },
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              SettingItem(
                title: '降水',
                subtitle: '在降水（例如雨、雪）即将到来时接收通知',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SettingSubtitle(text: '关于'),
              SettingItem(
                title: '开发者',
                subtitle: '蒟蒻',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SettingItem(
                title: '鸣谢',
                subtitle: '为本项目提供帮助和支持的其他人',
                onTap: () {
                  // TODO: 进入对应页面
                },
              ),
              SizedBox(height: 60),
            ]),
          ),
        ],
      ),
    );
  }
}
