import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CountCheck extends StatefulWidget {
  const CountCheck({super.key});

  @override
  State<CountCheck> createState() => _CountState();
}

class _CountState extends State<CountCheck> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  var markVisibility = false;
  var point = 0.0;
  var mark = 0;

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  void calculate() {
    var text1 = controller1.text;
    var text2 = controller2.text;

    if (text1.isEmpty || text2.isEmpty) {
      Fluttertoast.showToast(
          msg: "Bütün xanaları doldurun",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      point = double.parse(text2) / double.parse(text1) * 100;

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
    }
  }

  void clear() {
    setState(() {
      controller1.clear();
      controller2.clear();
      markVisibility = false;
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        const Text("Ümumi sual sayı:",
                            style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 48),
                            child: TextField(
                                controller: controller1,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Daxil et..."),
                                onSubmitted: (value) {
                                  print("Hello");
                                }),
                          ),
                        ),
                      ]),
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.only(top: 64),
                          child: const Text("Düzgün cavab sayı:",
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 64, left: 32),
                            child: TextField(
                                controller: controller2,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Daxil et..."),
                                onSubmitted: (value) {
                                  print("Hello");
                                }),
                          ),
                        ),
                      ]),
                      Visibility(
                        visible: markVisibility,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 48),
                              child: Text("Bal: $point",
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 48),
                              child: Text("Qiymət: $mark",
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                        const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
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
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 22)))
                            ]),
                      )
                    ],
                  )
                ]),
          ),
        ));
  }
}
