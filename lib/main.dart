import 'package:flutter/material.dart';

import 'package:flutter_in_action_2/chapter02/state_lifecycle_test_route.dart'
    deferred as state_lifecycle_test_route;
import 'package:flutter_in_action_2/chapter02/get_state_object_route.dart'
    deferred as get_state_object_route;
import 'package:flutter_in_action_2/chapter02/cupertino_test_route.dart'
    deferred as cupertino_test_route;
import 'package:flutter_in_action_2/chapter02/router_test_route.dart'
    deferred as router_test_route;
import 'package:flutter_in_action_2/chapter03/text_route.dart'
    deferred as text_route;
import 'package:flutter_in_action_2/chapter03/button_route.dart'
    deferred as button_route;
import 'package:flutter_in_action_2/chapter03/image_and_icon_route.dart'
    deferred as image_and_icon_route;
import 'package:flutter_in_action_2/chapter03/icon_fonts_route.dart'
    deferred as icon_fonts_route;
import 'package:flutter_in_action_2/chapter03/switch_and_checkbox_route.dart'
    deferred as switch_and_checkbox_route;
import 'package:flutter_in_action_2/chapter03/focus_test_route.dart'
    deferred as focus_test_route;
import 'package:flutter_in_action_2/chapter03/form_test_route.dart'
    deferred as form_test_route;
import 'package:flutter_in_action_2/chapter03/progress_route.dart'
    deferred as progress_route;
import 'package:flutter_in_action_2/chapter04/size_constraints_route.dart'
    deferred as size_constraints_route;
import 'package:flutter_in_action_2/chapter04/center_column_route.dart'
    deferred as center_column_route;
import 'package:flutter_in_action_2/chapter04/wrap_and_flow_route.dart'
    deferred as wrap_and_flow_route;
import 'package:flutter_in_action_2/chapter04/stack_route.dart'
    deferred as stack_route;
import 'package:flutter_in_action_2/chapter04/align_route.dart'
    deferred as align_route;
import 'package:flutter_in_action_2/chapter04/layout_builder_route.dart'
    deferred as layout_builder_route;
import 'package:flutter_in_action_2/chapter04/after_layout_route.dart'
    deferred as after_layout_route;
import 'package:flutter_in_action_2/chapter05/padding_test_route.dart'
    deferred as padding_test_route;
import 'package:flutter_in_action_2/chapter05/decorated_box_route.dart'
    deferred as decorated_box_route;
import 'package:flutter_in_action_2/chapter05/transform_route.dart'
    deferred as transform_route;
import 'package:flutter_in_action_2/chapter05/container_route.dart'
    deferred as container_route;
import 'package:flutter_in_action_2/chapter05/clip_route.dart'
    deferred as clip_route;
import 'package:flutter_in_action_2/chapter05/fitted_box_route.dart'
    deferred as fitted_box_route;
import 'package:flutter_in_action_2/chapter05/scaffold_route.dart'
    deferred as scaffold_route;
import 'package:flutter_in_action_2/chapter06/single_child_scrollview_test_route.dart'
    deferred as single_child_scrollview_test_route;
import 'package:flutter_in_action_2/chapter06/fixed_extent_list.dart'
    deferred as fixed_extent_list;
import 'package:flutter_in_action_2/chapter06/infinite_listview.dart'
    deferred as infinite_listview;
import 'package:flutter_in_action_2/chapter06/scroll_notification_test_route.dart'
    deferred as scroll_notification_test_route;
import 'package:flutter_in_action_2/chapter06/animated_list_route.dart'
    deferred as animated_list_route;
import 'package:flutter_in_action_2/chapter06/infinite_gridview.dart'
    deferred as infinite_gridview;
import 'package:flutter_in_action_2/chapter06/pageview_test.dart'
    deferred as pageview_test;
import 'package:flutter_in_action_2/chapter06/keep_alive_test.dart'
    deferred as keep_alive_test;
