import 'package:flutter/material.dart';
import 'package:flutter_in_action_2/utils/common.dart';
import 'package:flutter_in_action_2/utils/sliver_flexible_header.dart';

class SliverFlexibleHeaderRoute extends StatefulWidget {
  const SliverFlexibleHeaderRoute({super.key});

  @override
  State<SliverFlexibleHeaderRoute> createState() =>
      _SliverFlexibleHeaderRouteState();
}

class _SliverFlexibleHeaderRouteState extends State<SliverFlexibleHeaderRoute> {
  double _initHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自定义Sliver（一）SliverFlexibleHeader')),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverFlexibleHeader(
            visibleExtent: _initHeight,
            builder: (context, availableHeight, direction) {
              return GestureDetector(
                onTap: () => print('tap'),
                child: LayoutBuilder(
                  builder: (context, cons) {
                    return Image(
                      image: const AssetImage("res/image/avatar.png"),
                      width: 50.0,
                      height: availableHeight,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                setState(() {
                  _initHeight = _initHeight == 250 ? 150 : 250;
                });
              },
              title: const Text('重置高度'),
              trailing: Text('当前高度 $_initHeight'),
            ),
          ),
          buildSliverList(30),
        ],
      ),
    );
  }
}
