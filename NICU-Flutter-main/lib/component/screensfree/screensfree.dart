import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc_state/bloc_state.dart';
import '../../bloc/blocc/bloc.dart';

class AddPills extends StatefulWidget {
  const AddPills({Key? key}) : super(key: key);

  @override
  State<AddPills> createState() => _AddPillsState();
}

class _AddPillsState extends State<AddPills> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  String dropDownValue = 'item1';

  var items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocPage(),
      child: BlocConsumer<BlocPage, BlocState>(
          builder: (context, state) {
            return Scaffold(
              key: scaffoldState,
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://previews.123rf.com/images/mkphotoshu/mkphotoshu1701/mkphotoshu170100528/69804106-medical-hospital-icon-abstract-background-blue-gradient-illustration-design-.jpg'),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 7, left: 7, bottom: 7),
                      child: Container(
                        height: 420,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12.0, bottom: 13),
                              child: Text(
                                'Pills name',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  // top: 17.0,
                                  left: 10,
                                  right: 10,
                                  bottom: 5),
                              child: DropdownButtonFormField(
                                value: dropDownValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropDownValue = value!;
                                  });
                                },
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    child: Text(items),
                                    value: items,
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 12.0, bottom: 13),
                              child: Text(
                                'Amount',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  // top: 17.0,
                                  left: 10,
                                  right: 10,
                                  bottom: 5),
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () =>
                                            BlocPage.get(context).decreaseVal(),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 30,
                                        )),
                                    const Text(
                                      '|',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '${BlocPage.get(context).val} Pills ',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Text(
                                      '|',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    TextButton(
                                        onPressed: () =>
                                            BlocPage.get(context).increaseVal(),
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        child: const Icon(
                                            Icons.watch_later_outlined),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      ),
                                      onTap: () {
                                        print('hello');
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: TextButton(
                                            onPressed: () {
                                              print('welcome');
                                            },
                                            child: const Text(
                                              'Add Pills',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
