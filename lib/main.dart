import 'package:flutter/material.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:ryans_weather_viewer/pages/home.dart';

import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemTheme.fallbackColor = Colors.purple;
  await SystemTheme.accentColor.load();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(
      builder: (context, accent) {
        final FlexSchemeData materialFlexScheme = FlexSchemeData(
          name: 'Material',
          description: 'Material Flex Colors.',
          light: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.light,
          ),
          dark: FlexSchemeColor.from(
            primary: accent.accent,
            brightness: Brightness.dark,
          ),
        );
        return MaterialApp(
          theme: FlexThemeData.light(
            colors: materialFlexScheme.light,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
          ),
          darkTheme: FlexThemeData.dark(
            colors: materialFlexScheme.dark,
            keyColors: const FlexKeyColors(),
            splashFactory: InkSparkle.splashFactory,
            subThemesData: const FlexSubThemesData(interactionEffects: true),
          ),
          themeMode: ThemeMode.system,
          home: Home(),
        );
      },
    );
  }
}

//
//
//
//
//
//
//
//
//

// ─────────────────────────────────────────────────────────────
// 步骤一：长按触发，用 OverlayEntry 把菜单插入屏幕最顶层
// ─────────────────────────────────────────────────────────────

class LongPressMenu extends StatefulWidget {
  final Widget child;
  final List<String> menuItems;

  const LongPressMenu({
    super.key,
    required this.child,
    required this.menuItems,
  });

  @override
  State<LongPressMenu> createState() => _LongPressMenuState();
}

class _LongPressMenuState extends State<LongPressMenu> {
  OverlayEntry? _entry;

  void _show() {
    // 步骤二：拿到当前 Widget 在屏幕上的位置
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero); // 左上角坐标
    final size = box.size;

    _entry = OverlayEntry(
      builder: (_) => MenuOverlay(
        // 把坐标和尺寸传给菜单，让它知道自己该出现在哪
        anchorRect: offset & size,
        items: widget.menuItems,
        onDismiss: _dismiss,
      ),
    );

    Overlay.of(context).insert(_entry!);
  }

  void _dismiss() {
    _entry?.remove();
    _entry = null;
  }

  @override
  void dispose() {
    _entry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onLongPress: _show, child: widget.child);
  }
}

// ─────────────────────────────────────────────────────────────
// 步骤三：Overlay 内容 = 遮罩 + 定位菜单面板
// ─────────────────────────────────────────────────────────────

class MenuOverlay extends StatefulWidget {
  final Rect anchorRect; // Card 的位置和尺寸
  final List<String> items;
  final VoidCallback onDismiss;

  const MenuOverlay({
    super.key,
    required this.anchorRect,
    required this.items,
    required this.onDismiss,
  });

  @override
  State<MenuOverlay> createState() => _MenuOverlayState();
}

class _MenuOverlayState extends State<MenuOverlay> {
  // 步骤四：用一个 bool 控制 flutter_animate 的 target
  // target: 1 = 播放动画（出现），target: 0 = 倒放（消失）
  bool _visible = true;

  Future<void> _dismiss() async {
    // 先触发关闭动画
    setState(() => _visible = false);
    // 等动画播完再移除 Overlay
    await Future.delayed(200.ms);
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    // 菜单出现在 Card 正下方，右对齐
    const menuWidth = 180.0;
    final left = widget.anchorRect.right - menuWidth;
    final top = widget.anchorRect.bottom + 4;

    return Stack(
      children: [
        // ── 遮罩层：点击关闭 ──────────────────────────────
        GestureDetector(
          onTap: _dismiss,
          child: Container(color: Colors.black26),
        ),

        // ── 菜单面板：用 Positioned 放到 Card 右下方 ────────
        Positioned(
          left: left,
          top: top,
          width: menuWidth,
          child: _MenuPanel(
            items: widget.items,
            visible: _visible,
            onItemTap: _dismiss,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 步骤五：菜单面板，用 flutter_animate 驱动动画
// ─────────────────────────────────────────────────────────────

class _MenuPanel extends StatelessWidget {
  final List<String> items;
  final bool visible; // true=出现, false=消失
  final VoidCallback onItemTap;

  const _MenuPanel({
    required this.items,
    required this.visible,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (i) {
          return InkWell(
                onTap: onItemTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(items[i]),
                ),
              )
              // ── flutter_animate：整体面板 scale + fade ─────────
              //    target 从 1→0 时动画倒放，实现关闭效果
              .animate(target: visible ? 1 : 0)
              .scale(
                begin: const Offset(0.85, 0.85), // 从 85% 缩放到 100%
                alignment: Alignment.topRight, // 缩放原点：右上角
                duration: 220.ms,
                curve: Curves.easeOut, // 轻微弹性
              )
              .fade(duration: 150.ms)
              // ── 交错效果：每个 item 延迟 40ms 出现 ───────────────
              .animate(delay: (40 * i).ms)
              .slideY(
                begin: 0.2, // 从稍微下方滑入
                duration: 200.ms,
                curve: Curves.easeOut,
              )
              .fade(duration: 180.ms);
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 演示页面：三张 Card，每张长按弹出菜单
// ─────────────────────────────────────────────────────────────

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('长按 Card 查看菜单')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('↓ 每张 Card 都可以长按', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),

          // Card A
          LongPressMenu(
            menuItems: const ['编辑', '置顶', '分享', '删除'],
            child: const Card(
              child: ListTile(
                title: Text('Card A'),
                subtitle: Text('长按我，菜单从右下角弹出'),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Card B
          LongPressMenu(
            menuItems: const ['重命名', '移动', '删除'],
            child: const Card(
              child: ListTile(
                title: Text('Card B'),
                subtitle: Text('菜单项数量不同，效果一样'),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Card C
          LongPressMenu(
            menuItems: const ['收藏', '复制链接', '举报', '不感兴趣', '屏蔽'],
            child: const Card(
              child: ListTile(
                title: Text('Card C'),
                subtitle: Text('菜单项较多时，交错动画更明显'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
