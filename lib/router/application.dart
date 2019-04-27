import 'package:fluro/fluro.dart';
import './routes.dart';

class Application {
  static Router router;

  static void initRouter() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
}
