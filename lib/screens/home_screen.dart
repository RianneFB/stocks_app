import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stocks/controllers/data_controller.dart';
import 'package:stocks/utils/app_colors.dart';
import 'package:stocks/utils/utilities.dart';
import 'package:stocks/widgets/balance_display.dart';
import 'package:stocks/widgets/custom_app_bar.dart';
import 'package:stocks/widgets/line_chart.dart';
import 'package:stocks/widgets/transaction_button.dart';
import 'package:stocks/widgets/transactions.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataController _controller = Get.put(DataController());

  bool portfolioIncrease = false;

  @override
  void initState() {
    super.initState();
    _controller.getStockPrices();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.darkBackground,
        systemNavigationBarColor: AppColors.navBarBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  BalanceDisplay(),
                  TransactionButtonRow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      "Featured investment",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        spacing: 8,
                        children: [
                          StockDisplay(
                            name: "Apple",
                            symbol: "AAPL",
                            data: _controller.appleStock.value,
                          ),

                          StockDisplay(
                            name: "Google",
                            symbol: "GOOGL",
                            data: _controller.googleStock.value,
                          ),

                          StockDisplay(
                            name: "Amazon",
                            symbol: "AMZN",
                            data: _controller.amazonStock.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My portfolio",
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          child: Text(
                            "View all",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transactions(
                    stockIcon: "assets/images/Amazon_icon.png",
                    stockName: "Amazon",
                    stockSymbol: "AMZN",
                    stockPrice:
                        "\$${_controller.amazonStock.value.bars.first.close}",
                    stockGrowth:
                        Utilities.calculatePriceChange(
                          _controller.amazonStock.value.bars.first,
                        ).$2
                        ? "+${Utilities.calculatePriceChange(_controller.amazonStock.value.bars.first).$1.toStringAsFixed(2)}%"
                        : "-${Utilities.calculatePriceChange(_controller.amazonStock.value.bars.first).$1.toStringAsFixed(2)}%",
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.5,
          selectedItemColor: AppColors.contentColorBlue,
          unselectedItemColor: AppColors.primaryText,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: "Home",
              backgroundColor: AppColors.navBarBackground,
            ),
            BottomNavigationBarItem(icon: Icon(Iconsax.card), label: "Card"),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.graph),
              label: "Analytics",
            ),
            BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
    );
  }
}