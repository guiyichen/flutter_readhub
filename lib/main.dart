import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_readhub/router_manger.dart';
import 'package:flutter_readhub/home_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/i18n.dart';
import 'view_model/locale_model.dart';
import 'view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///OKToast初始化以便全局使用context
    return OKToast(
      ///Provider 以便主题及国际化语言
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
          ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
        ],
        child: Consumer2<ThemeModel, LocaleModel>(
          builder: (context, themeModel, localeModel, child) => AppWidget(
            themeModel: themeModel,
            localeModel: localeModel,
          ),
        ),
      ),
    );
  }
}

///App
class AppWidget extends StatelessWidget {
  final ThemeModel themeModel;
  final LocaleModel localeModel;

  const AppWidget({
    Key key,
    this.themeModel,
    this.localeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///全局主题配置
      theme: themeModel.themeData(),
      darkTheme: themeModel.themeData(platformDarkMode: true),

      ///去掉右上顶部debug标签
      debugShowCheckedModeBanner: false,

      ///国际化语言
      locale: localeModel.locale,
      localizationsDelegates: [
        S.delegate,

        ///下拉刷新库国际化配置
        RefreshLocalizations.delegate,

        ///不配置该项会在EditField点击弹出复制粘贴工具时抛异常 The getter 'cutButtonLabel' was called on null.
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      ///配置页面路由
      onGenerateRoute: Router.generateRoute,

      ///主页
      home: HomePage(),
    );
  }
}