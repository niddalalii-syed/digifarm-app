import 'dart:developer';
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/models/npk_score/npk_score.dart';
import 'package:digifarm_new/screens/alert/alert_screen.dart';
import 'package:digifarm_new/screens/dashboardAnalysis/dashboard_analysis_screen.dart';
import 'package:digifarm_new/screens/drippingRate/dripping_rate_screen.dart';
import 'package:digifarm_new/screens/npkLevels/npk_levels_screen.dart';
import 'package:digifarm_new/screens/soilLevel/soil_level_screen.dart';
import 'package:digifarm_new/screens/soilParameters/soil_parameters_screen.dart';
import 'package:digifarm_new/screens/soil_ph/soil_ph_screen.dart';
import 'package:digifarm_new/screens/tds/tds_levels_screen.dart';
import 'package:digifarm_new/screens/temp/main_screen.dart';
import 'package:digifarm_new/screens/waterLevel/water_level_screen.dart';
import 'package:digifarm_new/screens/water_flow_rate/water_flow_rate.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> items = [
    {'icon': AssetImage(ImgUtils.grid1), 'color': Color(0xffB3C2F3),'title':'Dripping rate'},
    {'icon': AssetImage(ImgUtils.grid2), 'color': Color(0xff4A567F),'title':'Ph Levels'},
    {'icon': AssetImage(ImgUtils.grid3), 'color': Color(0xffCED5A5),'title':'Temperature'},
    {'icon': AssetImage(ImgUtils.grid4), 'color': Color(0xffD0DCC4),'title':'Carbon Level'},
    {'icon': AssetImage(ImgUtils.grid5), 'color': Color(0xffB8D4D7),'title':'Soil Parameters'},
    {'icon': AssetImage(ImgUtils.grid6), 'color': Color(0xffEDC1E3),'title':'TSD Levels'},
    {'icon': AssetImage(ImgUtils.grid7), 'color': Color(0xffB3C2F3),'title':'Water Level'},
    {'icon': AssetImage(ImgUtils.grid8), 'color': Color(0xff6DD3E1),'title':'Waterflow Rate'},
    {'icon': AssetImage(ImgUtils.grid9), 'color': Color(0xffCED5A5),'title':'NPK Levels'},
  ];

  final List<Map<String, dynamic>> newsItem = [
    {'image': AssetImage(ImgUtils.image1)},
    {'image': AssetImage(ImgUtils.image2)},
  ];

  Future<void> _refreshData() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 2));
    log('Data refreshed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.88,
            child: RefreshIndicator(
              backgroundColor: ClrUtils.green4,
              color: ClrUtils.green,
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Shariq",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return AlertScreen();
                                  }));
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(ImgUtils.notiIcon),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.person),
                              // backgroundImage:
                              //     AssetImage(ImgUtils.profileAvatar),
                            )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Search Bar
                    TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 18),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFCAEFDD).withOpacity(0.67),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Banner Slider
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DashboardAnalysisScreen();
                        }));
                      },
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: PageView(
                          children: [
                            BannerTile(
                              color: ClrUtils.bottomNav,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Grid with Icons
                    Text(
                      "Services",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.55, // Responsive height
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width > 600
                                ? 4
                                : 3,
                            childAspectRatio: MediaQuery.of(context).size.width > 600
                                ? 1.2
                                : 0.67,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 1,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (items[index]['icon'] == AssetImage(ImgUtils.grid7)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => WaterLevelScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid4)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => SoilLevelScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid5)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => SoilParaScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid2)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => SoilPhScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid1)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => DrippingRateScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid3)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => TabScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid6)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => TdsLevelsScreen()),
                                      );
                                    } else if (items[index]['icon'] == AssetImage(ImgUtils.grid9)) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => NpkLevelsScreen()),
                                      );
                                    }
                                    else if(items[index]['icon'] ==
                                     AssetImage(ImgUtils.grid8)) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) {
                                      return WaterFlowScreen();
                                    }));
                                  }
                                  },
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: items[index]['color'],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Image(
                                        image: items[index]['icon'],
                                        height: MediaQuery.of(context).size.width > 600 ? 50 : 35,
                                        width: MediaQuery.of(context).size.width > 600 ? 50 : 35,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  textAlign:TextAlign.center,
                                  items[index]['title'],
                                  style: TextStyle(
                                    
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // News & Update
                    Text(
                      "News & Update",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newsItem.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: newsItem[index]['image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BannerTile extends StatelessWidget {
  final Color color;

  const BannerTile({Key? key, required this.color}) : super(key: key);

  // Function to get the score from API
  Future<NPKScore> _getNPKScore() async {
    return await API_Services().getNPKScore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Predictive analysis &",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    // Use FutureBuilder to display the score
                    FutureBuilder<NPKScore>(
                      future: _getNPKScore(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SpinKitWaveSpinner(
                            color: Colors.white,
                            size: 40,
                          );  // Show loading spinner while fetching data
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          // Show the fetched score
                          return Text(
                            "${snapshot.data!.score}%",  // Display fetched score
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        } else {
                          return Text(
                            "11%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      "Yield Maximization",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/banner.png'),  // Update with your actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
