import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Notification_Page extends StatefulWidget {
  const Notification_Page({Key? key}) : super(key: key);

  @override
  State<Notification_Page> createState() => _NotificationState();
}

class _NotificationState extends State<Notification_Page> {
  
  @override
  void initState() {
    configurationCallBacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, left: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 4),
              padding:
                  const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 8),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kareem khaled',
                        style: GoogleFonts.nunito(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        )
                      ),
                       IconButton(icon: const Icon(Icons.more_vert), onPressed: () {},),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        'consectetur adipisicing elitsed do eiusmod tempor incididunt utdo eiusmod tempor incididunt ut er',
                        softWrap: true,
                        style: GoogleFonts.quicksand(
                          fontSize: 19,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [Expanded(child: Container()), Padding(
                      padding: const EdgeInsets.only(right: 8.0,),
                      child: Text('3 min ago',softWrap: true,style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      ),),
                    )],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void configurationCallBacks() {

    FirebaseMessaging.onMessage;
  }
}
