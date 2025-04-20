import 'package:flutter/material.dart';

class LayoutBuilderRoute extends StatelessWidget {
  const LayoutBuilderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // return LayoutLogPrint(child:Text("xx"*20000));
    var children = List.filled(6, const Text("A"));
    // Column在本示例中在水平方向的最大宽度为屏幕的宽度
    return Scaffold(
      appBar: AppBar(title: const Text("自定义布局（LayoutBuilder）")),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 190, child: ResponsiveColumn(children: children)),
          ResponsiveColumn(children: children),
          // const LayoutLogPrint(child: Text("flutter@wendux")),
          //CustomSingleChildLayout
        ],
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          return Column(mainAxisSize: MainAxisSize.min, children: children);
        } else {
          var children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              children.add(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [children[i], children[i + 1]],
                ),
              );
            } else {
              children.add(children[i]);
            }
          }
          return Column(mainAxisSize: MainAxisSize.min, children: children);
        }
      },
    );
  }
}
