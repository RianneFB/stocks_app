import 'package:get/get.dart';
import 'package:stocks/bindings/data_binding.dart';
import 'package:stocks/screens/home_screen.dart';

final List<GetPage> appScreens = [
  GetPage(
    name: '/home', 
    page: () => const HomeScreen(),
    bindings: [DataBinding()],
  )
];