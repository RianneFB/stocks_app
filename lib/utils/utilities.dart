import 'package:stocks/models/stock.dart';

class Utilities {
  static (double, bool) calculatePriceChange(DailyBar data) {
    double opening = data.open;
    double closing = data.close;
    bool portfolioIncrease = false;

    if(opening > closing) {
      var drop = opening - closing;
      portfolioIncrease = false;
      return (drop / opening *  100, portfolioIncrease);
    } else if(opening < closing) {
      var up = closing - opening;
      portfolioIncrease = true;
      return (up / opening * 100, portfolioIncrease);
    }
     
    return (0.0, portfolioIncrease);
  }
}