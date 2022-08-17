import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Card Number',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Enter The 6-digit card number on the card',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              buildContainer('0000 - 0000 - 0000 - 0000', Icons.payment_sharp),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text('Cvv Number',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, top: 9, bottom: 5, right: 10),
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        width: double.maxFinite,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                //  style: Themes().subTitleStyle,
                                cursorColor: Colors.black,
                                showCursor: true,
                                autofocus: false,
                                //controller: _Controller,
                                decoration: const InputDecoration(
                                  hintText: '789',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      )),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.dialpad,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ))
                ],
              ),
              const Text(
                'Enter The 3 or 4 digit number on the card',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text('Expired Date',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, top: 9, bottom: 5, right: 10),
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        width: double.maxFinite,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          //  style: Themes().subTitleStyle,
                          cursorColor: Colors.black,
                          showCursor: true,
                          autofocus: false,
                          //controller: _Controller,
                          decoration: const InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                )),
                          ),
                        ),
                      )),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, top: 9, bottom: 5, right: 10),
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        width: double.maxFinite,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          //  style: Themes().subTitleStyle,
                          cursorColor: Colors.black,
                          showCursor: true,
                          autofocus: false,
                          //controller: _Controller,
                          decoration: const InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                )),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0,
                                )),
                          ),
                        ),
                      )),
                ],
              ),
              const Text(
                'Enter The Expiration date of the card',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text('Phone',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 30, top: 9, bottom: 5, right: 10),
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        width: double.maxFinite,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                //  style: Themes().subTitleStyle,
                                cursorColor: Colors.black,
                                showCursor: true,
                                autofocus: false,
                                //controller: _Controller,
                                decoration: const InputDecoration(
                                  hintText: '01*********',
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      )),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.phone_android,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ))
                ],
              ),
              const Text(
                'Enter Your number phone',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(String hint, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 9, bottom: 5, right: 10),
      padding: const EdgeInsets.only(left: 10, right: 5),
      width: double.maxFinite,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              //  style: Themes().subTitleStyle,
              cursorColor: Colors.black,
              showCursor: true,
              autofocus: false,
              //controller: _Controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
              ),
            ),
          ),
          Icon(
            icon,
            size: 30,
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
