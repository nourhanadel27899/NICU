import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/button.dart';

import '../resources/color_manger.dart';

class apply extends StatefulWidget {
  const apply({Key? key}) : super(key: key);

  @override
  State<apply> createState() => _applyState();
}

class _applyState extends State<apply> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  CollectionReference? request;
  String? childrenName;
  final TextEditingController? _birthday = TextEditingController();
  String? weight;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-9 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.primary,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: const Text(
                        'NICU',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    // const Image(image: AssetImage('assets/images/frist.png')),
                    const Text('Welcome..',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(
                      height: 15.0,
                    ),
                    buildTextFormField(
                        hint: 'Name',
                        validate: () => (val) {
                              if (val!.isEmpty) {
                                return "ChildrenName is empty";
                              }
                              return null;
                            },
                        onSave: () => (val) {
                              setState(() {
                                childrenName = val;
                              });
                            },
                        onTap: () {},
                        label: 'Children Name',
                        sIcon: Icon(Icons.done)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    buildTextFormField(
                        hint: 'Weight',
                        type: TextInputType.number,
                        validate: () => (val) {
                              if (val!.isEmpty) {
                                return "Weight is Empty ";
                              }
                              return null;
                            },
                        onSave: () => (val) {
                              setState(() {
                                weight = val;
                              });
                            },
                        onTap: () => () {},
                        label: 'Weight',
                        sIcon: const Icon(Icons.done)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          // width: 120,
                          child: TextFormField(
                            enabled: false,
                            controller: _birthday,
                            style: GoogleFonts.arimo(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Select Date",
                              labelStyle: GoogleFonts.arimo(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                              // hintText: hint,
                              hintStyle: GoogleFonts.arimo(
                                fontSize: 19,
                                color: Colors.grey[700],
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2222));
                            if (pickedDate != null) {
                              setState(() {
                                _birthday?.text =
                                    DateFormat('yyyy-mm-dd').format(pickedDate);
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor:ColorManager.primary,
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = int.parse(value.toString());
                              });
                            }),
                        Text(
                          "Male",
                          style: GoogleFonts.arimo(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Radio(
                            value: 2,
                            activeColor:ColorManager.primary,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = int.parse(value.toString());
                              });
                            }),
                        Text(
                          "Female",
                          style: GoogleFonts.arimo(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MyButton(
                        title: 'Apply',
                        color: Colors.white,
                        onTap: () {
                          _submit();
                        },
                        color1: ColorManager.primary),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField({
    required String hint,

    required String label,
    required Widget sIcon,
  TextInputType? type,
    required Function() validate,
    required Function() onSave,
    required Function() onTap,
    TextEditingController? controller,
  }) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      validator: validate(),
      onSaved: onSave(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.arimo(
          fontSize: 20,
          color: Colors.grey[700],
        ),
        hintText: hint,
        hintStyle: GoogleFonts.arimo(
          fontSize: 19,
          color: Colors.grey[700],
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black, width: 1.2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: sIcon,
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      addData();
    } else {
      print('Not Valid');
    }
  }

 addData()async{
   request = FirebaseFirestore.instance.collection('Request');
   request?.add({
     "Name":childrenName,
     "Weight":weight,
     "Birthday":_birthday!.text,
     "Gender":_value==1?"Male":"Female",

   });
   print('Added');
 }
}
