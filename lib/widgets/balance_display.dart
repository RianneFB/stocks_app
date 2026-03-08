import 'package:flutter/material.dart';
import 'package:stocks/utils/app_colors.dart';

class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // The colors the gradient should obtain at each of the stops
          colors: [
            Color.fromARGB(255, 59, 81, 133), // mid blue
            Color.fromARGB(255, 26, 40, 73), // deep navy (bottom-left)
            Color.fromARGB(255, 26, 40, 73), // deep navy (bottom-left)
            Color.fromARGB(255, 73, 88, 119), // highlight blue (top-right)
          ],
          // The beginning and ending points of the gradient
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Optional: specifies fractions for each color stop (if null, a uniform distribution is assumed)
          stops: [0.0, 0.3, 0.75, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total balance",
              style: TextStyle(color: AppColors.primaryText),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$24,109.10",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "+ 1,092.11 (12%) vs last month",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}