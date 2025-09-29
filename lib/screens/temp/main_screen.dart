// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/screens/temp/humidity_screen.dart';
import 'package:digifarm_new/screens/temp/temp_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {

  const TabScreen({

    Key? key,
 
  }) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
        _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: ScreenSizeUtil.getHeight(context) *1,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                       TempScreen(),
                       HumidityScreen()
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenSizeUtil.getWidth(context) *0.9,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: Center(
                      child: TabBar(
                        dividerColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                          color: ClrUtils.green2,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Temperature',
                          ),
                          Tab(
                            text: 'Humidity',
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 30,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


