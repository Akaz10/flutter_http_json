import 'package:flutter/material.dart';
import 'dart:convert';
import 'models/Araba.dart';

class LocalJsonKullanimi extends StatefulWidget {
  @override
  _LocalJsonKullanimiState createState() => _LocalJsonKullanimiState();
}

class _LocalJsonKullanimiState extends State<LocalJsonKullanimi> {
  List<Araba> tumArabalar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* veriKaynaginiOku().then((gelenArabaListesi) {
      setState(() {
        tumArabalar = gelenArabaListesi;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Json Kulanimi"),
      ),
      body: Container(
        child: FutureBuilder(
            future: veriKaynaginiOku(),
            builder: (context, sonuc) {
              if (sonuc.hasData) {
                tumArabalar = sonuc.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tumArabalar[index].araba_adi),
                      subtitle: Text(tumArabalar[index].ulke),
                    );
                  },
                  itemCount: tumArabalar.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Local Json Kulanimi"),),
      body: tumArabalar != null ? Container(
        child: ListView.builder(itemBuilder: (context, index){
          return ListTile(
            title: Text(tumArabalar[index]["araba_adi"]),
            subtitle: Text(tumArabalar[index]["ulke"]),
          );
        },
          itemCount: tumArabalar.length,)
    ) : Center(child: CircularProgressIndicator(),)
    );
  }
*/
  Future<List<Araba>> veriKaynaginiOku() async {
    /*Future<String> jsonOku = DefaultAssetBundle.of(context).loadString('assets/data/araba.json');

    jsonOku.then((okunanJson){
      debugPrint("gelen json: "+okunanJson);
      return okunanJson;
    });
*/
    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString('assets/data/araba.json');
    debugPrint(gelenJson);

    List<Araba> arabaListesi = (json.decode(gelenJson) as List).map((mapYapisi) => Araba.fromJsonMap(mapYapisi)).toList(); //dönüştürme yapılıyor.

    debugPrint("toplam araba sayısı:" + arabaListesi.length.toString());
    for (int i = 0; i < arabaListesi.length; i++) {
      debugPrint("Marka : " + arabaListesi[i].araba_adi.toString());
      debugPrint("Ülkesi : " + arabaListesi[i].ulke.toString());
    }
    return arabaListesi;
  }
}
