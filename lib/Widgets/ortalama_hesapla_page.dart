import 'package:dinamik_not_hesapla/Widgets/ders_listesi.dart';
import 'package:dinamik_not_hesapla/Widgets/harf_dropdown_widget.dart';
import 'package:dinamik_not_hesapla/Widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_not_hesapla/Widgets/ortalama_goster.dart';
import 'package:dinamik_not_hesapla/constants/app_constants.dart';
import 'package:dinamik_not_hesapla/helper/data_helper.dart';
import 'package:dinamik_not_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

final formKey = GlobalKey<FormState>();
double secilenHarfDegeri = 4;
double secilenKrediDegeri = 1;
String girilenDersAdi = '';

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          Sabitler.baslikText,
          style: Sabitler.baslikStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    ortalama: DataHelper.ortalamaHesapla(),
                    dersSayisi: DataHelper.tumEklenenDersler.length),
              )
            ],
          ),
          Expanded(child: DersListesi(
            onElemanCikarildi: (index) {
              DataHelper.tumEklenenDersler.removeAt(index);
              setState(() {});
            },
          )),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(padding: Sabitler.yatayPadding8, child: _buildTextFormField()),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: HarfDropdownWidget(
                    onHarfSecildi: (harf) {
                      secilenHarfDegeri = harf;
                    },
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: KrediDropdownWidget(onKrediSecildi: (kredi) {
                    secilenKrediDegeri = kredi;
                  })),
            ),
            IconButton(
              onPressed: _dersEkleveOrtalamaHesapla,
              icon: const Icon(Icons.arrow_forward_ios_sharp),
              color: Sabitler.anaRenk,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ]),
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s != null) {
          if (s.isEmpty) {
            return 'Lütfen bir ders adı giriniz';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
    }
  }
}
