import 'package:bmi/constant/mycolors.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  final _controllerweight = TextEditingController();
  final _controllerheight = TextEditingController();

  int? weight;

  int? height;

  double? result = 0;

  String? condition = " ";

  computing() {
    weight = int.parse(_controllerweight.text);
    height = int.parse(_controllerheight.text);
    result = weight! / (height! * height!) * 10000;
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _key,
          backgroundColor: MyColors.backgrandcolor,
          drawer: Drawer(
              backgroundColor: MyColors.themecolor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                        " راهنما: با وارد کردن وزن و قد خود میتوانید شاخص توده بدنی خود را محاسبه کنید",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Text(
                    "برنامه نویس: محمد امیدی ",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.themecolor,
            title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu_rounded, size: 25),
              ),
              const Expanded(child: SizedBox()),
              const Text(
                " BMI محاسبه",
                style: TextStyle(),
              )
            ]),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _controllerweight,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              hintText: " kg",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)))),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                          child: Text(
                            ":وزن",
                            style: TextStyle(
                                fontSize: 25, color: MyColors.textcolor),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: TextField(
                          controller: _controllerheight,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              hintText: "cm",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)))),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                        child: Text(
                          ":قد",
                          style: TextStyle(
                              fontSize: 25, color: MyColors.textcolor),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 10, 0),
                      child: Text(
                        ":جنسیت",
                        style: TextStyle(
                          color: MyColors.textcolor,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  RadioListTile<SingingCharacter>(
                    title: const Text(
                      'اقا',
                      style:
                          TextStyle(color: MyColors.textcolor_, fontSize: 16),
                    ),
                    value: SingingCharacter.lafayette,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ]),
                RadioListTile<SingingCharacter>(
                  title: const Text('خانم',
                      style:
                          TextStyle(color: MyColors.textcolor_, fontSize: 16)),
                  value: SingingCharacter.jefferson,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    if (_controllerweight.text.isNotEmpty) {
                      computing();
                      _controllerweight.text = "";
                      _controllerheight.text = "";

                      setState(() {});
                    }
                    if (_controllerheight.text.isNotEmpty) {
                      computing();
                      setState(() {});
                    }
                    if (result! < 19) {
                      condition = "لاغر";
                    }
                    if (result! > 20) {
                      condition = "نرمال";
                    }
                    if (result! > 25) {
                      condition = "اضافه وزن";
                    }
                    if (result! > 30) {
                      condition = "چاق";
                    }
                    if (result! > 35) {
                      condition = "خیلی چاق";
                    }
                    if (result! > 40) {
                      condition = "خیلی خیلی چاق";
                    }
                  },
                  splashColor: Colors.grey,
                  child: Container(
                    width: 160,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: MyColors.bottoncolor,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "محاسبه",
                          style: TextStyle(fontSize: 23),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 170,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(condition.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    const Text("   : وضعیت شما ",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.textresultcolor,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
