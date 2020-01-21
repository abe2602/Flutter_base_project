import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_navigation/presentation/common/di.dart';
import 'package:state_navigation/presentation/common/tab_navigatior.dart';

import 'bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  callModal(BuildContext context, Widget widget){
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, __, _) {
          return Scaffold(
            body: widget,
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Provider( //Possibilita a DI
      builder: (context) => AppInfo(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  TabItem _currentTab = TabItem.movies;

  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.movies: GlobalKey<NavigatorState>(),
    TabItem.series: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem){
    setState(() => _currentTab = tabItem);
  }

  //Serve para esconder as tabs que não são as atuais
  Widget _buildOffStageNavigator(TabItem tabItem){
    return Offstage(
      offstage: _currentTab != tabItem, //se for false, adiciona o widget na árvore
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async {
        return !await _navigatorKeys[_currentTab].currentState.maybePop();
      },

      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              _buildOffStageNavigator(TabItem.movies),
              _buildOffStageNavigator(TabItem.series),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          currentTab: _currentTab,
        ),
      ),
    );
  }
}
