import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/models/alert_model/alert_model.dart';
import 'package:digifarm_new/services/api_servises/api_services.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final API_Services _apiService = API_Services();
  late Future<List<NotificationModel>> notifications;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  // Method to fetch notifications
  void fetchNotifications() {
    notifications = _apiService.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Warning'),
        ),
        body: FutureBuilder<List<NotificationModel>>(
          future: notifications, // The future that holds the notification data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Show loading indicator
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error if any
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No notifications available.'));
            }

            // Display the notifications once data is fetched
            final notificationsList = snapshot.data!;

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  width: ScreenSizeUtil.getWidth(context) * 0.9,
                  child: Column(
                    children: List.generate(notificationsList.length, (index) {
                      final notification = notificationsList[index];
                      return Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Row(
                              children: [
                                Image.asset(ImgUtils.alert),
                                SizedBox(width: 10),
                                // Wrap the Column with Expanded to allow text to use available space
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(notification.type),
                                      // Add an Expanded or Flexible widget around the Text to ensure no overflow
                                      Text(
                                        notification.message,
                                        overflow: TextOverflow.ellipsis, // Ensures text truncates with ellipsis
                                        style: TextStyle(),
                                        maxLines: 2, // Limit to two lines
                                      ),
                                      // You can replace this with dynamic timestamp if needed
                                    ],
                                  ),
                                ),
                              ],
                            )

                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(title: 'View all', color: ClrUtils.green2),
              CustomButton(title: 'Clear all', color: ClrUtils.green2),
            ],
          ),
        ));
  }
}
