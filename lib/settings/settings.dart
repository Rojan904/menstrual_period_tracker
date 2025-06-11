import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/auth/signin/signin_screen.dart';
import 'package:menstraul_period_tracker/notification/notification_api.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/theme.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // ignore: prefer_typing_uninitialized_variables
  var _isNotificationOn;
  @override
  void initState() {
    var box = Hive.box('common');
    var getNot = box.containsKey('isNotificationOn');
    if (getNot) {
      _isNotificationOn = box.get('isNotificationOn');
    } else {
      _isNotificationOn = true;
    }
    // checkPermission();
    super.initState();
  }

  Future<void> checkPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      setState(() {
        _isNotificationOn = true;
      });
    } else if (status.isDenied) {
      setState(() {
        _isNotificationOn = false;
      });
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          const AppbarTitle(
            title: "Settings",
          ),
          context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Set Reminder", style: text16),
                SizedBox(
                  height: 20,
                  child: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                        activeColor: kPrimaryColor,
                        value: _isNotificationOn,
                        onChanged: (bool values) async {
                          setState(() {
                            _isNotificationOn = values;
                          });
                          var box = Hive.box('common');
                          await box.put('isNotificationOn', _isNotificationOn);
                          if (_isNotificationOn == false) {
                            NotificationApi.stopNotification();
                          }
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () async {
            // var userBox = Hive.box<User>('users');
            // var loggedInUser = userBox.values.firstWhere(
            //   (user) => user.isLoggedIn,
            //   orElse: () => User(),
            // );
            // // ignore: unnecessary_null_comparison
            // if (loggedInUser != null) {
            //   userBox.put(
            //     loggedInUser.key,
            //     User(
            //       isLoggedIn: false,
            //     ),
            //   );
            //   Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const LogInScreen(),
            //       ),
            //       (route) => false);
            // } else {
            //   CustomSnackbar.buildSnackbar(context, "Error logging out.",
            //       "Oh, Snap", ContentType.failure);
            // }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogInScreen(),
                ),
                (route) => false);
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: PrimaryButton(buttonText: "Logout"),
          )),
    );
  }

  switchNotification() {}
}
