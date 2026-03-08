import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:stocks/models/stock.dart';
import 'dart:async';

class DataController extends GetxController {
  Rx<AlphaVantageDailyResponse> appleStock =
      AlphaVantageDailyResponse.fromEmpty().obs;
  Rx<AlphaVantageDailyResponse> googleStock =
      AlphaVantageDailyResponse.fromEmpty().obs;
  Rx<AlphaVantageDailyResponse> amazonStock =
      AlphaVantageDailyResponse.fromEmpty().obs;

  Future<void> getStockPrices() async {
    var aaplStock = await RemoteServices.getStockPrices("AAPL");
    appleStock(aaplStock);

    Future.delayed(const Duration(seconds: 2), () async {
      var googlStock = await RemoteServices.getStockPrices("GOOGL");
      googleStock(googlStock);
    });

    Future.delayed(const Duration(seconds: 6), () async {
      var amznStock = await RemoteServices.getStockPrices("AMZN");
      amazonStock(amznStock);
    });
  }
}

class RemoteServices {
  static var dio = Dio(BaseOptions(baseUrl: "https://www.alphavantage.co"));

  static Future<AlphaVantageDailyResponse> getStockPrices(String symbol) async {
    final dio = Dio();
    dio.options.baseUrl = "https://www.alphavantage.co";
    Response response;
    response = await dio.get(
      "/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=CUPU3CCGBCEJ1NKOG",
    );
    //print(response.data.toString());

    AlphaVantageDailyResponse data = AlphaVantageDailyResponse.fromJson(
      response.data,
    );
    print(data.meta.information);
    print(data.meta.symbol);
    var open = data.bars.where((e) => e.open < 300);
    for (int i = 0; i < open.length; ++i) {
      print(open.elementAt(i).open);
    }
    return data;
  }
}