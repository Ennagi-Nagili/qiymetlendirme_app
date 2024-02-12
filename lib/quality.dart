import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Quality extends StatefulWidget {
  const Quality({super.key});

  @override
  State<Quality> createState() => _QualityState();
}

class _QualityState extends State<Quality> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  var markVisibility = false;
  var point1 = 0.0;
  var point2 = 0.0;

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  void calculate() {
    var text1 = controller1.text;
    var text2 = controller2.text;
    var text3 = controller2.text;

    if (text1.isEmpty || text2.isEmpty || text3.isEmpty) {
      Fluttertoast.showToast(
          msg: "Bütün xanaları doldurun",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if(double.parse(text2) > double.parse(text1)) {
      Fluttertoast.showToast(
          msg: "2 qiyməti alan şagirdlərin sayı ümumi şagird sayından çox ola bilməz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if(double.parse(text3) > double.parse(text1)) {
      Fluttertoast.showToast(
          msg: "4 və 5 qiyməti alan şagirdlərin sayı ümumi şagird sayından çox ola bilməz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if((double.parse(text1) + double.parse(text2)) > double.parse(text1)) {
      Fluttertoast.showToast(
          msg: "2, 4 və 5 qiyməti alan şagirdlərin sayı ümumi şagird sayından çox ola bilməz",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else {
      point1 = (double.parse(text1) - double.parse(text2)) /
          (double.parse(text1)) *
          100;

      point2 = double.parse(text3) / double.parse(text1) * 100;

      setState(() {
        markVisibility = true;
      });
    }
  }

  void clear() {
    setState(() {
      controller1.clear();
      controller2.clear();
      controller3.clear();
      markVisibility = false;
      point1 = 0.0;
      point2 = 0.0;
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
        body: Container(
          margin: const EdgeInsets.only(top: 32),
          child: ListView(children: [
            Column(
              children: [
                const Text("Sinif üzrə ümumi şagird sayı",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Container(
                  margin: const EdgeInsets.only(left: 96, right: 96, top: 16),
                  child: TextField(
                      controller: controller1,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Daxil et..."),
                      onSubmitted: (value) {}),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  const Text("\"2\" qiyməti alan şagirdlərin sayı",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Container(
                    margin: const EdgeInsets.only(left: 96, right: 96, top: 16),
                    child: TextField(
                        controller: controller2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Daxil et..."),
                        onSubmitted: (value) {}),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Column(
                children: [
                  const Text("\"4\" və \"5\" qiyməti alan şagirdlərin sayı",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Container(
                    margin: const EdgeInsets.only(left: 96, right: 96, top: 16),
                    child: TextField(
                        controller: controller3,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Daxil et..."),
                        onSubmitted: (value) {}),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 32),
              child: Visibility(
                visible: markVisibility,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 48),
                      child: Text("Müvəffəqiyyət faizi: $point1 %",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 48),
                      child: Text("Keyfiyyət faizi: $point2 %",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          calculate();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: const Size(130, 60),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        child: const Text("Hesabla",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22))),
                    ElevatedButton(
                        onPressed: () {
                          clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            fixedSize: const Size(130, 60),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        child: const Text("Sıfırla",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)))
                  ]),
            )
          ]),
        ));
  }
}
