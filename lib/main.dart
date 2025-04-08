import 'package:flutter/material.dart';

import 'package:flutter_in_action_2/chapter02/counter_widget.dart'
    deferred as counter_widget;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter实战（第二版）'),
      routes: routers,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var routeLists = routers.keys.toList();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(routeLists[index]);
            },
            child: Card(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: Text(routers.keys.toList()[index]),
              ),
            ),
          );
        },
        itemCount: routers.length,
      ),
    );
  }
}

class ContainerAsyncRouterPage extends StatelessWidget {
  final Future libraryFuture;

  final WidgetBuilder child;

  const ContainerAsyncRouterPage(this.libraryFuture, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: libraryFuture,
      builder: (c, s) {
        if (s.connectionState == ConnectionState.done) {
          if (s.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                alignment: Alignment.center,
                child: Text(
                  'Error: ${s.error}',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          return child.call(context);
        }
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Map<String, WidgetBuilder> routers = {
  "State生命周期": (context) {
    return ContainerAsyncRouterPage(counter_widget.loadLibrary(), (context) {
      return counter_widget.CounterWidget();
    });
  },
};
