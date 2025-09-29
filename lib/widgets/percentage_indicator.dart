// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:digifarm_new/const/clrUtils.dart';

class PercentageIndicator extends StatefulWidget {
  final double percentage;
  final Color? color;
  final Color? barBg;
final double? height;
final double? height1;
final double? height2;
final double? width;
final double? width1;
final double? width2;
  const PercentageIndicator({
    Key? key,
    required this.percentage,
    this.color,
    this.barBg,
    this.height,
    this.height1,
    this.height2,
    this.width,
    this.width1,
    this.width2,
  }) : super(key: key);
  @override
  _PercentageIndicatorState createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {
   // Change this to update the progress percentage

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
           
            Container(
              width: widget.width?? 170,
              height: widget.height?? 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color?? ClrUtils.bottomNav,
              ),
            ),
            // Circular Progress Indicator
            SizedBox(
              width:widget.width1?? 200,
              height: widget.height1??200,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                value: widget.percentage / 100, // Divide by 100 to get a range of 0-1
                strokeWidth: 15,
                valueColor: AlwaysStoppedAnimation<Color>(ClrUtils.blue1),
                backgroundColor: widget.barBg ?? ClrUtils.green2,
              ),
            ),
            // Percentage Text
            Container(
              width:widget.width2?? 90,
              height:widget.height2?? 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "${widget.percentage.toInt()}%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          
          ],
        ),
      );
  }
}