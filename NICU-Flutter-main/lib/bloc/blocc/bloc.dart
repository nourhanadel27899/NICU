import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/model/postmodel.dart';

import '../../map_new/helper_location.dart';
import '../../map_new/map.dart';
import '../../model/model_create.dart';
import '../../model/modelchats.dart';
import '../../pages/chats_screens.dart';
import '../../pages/details.dart';
import '../../pages/get_post.dart';
import '../../pages/notification.dart';
import '../../pages/profile.dart';
import '../bloc_state/bloc_state.dart';
import '../endpoint.dart';

class BlocPage extends Cubit<BlocState>  {
  BlocPage() : super(InitializeBlocState());

  Widget info = Container(
    width: 30,
    height: 30,
    color: Colors.black,
  );

  static BlocPage get(context) => BlocProvider.of(context);
  User? user = FirebaseAuth.instance.currentUser;
  UserCreateModel? model;

  int currentIndex = 0;
  String? mtoken;
  String? name;
  String? imageProfile;

  TextEditingController postController = TextEditingController();
  File? imageFile;
  var imageUrl;
  DocumentReference? addPost;
  bool infoState = false;

  List<Widget> screens = [
    const GetPost(),
    const Notification_Page(),
    MapFileRun(),
    ChatsScreen(),
    const Profile()
  ];

  List<String> titles = [
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeInfoState() {
    infoState = !infoState;
    print(infoState);
    emit(ChangeInfo());
  }

  void getUserData() {
    emit(LoadingGetDataStateHome());
    FirebaseFirestore.instance.collection('users').doc(ID).get().then((value) {
      print(value.data());
      model = UserCreateModel.fromJson(value.data()!);
      emit(SuccessGetDataStateHome());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetDataStateHome(error.toString()));
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
      emit(GetUserToken());
    });
    emit(GetUserToken());
  }

  getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${user?.uid}')
        .get()
        .then((value) {
      name = value['Username'];
      imageProfile = value['Image'];
      emit(GetUserField());
    });
    emit(GetUserField());
  }

  addData() async {
    PostModel postModel;
    String docId = FirebaseFirestore.instance.collection('Post').doc().id;
    addPost = FirebaseFirestore.instance.collection('Post').doc(docId);
    var currentUser = FirebaseAuth.instance.currentUser?.uid;

    if (imageFile != null) {
      var imageName = basename(imageFile!.path);
      var ref = FirebaseStorage.instance.ref('images/$imageName');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      addPost?.set({
        'name': name,
        'Description': postController.text,
        'imageurl': imageSend,
        'imageProfile': imageProfile,
        'user': currentUser,
        'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        'docID': docId,
        'likes': {},
        'token': mtoken
      });
    } else {
      addPost?.set({
        'name': name,
        'Description': postController.text,
        'imageurl': 'null',
        'imageProfile': imageProfile,
        'user': currentUser,
        'time': DateFormat('hh:mm a').format(DateTime.now()).toString(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        'docID': docId,
        'likes': {},
        'token': mtoken
      });
    }
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);

      imageFile = imageTemp;
      emit(Camera());
    } else {
      print('Chose image');
    }

    Navigator.pop(context);
  }

  void openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final imageTemp = File(pickedFile.path);

      imageFile = imageTemp;
      emit(Gallery());
    } else {
      print('Chose image');
    }

    Navigator.pop(context);
  }

  // Completer<GoogleMapController> controlMap = Completer();
  // CameraPosition positionOld =
  //     const CameraPosition(target: LatLng(30.671025, 30.948486), zoom: 14.756);
  // Marker mMarker = const Marker(
  //     markerId: MarkerId('positionOld'),
  //     icon: BitmapDescriptor.defaultMarker,
  //     infoWindow: InfoWindow(title: 'Google plex'),
  //     position: LatLng(30.671025, 30.948486));
  //
  // CameraPosition kLake = const CameraPosition(
  //   target: LatLng(30.680569, 30.940295),
  //   zoom: 19.546,
  //   tilt: 59.440717697143555,
  //   bearing: 192.8334901395799,
  // );
  // Marker lLake = Marker(
  //     markerId: const MarkerId('kLake'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //     infoWindow: const InfoWindow(title: 'home'),
  //     position: const LatLng(30.680569, 30.940295));
  //
  // Future<void> goToPlace(Map<String, dynamic> place) async {
  //   final double lat = place['geometry']['location']['lat'];
  //   final double lag = place['geometry']['location']['lag'];
  //   final GoogleMapController control = await controlMap.future;
  //   control.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(lat, lag), zoom: 12)));
  //   emit(GoToPlaceEmit());
  // }
  //
  // Future<void> newPosition() async {
  //   final GoogleMapController control = await controlMap.future;
  //   control.animateCamera(CameraUpdate.newCameraPosition(kLake));
  //   emit(ChangeMapLocation());
  // }

  static Position? position;
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _myCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    bearing: 0.0,
    zoom: 9,
    tilt: 0.0,
  );


  Future<void> getMyCurrentLocation() async {
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
    });
    emit(GetMyCurrentLocation());
  }


  // Marker hospital28 = Marker(
  //     markerId: const MarkerId('kLake19'),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //     infoWindow: const InfoWindow(
  //       title:
  //           'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع حي السويس)',
  //     ),
  //     position: const LatLng(30.082701716307582, 31.354481933004045));

  Widget buildMap(BuildContext context) {
    Marker hospital28 = Marker(
        markerId: const MarkerId('kLake19'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع حي السويس)',
        ),
        position: const LatLng(30.082701716307582, 31.354481933004045),
    onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Details()));
    }
    );
    Marker hospital20 = Marker(
        markerId: const MarkerId('kLake12'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'د. نشوة حسين العشرى - استشارى طب اطفال وحديثى الولادة والرضاعة الطبيعية',
        ),
        position: const LatLng(29.973989313786646, 31.28053687545031),
        onTap: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Details()));
    });
    Marker mMarker = Marker(
        markerId: const MarkerId('positionOld'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'حضانات مستشفي تلا المركزي'),
        position: const LatLng(30.68468960025776, 30.950258077911204),
        onTap: () {
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => const Details()));
        });

    Marker lLake = Marker(
        markerId: const MarkerId('kLake'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للأطفال المبتسرين وحديثي الولادة(فرع شبين الكوم)',
        ),
        position: const LatLng(30.566007802710622, 31.003274406612015));

    Marker anotherLake = Marker(
        markerId: const MarkerId('kLake1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي بركة السبع',
        ),
        position: const LatLng(30.63556566863241, 31.090300845741908));

    Marker hospital =  Marker(
        markerId: MarkerId('positionOld1'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
            title:
            'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع الباجور)'),
        position: LatLng(30.427208867294507, 31.04418245458604));

    Marker hospitalNew = Marker(
        markerId: const MarkerId('kLake2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي شبين الكوم التعليمي',
        ),
        position: const LatLng(30.574689955178687, 31.012118722088793));

    Marker anotherHospital = Marker(
        markerId: const MarkerId('kLake3'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي قويسنا المركزي',
        ),
        position: const LatLng(30.552845181564265, 31.138939791404646));

    Marker hospital7 =  Marker(
      markerId: MarkerId('positionOld2'),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'حضانات مستشفى الباجور'),
      position: LatLng(30.432908982790973, 31.02921514468324),
    );

    Marker hospital8 = Marker(
        markerId: const MarkerId('kLake4'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي السادات المركزي',
        ),
        position: const LatLng(30.367358113357238, 30.505989041491624));

    Marker hospital9 = Marker(
        markerId: const MarkerId('kLake5'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي منوف العام',
        ),
        position: const LatLng(30.47204027362369, 30.927744353136436));

    Marker hospital10 =  Marker(
        markerId: MarkerId('positionOld3'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'حضانات مستشفي اشمون العام'),
        position: LatLng(30.296018054178056, 30.98903153743087));

    Marker hospital11 = Marker(
        markerId: const MarkerId('kLake6'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي سرس الليان المركزي',
        ),
        position: const LatLng(30.44251807408193, 30.96086503118979));

    Marker hospital12 = Marker(
        markerId: const MarkerId('kLake7'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'حضانات مستشفي الشهداء المركزي',
        ),
        position: const LatLng(30.59683293125478, 30.9046417512878));

    Marker hospital13 =  Marker(
        markerId: MarkerId('positionOld4'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'مركز تبارك للأطفال'),
        position: LatLng(30.11875176101537, 31.320729370564067));

    Marker hospital14 = Marker(
        markerId: const MarkerId('kLake8'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'مركز المنارة التخصصى لحديثى الولادة',
        ),
        position: const LatLng(30.118484174851268, 31.32043337300127));

    Marker hospital15 = Marker(
        markerId: const MarkerId('kLake9'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع الماظة-القاهرة)',
        ),
        position: const LatLng(30.083156210945962, 31.354493647593657));

    Marker hospital16 =  Marker(
        markerId: MarkerId('positionOld5'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
            title:
            'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع الحي السادس القاهرة)'),
        position: LatLng(30.04791938287215, 31.31356655149757));

    Marker hospital17 = Marker(
        markerId: const MarkerId('kLake10'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع عين شمس- القاهرة)',
        ),
        position: const LatLng(30.136947945925815, 31.367895078606384));

    Marker hospital18 = Marker(
        markerId: const MarkerId('kLake11'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مركز الاسراء الطبى للاطفال و الحضانات لحديثى الولادة والمبتسرين',
        ),
        onTap: () {},
        position: const LatLng(30.008143781365394, 31.309437893253282));

    Marker hospital19 =  Marker(
        markerId: MarkerId('positionOld6'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow:
        InfoWindow(title: 'د. شهيرة لويز - استشارى طب اطفال وحديثى الولادة'),
        position: LatLng(29.98439261419109, 31.28498639745618));

    Marker hospital21 = Marker(
        markerId: const MarkerId('kLake13'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع شبرا الخيمة)',
        ),
        position: const LatLng(30.1233281847178, 31.26093435119303));

    Marker hospital22 =  Marker(
        markerId: MarkerId('positionOld7'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow:
        InfoWindow(title: 'مركز حياة لرعاية حديثى الولادة والمبتسرين'),
        position: LatLng(30.791849022546675, 30.99442753738349));

    Marker hospital23 = Marker(
        markerId: const MarkerId('kLake15'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(ايتاي البارود)',
        ),
        position: const LatLng(30.823681303102756, 30.81452307784013));

    Marker hospital24 = Marker(
        markerId: const MarkerId('kLake16'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة فرع اسكندرية)',
        ),
        position: const LatLng(31.118223715014565, 29.792431406746726));

    Marker hospital25 = Marker(
        markerId: const MarkerId('kLake17'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع كفر الشيخ)',
        ),
        position: const LatLng(31.11088609642273, 30.938184808462147));

    Marker hospital26 =  Marker(
        markerId: MarkerId('positionOld8'),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow:
        InfoWindow(title: 'المركز الطبى التخصصى للاطفال وحديثى الولادة'),
        position: LatLng(27.179640495499928, 31.18842327656822));

    Marker hospital27 = Marker(
        markerId: const MarkerId('kLake18'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title:
          'مستشفى الجمعية الشرعية للاطفال المبتسرين وحديثى الولادة(فرع سوهاج)',
        ),
        position: const LatLng(26.560327675317097, 31.691802015395293));
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _myCameraPosition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,

          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            mMarker,
            lLake,
            anotherLake,
            hospital,
            hospitalNew,
            anotherHospital,
            hospital7,
            hospital8,
            hospital9,
            hospital10,
            hospital11,
            hospital12,
            hospital13,
            hospital14,
            hospital15,
            hospital16,
            hospital17,
            hospital18,
            hospital19,
            hospital20,
            hospital21,
            hospital22,
            hospital23,
            hospital24,
            hospital25,
            hospital26,
            hospital27,
            hospital28,
          },
        ),
        infoState ? info : Container(),
      ],
    );
  }

  Future<void> goToMyCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCameraPosition));
    emit(GoToMyCurrentPosition());
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    ChatDetailsModel chatModel = ChatDetailsModel(
      text: text,
      sendId: model!.ID,
      receiveId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.ID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.ID)
        .collection('messages')
        .add(model!.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }

  void changeCurrentScreen(int index) {
    if (index == 1) getAllUsers();

    if (index == 2) {
      emit(AddPostScreenSuccess());
    } else {
      currentIndex = index;
      emit(ChangeCurrentScreen());
    }
  }

  List<UserCreateModel> allUsers = [];

  void getAllUsers() {
    // emit(LoadingGetAllUsersStateHome());
    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        emit(SuccessGetAllUsersStateHome());
        value.docs.forEach((element) {
          if (element.data()['ID'] != model!.ID) {
            allUsers.add(UserCreateModel.fromJson(element.data()));
          }
        });
      }).catchError((error) {
        emit(ErrorGetAllUsersStateHome(error.toString()));
      });
    }
    print(allUsers);
    print('done');
  }

  // void getData() {
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     allUsers.add(value.data());
  //   });
  // }

  void removeImageSender() {
    imageSend = null;
    emit(RemoveImageSenderSuccess());
  }

  void sendChatDetails({
    required String text,
    required String dateTime,
    required String? receiveID,
    required String image,
  }) {
    ChatDetailsModel modelDetails = ChatDetailsModel(
      dateTime: dateTime,
      text: text,
      receiveId: receiveID,
      sendId: model!.ID,
      image: image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.ID)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveID)
        .collection('chats')
        .doc(model!.ID)
        .collection('messages')
        .add(modelDetails.toMap())
        .then((value) {
      emit(SuccessSendAllChatsDetailsStateHome());
    }).catchError((error) {
      emit(ErrorSendAllChatsDetailsStateHome(error.toString()));
    });
  }

  // void getUserData() {
  //   emit(LoadingGetDataStateHome());
  //
  //   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
  //     // print(value.data());
  //     model = UserCreateModel.fromJson(value.data());
  //     emit(SuccessGetDataStateHome());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ErrorGetDataStateHome(error.toString()));
  //   });
  // }

  List<ChatDetailsModel> messages = [];

  void getMessages({
    required String? receiveID,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.ID)
        .collection('chats')
        .doc(receiveID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatDetailsModel.fromJson(element.data()));
      });
      emit(SuccessGetAllChatsDetailsStateHome());
    });
  }

  File? imageSend;

  Future<void> getImageSend() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      imageSend = File(pickedFile.path);
      print(pickedFile.path);
      emit(ChooseCoverPickerScreenSuccess());
    } else {
      print('No image selected.');
      emit(ChooseCoverPickerScreenError());
    }
  }

  void uploadingImageSend({
    required String text,
    required String dateTime,
    required String? receiveID,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref('messages')
        .child('messages/${Uri.file(imageSend!.path).pathSegments.last}')
        .putFile(imageSend!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendChatDetails(
            text: text, dateTime: dateTime, receiveID: receiveID, image: value);
      }).catchError((error) {
        emit(ErrorGetImageSendDetailsStateHome(error.toString()));
      });
    }).catchError((error) {
      emit(ErrorGetImageSendDetailsStateHome(error.toString()));
    });
  }

  String dropDownValue = 'item1';

  var items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];

  // List<Widget> screens = [Notification_Page(), Container(), Profile()];

  void changeScreen(index) {
    currentIndex = index;
    emit(ChangeScreenBottomNavBar());
  }

  int val = 1;

  increaseVal() {
    val += 1;
    emit(BlocStateIncrease());
  }

  decreaseVal() {
    val -= 1;
    emit(BlocStateDecrease());
  }

  changeItem(String? newValue) {
    dropDownValue = newValue!;
    emit(BlocStateHappened());
  }
}
