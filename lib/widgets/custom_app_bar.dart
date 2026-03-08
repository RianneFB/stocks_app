import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stocks/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cardDarkBackground,
                  border: Border.all(color: AppColors.borderLight, width: 1),
                ),
                child: ClipOval(
                  child: Image.asset(
                    '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good morning",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Rianne Fobissie Blese",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.cardDarkBackground.withAlpha(100),
              borderRadius: BorderRadius.circular(22),
              border: BoxBorder.all(color: AppColors.primaryText, width: 0.5),
            ),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                print('Card tapped.');
              },
              child: Icon(
                Iconsax.notification,
                color: AppColors.primaryText,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
