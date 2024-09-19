import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_arch/src/features/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_mobile_arch/src/features/dashboard/widgets/custom_data_table.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../main.dart';
import '../../app_configs/test_style.dart';
import '../../common_widgets/custom_animated_drop_down/custom_animated_drop_down.dart';
import '../../models/job_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final provider =
        Provider.of<DashboardSupportProvider>(context, listen: false);
    provider.reloadData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardSupportProvider>(context);

    final List<Job> jobList = [
      Job('Developer', Icons.developer_mode),
      Job('Designer', Icons.design_services),
      Job('Consultant', Icons.account_balance),
      Job('Student', Icons.school),
    ];

    void showNotification() async {
      if (await Permission.notification.isGranted) {
        const List<String> lines = <String>[
          'Shivendra Mani Tripathi Check this out',
          'Q3 Technology Launch Party'
        ];

        const BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(
          DrawableResourceAndroidBitmap(
              '@mipmap/ic_lancel'),
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          contentTitle: 'Notification with Image',
          summaryText: 'shivendramanitripathi.com',
        );

        AndroidNotificationDetails androidDetails = const AndroidNotificationDetails(
          'notification-youtube',
          'Youtube',
          priority: Priority.max,
          importance: Importance.max,
          color: Colors.purple,
          styleInformation:
              bigPictureStyleInformation, // Use BigPictureStyleInformation here
          channelDescription: "groupChannelDescription",
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          icon: '@mipmap/ic_launcher',
          colorized: true,
          tag: 'Shivendra',
          fullScreenIntent: true,
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'action_cancel',
              'Cancel',
              icon: DrawableResourceAndroidBitmap('@mipmap/ic_cancel'),
              cancelNotification: true,
              titleColor: Colors.amber,
              showsUserInterface: true,
              allowGeneratedReplies: true,
              contextual: true,
              inputs: [
                AndroidNotificationActionInput(choices: ["Shivendra", "Mani"])
              ],
            ),
          ],
        );

        DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

        NotificationDetails notificationDetails = NotificationDetails(
          android: androidDetails,
          iOS: iosDetails,
        );
        await flutterLocalNotificationsPlugin.show(
          0,
          'Shivendra Mani Tripathi',
          'This is the notification body',
          notificationDetails,
        );
      } else {
        await Permission.notification.request();
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        child: const Icon(Icons.notification_add_outlined),
      ),
      body: Column(
        children: [
          CustomAnimatedDropdown<Job>(
            items: jobList,
            itemAsString: (job) => job.title,
            hintText: 'Select job role',
            onChanged: (value) {},
          ),
          Expanded(
            child: SfDataGrid(
              source: CustomDataSource(provider.dataList),
              columnWidthMode: ColumnWidthMode.fill,
              headerRowHeight: 60,
              rowHeight: 60,
              columns: [
                GridColumn(
                  columnName: 'userId',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    child: Text(
                      AppLocalizations.of(context)!.userID,
                      overflow: TextOverflow.ellipsis,
                      style: mTextStyel32(),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'id',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    child: Text(
                      AppLocalizations.of(context)!.id,
                      overflow: TextOverflow.ellipsis,
                      style: mTextStyel32(),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'title',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    child: Text(
                      AppLocalizations.of(context)!.title,
                      overflow: TextOverflow.ellipsis,
                      style: mTextStyel32(),
                    ),
                  ),
                ),
                GridColumn(
                  columnName: 'body',
                  label: Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    color: Colors.blueGrey,
                    child: Text(
                      AppLocalizations.of(context)!.body,
                      overflow: TextOverflow.ellipsis,
                      style: mTextStyel32(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (provider.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (!provider.isLoading && provider.dataList.isNotEmpty)
            InkWell(
                onTap: provider.loadMoreData, child: const Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
