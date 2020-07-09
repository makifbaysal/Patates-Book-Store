import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/faq.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SettingsFaq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Faq.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(24),
        children: <Widget>[
          Faq(
              question: "Sepetime neden 10’dan fazla aynı kitaptan ekleyemiyorum?",
              answer:
                  "Stokta yaşanabilecek problemleri en aza indirmek amacıyla, kullanıcılarımızın sepetine aynı kitaptan 10’dan fazla eklemesine izin vermiyoruz."),
          SizedBox(height: 20),
          Faq(
              question: "Sepetime neden 10’dan fazla aynı kitaptan ekleyemiyorum?",
              answer:
                  "Stokta yaşanabilecek problemleri en aza indirmek amacıyla, kullanıcılarımızın sepetine aynı kitaptan 10’dan fazla eklemesine izin vermiyoruz."),
          SizedBox(height: 20),
          Faq(
              question: "Sepetime neden 10’dan fazla aynı kitaptan ekleyemiyorum?",
              answer:
                  "Stokta yaşanabilecek problemleri en aza indirmek amacıyla, kullanıcılarımızın sepetine aynı kitaptan 10’dan fazla eklemesine izin vermiyoruz."),
          SizedBox(height: 20),
          Faq(
              question: "Sepetime neden 10’dan fazla aynı kitaptan ekleyemiyorum?",
              answer:
                  "Stokta yaşanabilecek problemleri en aza indirmek amacıyla, kullanıcılarımızın sepetine aynı kitaptan 10’dan fazla eklemesine izin vermiyoruz."),
          SizedBox(height: 20),
          Faq(
              question: "Sepetime neden 10’dan fazla aynı kitaptan ekleyemiyorum?",
              answer:
                  "Stokta yaşanabilecek problemleri en aza indirmek amacıyla, kullanıcılarımızın sepetine aynı kitaptan 10’dan fazla eklemesine izin vermiyoruz."),
        ],
      ),
    );
  }
}
