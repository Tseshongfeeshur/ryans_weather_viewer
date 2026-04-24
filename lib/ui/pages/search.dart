import 'package:flutter/material.dart';

class PositionItem extends StatelessWidget {
  final String name;
  final VoidCallback onPreview;
  final VoidCallback onAdd;

  const PositionItem({
    super.key,
    required this.name,
    required this.onPreview,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPreview,
      title: Text(name),
      trailing: InkWell(
        onTap: onAdd,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
            child: Icon(
              Icons.add,
              size: 18,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: '');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '搜索地点',
          ),
          autofocus: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.clear();
            },
            icon: Icon(Icons.clear),
          ),
        ],
        actionsPadding: EdgeInsets.all(0),
      ),
      body: Column(
        children: [
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 6),
              child: ListView(
                children: [
                  PositionItem(
                    name: 'Wuhan, 湖北省中国',
                    onPreview: () {
                      // TODO: 进入预览页
                    },
                    onAdd: () {
                      // TODO: 添加城市
                    },
                  ),
                  PositionItem(
                    name: '中国湖北省武汉市武昌区',
                    onPreview: () {
                      // TODO: 进入预览页
                    },
                    onAdd: () {
                      // TODO: 添加城市
                    },
                  ),
                  PositionItem(
                    name: 'Wuhan Road Residential District, 涧西区洛阳市河南省中国',
                    onPreview: () {
                      // TODO: 进入预览页
                    },
                    onAdd: () {
                      // TODO: 添加城市
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
