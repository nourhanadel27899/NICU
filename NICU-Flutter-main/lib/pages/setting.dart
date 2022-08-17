
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  static const Color bluishClr = Color(0xFF181C2F);
  static const Color pinkclr = Color(0xFF7F3E8C);


  final List _icon = [
    Icons.person,
    Icons.headset,
    Icons.lock,
    Icons.contact_support_rounded,
  ];
  final List _nameS = [
    "Account",
    "Help and Support",
    "Privacy & Setting ",
    "About Us"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:pinkclr ,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(fontSize: 22),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        child: Stack(
          children: [
            RotatedBox(
            quarterTurns: 2,
            child: Container(
              child: CustomPaint(
                size: Size(double.infinity, 400),
                painter: CurvedPainter(),
              ),
            ),
          ),

            Container(
              margin: EdgeInsets.only(top: 150),
              child: ListView.separated(
                itemCount: _nameS.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 30),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(_icon[index], size: 35,color: pinkclr,),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                _nameS[index],
                                style: TextStyle(fontSize: 25),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
            Align(
              widthFactor: double.infinity,
              alignment: Alignment.bottomRight,
              child:Padding(
                padding: const EdgeInsets.only(right: 10,bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Log out",style: TextStyle(fontSize: 30),),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: bluishClr,
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.logout)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = _SettingPage.pinkclr
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
