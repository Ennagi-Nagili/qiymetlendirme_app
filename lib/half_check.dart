import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HalfCheck extends StatefulWidget {
  const HalfCheck({super.key});

  @override
  State<HalfCheck> createState() => _HalfCheckState();
}

class _HalfCheckState extends State<HalfCheck> {
  var ksqVisibility = false;
  var count = 0;
  final TextEditingController countController = TextEditingController();
  var check = false;
  var bsqVisibility = false;

  List<TextEditingController> controlLerList = [];

  final TextEditingController bsqController = TextEditingController();

  @override
  void dispose() {
    countController.dispose();
    for (int i = 0; i < count; i++) {
      controlLerList[i].dispose();
    }
    bsqController.dispose();
    super.dispose();
  }

  void countSubmit() {
    count = int.parse(countController.text);

    if (count >= 3 && count <= 6) {
      setState(() {
        ksqVisibility = true;
        for (int i = 0; i < count; i++) {
          controlLerList.add(TextEditingController());
        }
      });
    } else {
      Fluttertoast.showToast(
          msg:
              "Yarmil ərzində kiçik summativ sayı 3-dən az 6-dan çox ola bilməz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  var markVisibility = false;
  var point = 0.0;
  var mark = 0;

  void calculate() {
    point = 0.0;

    if(countController.text.isNotEmpty) {
      var numCheck = false;

      for (int i = 0; i < controlLerList.length; i++) {
        if(controlLerList[i].text.isEmpty) {
          numCheck = true;
        }
        else if (double.parse(controlLerList[i].text) < 0 ||
            double.parse(controlLerList[i].text) > 100) {
          numCheck = true;
        }
      }

      var bsqCheck = false;

      if(bsqVisibility) {
        if(bsqController.text.isEmpty) {
          bsqCheck = true;
        } else if(double.parse(bsqController.text) < 0 ||
            double.parse(bsqController.text) > 100) {
          bsqCheck = true;
          bsqController.text = "";
        }
      }

      if (!numCheck && !bsqCheck) {
        for (int i = 0; i < controlLerList.length; i++) {
          point += double.parse(controlLerList[i].text);
        }

        if (bsqController.text.isNotEmpty) {
          var bsq = double.parse(bsqController.text);
          print(bsqController.text);
          point = point / controlLerList.length * 0.4;
          point += bsq * 0.6;
        } else {
          point /= controlLerList.length;
        }

        if (point > 80) {
          mark = 5;
        } else if (point > 60 && point <= 80) {
          mark = 4;
        } else if (point > 30 && point <= 60) {
          mark = 3;
        } else {
          mark = 2;
        }

        setState(() {
          markVisibility = true;
        });
      } else {
        print(numCheck);
        print(bsqCheck);
        point = 0;
        Fluttertoast.showToast(
            msg: "Bal 100-dən böyük və ya 0-dan kiçik ola bilməz",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg:
          "Yarmil ərzində kiçik summativ sayı 3-dən az 6-dan çox ola bilməz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void clear() {
    for(int i = 0; i < controlLerList.length; i++) {
      controlLerList[i].clear();
    }

    setState(() {
      countController.clear();
      check = false;
      bsqVisibility = false;
      ksqVisibility = false;
      point = 0.0;
      mark = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.blue,
            title: const Text("Bal hesablanması",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 2))),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text("Yarımil ərzində keçirilmiş KSQ sayı",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, right: 150),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: countController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Daxil et..."),
                      onSubmitted: (value) {
                        countSubmit();
                      }),
                ),
                Row(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 32),
                    child: const Text("Yarımil ərzində BSQ keçirilibmi:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 28, left: 16),
                    child: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                            value: check,
                            onChanged: (value) {
                              setState(() {
                                check = value!;
                                bsqVisibility = check;
                                if(!check) {
                                  bsqController.text = "";
                                }
                              });
                            })),
                  )
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Visibility(
                    visible: ksqVisibility,
                    child: Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(top: 32),
                                      child: const Text("KSQ balı:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 16, right: 60, left: 32),
                                        child: TextField(
                                            controller: controlLerList[index],
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Daxil et..."),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: count),
                        ),
                        Visibility(
                          visible: bsqVisibility,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top: 32),
                                child: const Text("BSQ balı",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 16, right: 60, left: 36),
                                  child: TextField(
                                    controller: bsqController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Daxil et..."),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                ]),
                Visibility(
                  visible: markVisibility,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 48),
                        child: Text("İllik bal: $point",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 48),
                        child: Text("İllik qiymət: $mark",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: calculate,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                fixedSize: const Size(130, 60),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            child: const Text("Hesabla",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22))),
                        ElevatedButton(
                            onPressed: clear,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                fixedSize: const Size(130, 60),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)))),
                            child: const Text("Sıfırla",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22)))
                      ]),
                )
              ]),
            ),
          ],
        ));
  }
}
