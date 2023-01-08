import 'package:flutter/material.dart';
import 'package:helpfeed2/res/app_colors.dart';

class QuickActionView extends StatelessWidget {
  final IconData icon;
  final VoidCallback onClick;
  final String txt;
  const QuickActionView({Key? key, required this.icon, required this.onClick, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child:Icon(icon),

            ),

          ),
          const SizedBox(height: 8,),
          Text(txt)
        ],
      ),
    );
  }
}
