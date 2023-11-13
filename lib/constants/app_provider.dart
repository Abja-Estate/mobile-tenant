
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../provider/auth_provider.dart';


class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthProvider>(
      create: (ctx) => AuthProvider(),
    ),
   
  ];
}
