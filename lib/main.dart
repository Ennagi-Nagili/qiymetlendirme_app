import 'package:flutter/material.dart';
import 'package:qiymetlendirme_app/count_check.dart';
import 'package:qiymetlendirme_app/half_check.dart';
import 'package:qiymetlendirme_app/quality.dart';
import 'package:qiymetlendirme_app/yearly.dart';

void main() {
  runApp(const MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Bal hesablanması",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Colors.white,
                    letterSpacing: 2))),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 48),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const HalfCheck()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(340, 80),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text("YARIMİLLİK QİYMƏTLƏNDİRMƏ",
                          style: TextStyle(fontSize: 16, color: Colors.white)))
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const Yearly()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(340, 80),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)))),
                    child: const Text("İLLİK QİYMƏTLƏNDİRMƏ",
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const CountCheck()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(340, 80),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)))),
                    child: const Text(
                        "SUAL SAYINA GÖRƏ BAL\n (EYNİ SƏVİYYƏLİ SUALLAR ÜÇÜN)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const Quality()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(340, 80),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5)))),
                    child: const Text("KEYFİYYƏT VƏ MÜVƏFFƏQİYYƏT FAİZİ",
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              ),
            ],
          ),
        ));
  }
}

