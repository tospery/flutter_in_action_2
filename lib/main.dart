import 'dart:async';
import 'package:flutter/material.dart' hide Page;
import 'package:hi_case/hi_case.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'common.dart';
import 'routes.dart';
import 'chapter14/draw_main.dart' as custom;

void main() {
  // custom.main();
  runZoned(
    () => runApp(const MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, line);
        // Intercept `print` function and redirect log.
        logEmitter.value = LogInfo(false, line);
      },
      handleUncaughtError: (
        Zone self,
        ZoneDelegate parent,
        Zone zone,
        Object error,
        StackTrace stackTrace,
      ) {
        parent.print(zone, '${error.toString()} $stackTrace');
        // Redirect error log event when error.
        logEmitter.value = LogInfo(true, error.toString());
      },
    ),
  );

  var onError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    // Redirect error log event when error.
    logEmitter.value = LogInfo(true, details.toString());
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //platform: TargetPlatform.android,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _generateItem(BuildContext context, List<Case> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openCase(context),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter实战')),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: const Text("第一个Flutter应用"),
            children: _generateItem(context, [
              Case("计数器", const CounterRoute(), withScaffold: false),
              Case("路由传值", const RouterTestRoute()),
              Case("State生命周期", const StateLifecycleTest()),
              Case(
                "子树中获取State对象",
                const GetStateObjectRoute(),
                withScaffold: false,
              ),
              Case(
                "Cupertino Demo",
                const CupertinoTestRoute(),
                withScaffold: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("基础组件"),
            children: _generateItem(context, [
              // PageInfo("Context测试",  ContextRoute(), withScaffold: false),
              // PageInfo("Widget树中获取State对象",  RetrieveStateRoute(), withScaffold: false),
              Case("文本、字体样式", const TextRoute()),
              Case("按钮", const ButtonRoute()),
              Case("图片伸缩", const ImageAndIconRoute()),
              Case("ICON fonts", const IconFontsRoute()),
              Case("单选开关和复选框", const SwitchAndCheckBoxRoute()),
              Case("输入框", const FocusTestRoute(), showLog: false),
              Case("Form", const FormTestRoute(), showLog: false),
              Case("进度条", const ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("布局类组件"),
            children: _generateItem(context, [
              Case("约束", const SizeConstraintsRoute(), withScaffold: false),
              Case("Column居中", const CenterColumnRoute()),
              Case("流式布局", const WrapAndFlowRoute()),
              Case("层叠布局", const StackRoute()),
              Case("表格布局", const TableRoute()),
              Case("对齐及相对定位", const AlignRoute()),
              Case("LayoutBuilder", const LayoutBuilderRoute(), padding: false),
              Case("AfterLayout", const AfterLayoutRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("容器类组件"),
            children: _generateItem(context, [
              Case("填充Padding", const PaddingTestRoute()),
              Case("DecoratedBox", const DecoratedBoxRoute()),
              Case("变换", const TransformRoute()),
              Case("Container", const ContainerRoute()),
              Case("FittedBox", const FittedBoxRoute()),
              Case("剪裁", const ClipRoute()),
              Case(
                "Scaffold、TabBar、底部导航",
                const ScaffoldRoute(),
                withScaffold: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("可滚动组件"),
            children: _generateItem(context, [
              Case(
                "SingleChildScrollView",
                const SingleChildScrollViewTestRoute(),
                padding: false,
              ),
              Case(
                "InfiniteListView",
                const InfiniteListView(),
                padding: false,
              ),
              Case("可滚动组件的通用配置", const ScrollViewConfiguration()),
              Case("列表项固定高度列表", const FixedExtentList(), padding: false),
              Case("AnimatedList", const AnimatedListRoute(), padding: false),
              Case(
                "InfiniteGridView",
                const InfiniteGridView(),
                padding: false,
              ),
              Case("PageView", const PageViewTest(), padding: false),
              Case("KeepAlive Test", const KeepAliveTest(), padding: false),
              Case("TabBarView", const TabViewRoute()),
              Case("滚动监听", const ScrollNotificationTestRoute(), padding: false),
              Case(
                "CustomScrollView",
                const CustomScrollViewTestRoute(),
                padding: false,
                showLog: false,
              ),
              Case(
                "PersistentHeaderRoute",
                const PersistentHeaderRoute(),
                padding: false,
                showLog: false,
              ),
              Case(
                "SliverPersistentHeaderToBox",
                const SliverPersistentHeaderToBoxRoute(),
                padding: false,
              ),
              Case(
                "SliverFlexibleHeader",
                const SliverFlexibleHeaderRoute(),
                padding: false,
              ),
              Case(
                "NestedScrollView",
                const NestedScrollViewRoute(),
                padding: false,
              ),
              Case("PullRefresh", const PullRefreshTestRoute(), padding: false),
              Case(
                "CustomPullRefresh",
                const PullRefreshBoxRoute(),
                padding: false,
              ),
              //PageInfo("pullrefresh",  PullRefreshRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("功能性组件"),
            children: _generateItem(context, [
              Case("导航返回拦截", const WillPopScopeTestRoute()),
              Case("数据共享(inheritedWidget)", const InheritedWidgetTestRoute()),
              Case("跨组件状态管理(Provider)", const ProviderRoute()),
              Case("颜色和MaterialColor", const ColorRoute(), withScaffold: false),
              Case("主题-Theme", const ThemeTestRoute(), withScaffold: false),
              Case(
                "ValueListenableBuilder",
                const ValueListenableRoute(),
                withScaffold: false,
              ),
              Case(
                "FutureBuilder和StreamBuilder",
                const FutureAndStreamBuilderRoute(),
              ),
              Case("对话框", const DialogTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("事件处理与通知"),
            children: _generateItem(context, [
              Case("原生指针事件", const PointerRoute(), padding: false),
              Case("手势识别", const GestureRoute(), padding: false),
              Case("PointerDownListener", const PointerDownListenerRoute()),
              Case(
                "Stack 点击测试",
                const StackEventTest(),
                padding: false,
                showLog: false,
              ),
              Case("通知(Notification)", const NotificationRoute()),
              Case("事件冲突", const EventConflictTest()),
            ]),
          ),
          ExpansionTile(
            title: const Text("动画"),
            children: _generateItem(context, [
              Case("放大动画-原始版", const ScaleAnimationRoute()),
              Case("放大动画-AnimatedWidget版", const ScaleAnimationRoute1()),
              Case("放大动画-AnimatedBuilder版", const ScaleAnimationRoute2()),
              Case("放大动画-GrowTransition版", const GrowTransitionRoute()),
              Case("Hero动画", const HeroAnimationRoute(), padding: false),
              Case("交织动画(Stagger Animation)", const StaggerRoute()),
              Case(
                "动画切换组件(AnimatedSwitcher)",
                const AnimatedSwitcherCounterRoute(),
              ),
              Case("动画切换组件高级用法", const AnimatedSwitcherRoute()),
              Case("动画过渡组件", const AnimatedWidgetsTest()),
            ]),
          ),
          ExpansionTile(
            title: const Text("自定义组件"),
            children: _generateItem(context, [
              Case("GradientButton", const GradientButtonRoute()),
              Case("Material APP", const ScaffoldRoute(), withScaffold: false),
              Case("旋转容器：TurnBox", const TurnBoxRoute()),
              Case("CustomPaint", const CustomPaintRoute()),
              Case("自绘控件：圆形渐变进度条", const GradientCircularProgressRoute()),
              Case("自绘带动画控件：CustomCheckBox", const CustomCheckboxTest()),
              Case("自绘带动画控件：DoneWidget", const DoneWidgetTestRoute()),
              Case(
                "水印",
                const WatermarkRoute(),
                padding: false,
                showLog: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("文件与网络"),
            children: _generateItem(context, [
              Case("文件操作", FileOperationRoute(), withScaffold: false),
              Case("Http请求", HttpTestRoute()),
              Case("WebSocket", WebSocketRoute(), withScaffold: false),
              Case("Socket", const SocketRoute()),
            ]),
          ),
          ExpansionTile(
            title: const Text("其它"),
            children: _generateItem(context, [
              Case(
                "WebView",
                const WebViewTest(),
                padding: false,
                withScaffold: false,
                //showLog: false,
              ),
            ]),
          ),
          ExpansionTile(
            title: const Text("Flutter原理"),
            children: _generateItem(context, [
              Case("图片加载原理与缓存", ImageInternalTestRoute()),
              Case("CustomCenter", const MyCenterRoute()),
              Case("LeftRightBox", const LeftRightBoxTestRoute()),
              Case("约束详解", const ConstraintsTest(), withScaffold: false),
              Case("AccurateSizedBox", const AccurateSizedBoxRoute()),
              Case("StateChangeTest", const StateChangeTest()),
              Case("RepaintBoundary", const RepaintBoundaryTest()),
              Case("CompositingBits Test", const CustomRotatedBoxTest()),
              Case("Paint原理", const PaintTest()),
            ]),
          ),

          // ExpansionTile(
          //   title: Text("包与插件"),
          //   children: _generateItem(context, [
          //     PageInfo("相机",  CameraExampleHome(),
          //         withScaffold: false),
          //     PageInfo(
          //         "PlatformView示例（webview）",  PlatformViewRoute(),
          //         padding: false),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
