import 'package:flutter/material.dart';

class Page {
  Page(
    this.title,
    Widget child, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  }) : builder = ((_) => child);

  Page.builder(
    this.title,
    this.builder, {
    this.withScaffold = true,
    this.padding = true,
    this.showLog = false,
  });

  String title;
  WidgetBuilder builder;
  bool withScaffold;
  bool padding;
  bool showLog;

  Widget build(BuildContext context) {
    Widget widget = builder(context);
    if (withScaffold) {
      widget = Scaffold(appBar: AppBar(title: Text(title)), body: widget);
    }
    // if (withScaffold) {
    //   widget = PageScaffold(
    //     title: title,
    //     padding: padding,
    //     showLog: showLog,
    //     body: widget,
    //   );
    //   widget = LogListenerScope(
    //     child: widget,
    //     logEmitter: getGlobalLogEmitter(),
    //   );
    // } else if (showLog) {
    //   widget = VerticalLogPanel(child: widget);
    //   widget = LogListenerScope(
    //     child: widget,
    //     logEmitter: getGlobalLogEmitter(),
    //   );
    // }
    return widget;
  }

  Future<T?> openPage<T>(BuildContext context) {
    return Navigator.push<T>(context, MaterialPageRoute<T>(builder: build));
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key, required this.children});

  final List<Page> children;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _generateItem(context));
  }

  List<Widget> _generateItem(BuildContext context) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openPage(context),
      );
    }).toList();
  }
}
