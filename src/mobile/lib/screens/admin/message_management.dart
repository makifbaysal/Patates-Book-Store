import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class MessageManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "MessageManagement.header"),
              style: FontStyles.header(textColor: PColors.white),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Consumer<AdminProvider>(
            builder: (BuildContext context, model, Widget child) => FutureBuilder(
              future: model.getMessages(),
              builder: (BuildContext context, AsyncSnapshot<List<SeeMessageOutputDTO>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: PColors.cardDark,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].subject,
                              style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                            ),
                            SizedBox(height: 8),
                            Text(
                              snapshot.data[index].message,
                              style: FontStyles.text(textColor: PColors.white),
                            ),
                            SizedBox(height: 8),
                            Text(
                              snapshot.data[index].email,
                              style: FontStyles.smallText(textColor: PColors.blueGrey),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      FlutterI18n.translate(context, "MessageManagement.noMessage"),
                      style: FontStyles.text(),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Loading();
              },
            ),
          ),
        ));
  }
}
