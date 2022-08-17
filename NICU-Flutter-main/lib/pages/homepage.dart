import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:project/model/notification_model.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/notification.dart';
import 'package:project/pages/profile.dart';
import 'package:project/pages/save_post.dart';
import 'package:project/pages/setting.dart';
import 'package:project/resources/color_manger.dart';

import '../map_new/map.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/payment.dart';
import 'chat.dart';
import 'chats_screens.dart';
import 'get_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final FirebaseMessaging _fbm;
    // int _notificationCount=0;
  // late NotificationModel _notificationModel;

  // void notificationConfigure() async {
  //   _fbm = FirebaseMessaging.instance;
  //   NotificationSettings _setting = await _fbm.requestPermission(
  //     alert: true,
  //     sound: true,
  //     badge: true,
  //     provisional: false,
  //   );
  //   if (_setting.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('authorizationStatus is Done');
  //
  //     FirebaseMessaging.onMessage.listen((message) {
  //       NotificationModel notificationModel = NotificationModel(
  //         title: message.notification!.title,
  //         body: message.notification!.body,
  //         dateTilte: message.data['title'],
  //         dateBody: message.data['body'],
  //       );
  //       setState(() {
  //         // _notificationCount++;
  //         _notificationModel = notificationModel;
  //       });
  //       showSimpleNotification(
  //         Text(_notificationModel.title!),
  //         subtitle: Text(_notificationModel.body!),
  //       );
  //     });
  //   }else{
  //      print('Deniy');
  //   }
  // }

  int currentIndex = 0;
  final List _title = ['Posts', 'Notification', 'Location', 'Chat', 'Profile'];
  final List _pages = [
    const GetPost(),
    const Notification_Page(),
    MapFileRun(),
     ChatsScreen(),
    const Profile()
  ];

@override
  void initState() {

  // notificationConfigure();
  // _notificationCount=0;
  //   _fbm.getToken().then((value) => print(value));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {},
              child: const CircleAvatar(
                radius: 23,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
              ),
            ),
          )
        ],
        title: Text(
          _title[currentIndex]!,
          style: GoogleFonts.roboto(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: ColorManager.white,
          ),
        ),
      ),
      body: _pages[currentIndex],
      bottomNavigationBar: DiamondBottomNavigation(
        onItemPressed: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        unselectedColor: Colors.grey.shade400,
        selectedColor: ColorManager.primary,
        selectedLightColor: Colors.grey,
        centerIcon: Icons.place,
        itemIcons: const [
          Icons.home_outlined,
          Icons.notifications_active,
          Icons.chat_bubble,
          Icons.person,
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepPurpleAccent,
                  Colors.deepPurple,
                ]),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            CustomListTile(Icons.person, 'Profile', () {}),
            CustomListTile(Icons.notifications, 'Notifications', () {}),
            CustomListTile(Icons.bookmark, 'Saved', () {

              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const SavePost()));
            }),
            CustomListTile(Icons.settings, 'Settings', () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SettingPage()));
            }),
            CustomListTile(Icons.payment_rounded, 'Payment', () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Payment()));
            }),
            CustomListTile(Icons.lock, 'Log out', () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
          ],
        ),
      ),
    );
  }
}


