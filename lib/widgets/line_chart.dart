import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stocks/models/stock.dart';
import 'package:stocks/utils/app_colors.dart';
import 'package:stocks/utils/utilities.dart';

class StockDisplay extends StatefulWidget {
  const StockDisplay({
    super.key,
    required this.name,
    required this.symbol,
    required this.data,
    //this.price = "\$523.13",
    //this.growth = "+12%",
    //this.isUp = true,
  });

  final String name;
  final String symbol;
  final AlphaVantageDailyResponse data;
  //final String price;
  //final String growth;
  //final bool isUp;

  @override
  State<StockDisplay> createState() => _StockDisplayState();
}

class _StockDisplayState extends State<StockDisplay> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
    AppColors.contentColorRed,
    AppColors.contentColorPink,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.only(bottom: 1, right: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardDarkBackground,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
            child: AspectRatio(aspectRatio: 0.9, child: LineChart(avgData())),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              widget.name,
              style: TextStyle(color: AppColors.primaryText, fontSize: 18),
            ),
          ),
          Positioned(
            top: 34,
            left: 10,
            child: Text(
              widget.symbol,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 10,
            child: Row(
              spacing: 5,
              children: [
                Text(
                  widget.data.bars.first.close.toString(),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  Utilities.calculatePriceChange(widget.data.bars.first).$2
                    ? "+${Utilities.calculatePriceChange(widget.data.bars.first).$1.toStringAsFixed(2)}%"
                    : "-${Utilities.calculatePriceChange(widget.data.bars.first).$1.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(show: false, drawHorizontalLine: false),
      clipData: FlClipData(top: false, bottom: true, left: true, right: true),
      titlesData: FlTitlesData(
        show: false,
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 1.44),
            FlSpot(1, 1),
            FlSpot(1.8, 1.5),
            FlSpot(4, 2.60),
            FlSpot(6, 2.0),
            FlSpot(8, 1.94),
            FlSpot(11, 3.6),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: Utilities.calculatePriceChange(widget.data.bars.first).$2
                ? [
                    ColorTween(
                      begin: gradientColors[0],
                      end: gradientColors[1],
                    ).lerp(0.2)!,
                    ColorTween(
                      begin: gradientColors[0],
                      end: gradientColors[1],
                    ).lerp(0.2)!,
                  ]
                : [
                    ColorTween(
                      begin: gradientColors[2],
                      end: gradientColors[3],
                    ).lerp(0.2)!,
                    ColorTween(
                      begin: gradientColors[2],
                      end: gradientColors[3],
                    ).lerp(0.2)!,
                  ],
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: Utilities.calculatePriceChange(widget.data.bars.first).$2
                  ? [
                      ColorTween(
                        begin: gradientColors[0].withAlpha(50),
                        end: gradientColors[1].withAlpha(50),
                      ).lerp(0.2)!.withValues(alpha: 0.1),
                      ColorTween(
                        begin: gradientColors[0].withAlpha(50),
                        end: gradientColors[1].withAlpha(50),
                      ).lerp(0.2)!.withValues(alpha: 0.1),
                    ]
                  : [
                      ColorTween(
                        begin: gradientColors[2].withAlpha(50),
                        end: gradientColors[3].withAlpha(50),
                      ).lerp(0.2)!.withValues(alpha: 0.1),
                      ColorTween(
                        begin: gradientColors[2].withAlpha(50),
                        end: gradientColors[3].withAlpha(50),
                      ).lerp(0.2)!.withValues(alpha: 0.1),
                    ],
            ),
          ),
        ),
      ],
    );
  }
}

//class StockDisplayRow extends StatelessWidget {
//  const StockDisplayRow({super.key});

 // @override
  //Widget build(BuildContext context) {
  //  return SingleChildScrollView(
  //    scrollDirection: Axis.vertical,
 //     child: Row(
  //      spacing: 5,
  //      children: [
 //         StockDisplay(name: "Apple", symbol: "AAPL", isUp: true),

  //        StockDisplay(name: "Apple", symbol: "AAPL", isUp: true),

  //        StockDisplay(name: "Apple", symbol: "AAPL", isUp: true),
//        ],
 //     ),
 //   );
//  }
//}
