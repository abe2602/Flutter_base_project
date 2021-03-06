import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_navigation/app/presentation/favorites/favorites_view.dart';

import '../../../app/presentation/common/bottom_navigation.dart';
import '../../../app/presentation/movie/movie_list_view.dart';

/// SOBRE MODAL: para que um modal seja exibido,
/// basta que o Navigator.push seja chamado
/// da seguinte maneira:
/// Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder:
/// (context) => ROTA, fullscreenDialog: true),);

class TabNavigatorRoutes {
  static const String root = '/';
}

//Associa o nome com a tab
// (recebe como parâmetro a key do navegador e uma tabItem)
class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  //Retorna os widgets possíveis na navegação
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) => {
      TabNavigatorRoutes.root: (context) {
        if (tabItem == TabItem.movies) {
          return MoviesListView.create(context);
        } else {
          return FavoritesView.create(context);
        }
      }
    };

  //Retorna um novo widget com o próprio navegador
  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        ),
    );
  }
}
