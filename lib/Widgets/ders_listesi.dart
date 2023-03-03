import 'package:dinamik_not_hesapla/constants/app_constants.dart';
import 'package:dinamik_not_hesapla/helper/data_helper.dart';
import 'package:dinamik_not_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi;
  const DersListesi({super.key, required this.onElemanCikarildi});
  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;

    return tumDersler.isNotEmpty
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  onElemanCikarildi(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                          backgroundColor: Sabitler.anaRenk,
                          child: Text((tumDersler[index].harfDegeri *
                                  tumDersler[index].krediDegeri)
                              .toStringAsFixed(0))),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} kredi , Not Değeri ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
            'Lütfen ders ekleyin',
            style: Sabitler.baslikStyle,
          ));
  }
}
