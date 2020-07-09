import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/settings_comment_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SettingsComments extends StatefulWidget {
  @override
  _SettingsCommentsState createState() => _SettingsCommentsState();
}

class _SettingsCommentsState extends State<SettingsComments> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
      ),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsComments.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<UserProvider>(
              builder: (BuildContext context, model, Widget child) {
                return FutureBuilder(
                  future: model.getUserComments(),
                  builder: (BuildContext context, AsyncSnapshot<List<UserCommentOutputDTO>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.all(24),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => SettingsCommentBox(
                            header: snapshot.data[index].commentHeader,
                            comment: snapshot.data[index].comment,
                            star: snapshot.data[index].star,
                            name: snapshot.data[index].productName,
                            commentID: snapshot.data[index].commentId,
                            isGeneral: false,
                            productID: snapshot.data[index].productId,
                            snackBar: showSnackBar,
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          FlutterI18n.translate(context, "SettingsComments.noComment"),
                          style: FontStyles.text(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Loading();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
