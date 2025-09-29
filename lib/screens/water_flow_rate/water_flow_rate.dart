
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/screens/waterLevel/water_level_screen.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WaterFlowScreen extends StatefulWidget {
  const WaterFlowScreen({super.key});

  @override
  State<WaterFlowScreen> createState() => _WaterFlowScreenState();
}

class _WaterFlowScreenState extends State<WaterFlowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.05,
              ),
              Text(
                'Water Level',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Image.asset(ImgUtils.drop),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '60.00',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '%',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Text(
                textAlign: TextAlign.center,
                'The normal water level for\nsunflower crop',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              CustomButton(
                title: 'Start',
                color: ClrUtils.purple,
              ),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              TableWidget(data: [],),
              SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
               Text(
                'Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
               SizedBox(
                height: ScreenSizeUtil.getHeight(context) * 0.02,
              ),
              Container(
                width: ScreenSizeUtil.getWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: ClrUtils.blue2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ideal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '70% - 85%	Optimal water level to ensure healthy growth and maximum yield potential.',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Normal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '60% - 70%	Adequate water level for growth, but not ideal for maximum yield.',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Below Normal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '50% - 60%	Growth stress begins; potential yield loss can occur.',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Worst',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Below 50%	Severe water stress; significant impact on plant health and yield.',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Above Ideal',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Above 86% Overwatering can cause root damage, poor aeration, and disease susceptibility.',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
