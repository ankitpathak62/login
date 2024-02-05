import 'package:flutter/material.dart';
import 'package:waythru/ui/views/register.dart';
import 'package:waythru/utils/utils.dart';

import '../models/models.dart';
import '../ui/views/views.dart';

class Routes {
  Routes();
  static List<PageModel> routes() {
    return [
      const PageModel(route: Pages.initial, page: AuthView()),
      const PageModel(route: Pages.home, page: HomeView()),
      const PageModel(route: Pages.register, page: RegisterView()),

      
    ];
  }

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }

    // todo modify here (error page)
    return MaterialPageRoute(
        builder: (_) => const Scaffold(), settings: settings);
  }
}