import 'package:flutter_in_action_2/chapter06/tabview_route.dart'
    deferred as tabview_route;
import 'package:flutter_in_action_2/chapter06/custom_scrollview_test_route.dart'
    deferred as custom_scrollview_test_route;
import 'package:flutter_in_action_2/chapter06/persistent_header_route.dart'
    deferred as persistent_header_route;

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
    return ContainerAsyncRouterPage(state_lifecycle_test_route.loadLibrary(), (
      context,
    ) {
      return state_lifecycle_test_route.StateLifecycleTestRoute();
    });
  },
  "在widget树中获取State对象": (context) {
    return ContainerAsyncRouterPage(get_state_object_route.loadLibrary(), (
      context,
    ) {
      return get_state_object_route.GetStateObjectRoute();
    });
  },
  "一个简单的Cupertino组件": (context) {
    return ContainerAsyncRouterPage(cupertino_test_route.loadLibrary(), (
      context,
    ) {
      return cupertino_test_route.CupertinoTestRoute();
    });
  },
  "非命名路由的传值方式": (context) {
    return ContainerAsyncRouterPage(router_test_route.loadLibrary(), (context) {
      return router_test_route.RouterTestRoute();
    });
  },
  "文本及样式": (context) {
    return ContainerAsyncRouterPage(text_route.loadLibrary(), (context) {
      return text_route.TextRoute();
    });
  },
  "按钮": (context) {
    return ContainerAsyncRouterPage(button_route.loadLibrary(), (context) {
      return button_route.ButtonRoute();
    });
  },
  "图片": (context) {
    return ContainerAsyncRouterPage(image_and_icon_route.loadLibrary(), (
      context,
    ) {
      return image_and_icon_route.ImageAndIconRoute();
    });
  },
  "ICON": (context) {
    return ContainerAsyncRouterPage(icon_fonts_route.loadLibrary(), (context) {
      return icon_fonts_route.IconFontsRoute();
    });
  },
  "单选开关和复选框": (context) {
    return ContainerAsyncRouterPage(switch_and_checkbox_route.loadLibrary(), (
      context,
    ) {
      return switch_and_checkbox_route.SwitchAndCheckBoxRoute();
    });
  },
  "TextField的焦点处理": (context) {
    return ContainerAsyncRouterPage(focus_test_route.loadLibrary(), (context) {
      return focus_test_route.FocusTestRoute();
    });
  },
  "Form表单": (context) {
    return ContainerAsyncRouterPage(form_test_route.loadLibrary(), (context) {
      return form_test_route.FormTestRoute();
    });
  },
  "进度指示器": (context) {
    return ContainerAsyncRouterPage(progress_route.loadLibrary(), (context) {
      return progress_route.ProgressRoute();
    });
  },
  "尺寸限制布局": (context) {
    return ContainerAsyncRouterPage(size_constraints_route.loadLibrary(), (
      context,
    ) {
      return size_constraints_route.SizeConstraintsRoute();
    });
  },
  "线性布局": (context) {
    return ContainerAsyncRouterPage(center_column_route.loadLibrary(), (
      context,
    ) {
      return center_column_route.CenterColumnRoute();
    });
  },
  "流式布局": (context) {
    return ContainerAsyncRouterPage(wrap_and_flow_route.loadLibrary(), (
      context,
    ) {
      return wrap_and_flow_route.WrapAndFlowRoute();
    });
  },
  "层叠布局": (context) {
    return ContainerAsyncRouterPage(stack_route.loadLibrary(), (context) {
      return stack_route.StackRoute();
    });
  },
  "对齐和相对定位": (context) {
    return ContainerAsyncRouterPage(align_route.loadLibrary(), (context) {
      return align_route.AlignRoute();
    });
  },
  "自定义布局（LayoutBuilder）": (context) {
    return ContainerAsyncRouterPage(layout_builder_route.loadLibrary(), (
      context,
    ) {
      return layout_builder_route.LayoutBuilderRoute();
    });
  },
  "自定义布局（AfterLayout）": (context) {
    return ContainerAsyncRouterPage(after_layout_route.loadLibrary(), (
      context,
    ) {
      return after_layout_route.AfterLayoutRoute();
    });
  },
  "Padding（边距容器）": (context) {
    return ContainerAsyncRouterPage(padding_test_route.loadLibrary(), (
      context,
    ) {
      return padding_test_route.PaddingTestRoute();
    });
  },
  "DecoratedBox（装饰容器）": (context) {
    return ContainerAsyncRouterPage(decorated_box_route.loadLibrary(), (
      context,
    ) {
      return decorated_box_route.DecoratedBoxRoute();
    });
  },
  "Transform（变换容器）": (context) {
    return ContainerAsyncRouterPage(transform_route.loadLibrary(), (context) {
      return transform_route.TransformRoute();
    });
  },
  "Container（普通容器）": (context) {
    return ContainerAsyncRouterPage(container_route.loadLibrary(), (context) {
      return container_route.ContainerRoute();
    });
  },
  "Clip（裁剪容器）": (context) {
    return ContainerAsyncRouterPage(clip_route.loadLibrary(), (context) {
      return clip_route.ClipRoute();
    });
  },
  "FittedBox（适配容器）": (context) {
    return ContainerAsyncRouterPage(fitted_box_route.loadLibrary(), (context) {
      return fitted_box_route.FittedBoxRoute();
    });
  },
  "Scaffold（脚手架）": (context) {
    return ContainerAsyncRouterPage(scaffold_route.loadLibrary(), (context) {
      return scaffold_route.ScaffoldRoute();
    });
  },
  "SingleChildScrollView示例": (context) {
    return ContainerAsyncRouterPage(
      single_child_scrollview_test_route.loadLibrary(),
      (context) {
        return single_child_scrollview_test_route.SingleChildScrollViewTestRoute();
      },
    );
  },
  "ListView-固定高度": (context) {
    return ContainerAsyncRouterPage(fixed_extent_list.loadLibrary(), (context) {
      return fixed_extent_list.FixedExtentList();
    });
  },
  "ListView-加载更多": (context) {
    return ContainerAsyncRouterPage(infinite_listview.loadLibrary(), (context) {
      return infinite_listview.InfiniteListView();
    });
  },
  "ListView-滚动通知": (context) {
    return ContainerAsyncRouterPage(
      scroll_notification_test_route.loadLibrary(),
      (context) {
        return scroll_notification_test_route.ScrollNotificationTestRoute();
      },
    );
  },
  "AnimatedList": (context) {
    return ContainerAsyncRouterPage(animated_list_route.loadLibrary(), (
      context,
    ) {
      return animated_list_route.AnimatedListRoute();
    });
  },
  "GridView-加载更多": (context) {
    return ContainerAsyncRouterPage(infinite_gridview.loadLibrary(), (context) {
      return infinite_gridview.InfiniteGridView();
    });
  },
  "PageView": (context) {
    return ContainerAsyncRouterPage(pageview_test.loadLibrary(), (context) {
      return pageview_test.PageViewTest();
    });
  },
  "ListView-缓存子项": (context) {
    return ContainerAsyncRouterPage(keep_alive_test.loadLibrary(), (context) {
      return keep_alive_test.KeepAliveTest();
    });
  },
  "TabView示例": (context) {
    return ContainerAsyncRouterPage(tabview_route.loadLibrary(), (context) {
      return tabview_route.TabViewRoute();
    });
  },
  "CustomScrollView-普通示例": (context) {
    return ContainerAsyncRouterPage(
      custom_scrollview_test_route.loadLibrary(),
      (context) {
        return custom_scrollview_test_route.CustomScrollViewTestRoute();
      },
    );
  },
  "CustomScrollView-固定头部": (context) {
    return ContainerAsyncRouterPage(persistent_header_route.loadLibrary(), (
      context,
    ) {
      return persistent_header_route.PersistentHeaderRoute();
    });
  },
};
