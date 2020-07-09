import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/settings_comment_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final String productID;

  const Comments({Key key, this.productID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Comments.comments"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (BuildContext context, model, Widget child) {
                return FutureBuilder(
                  future: model.getProductComments(productID),
                  builder: (BuildContext context, AsyncSnapshot<List<CommentOutputDTO>> snapshot) {
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
                            isGeneral: true,
                            name: snapshot.data[index].name,
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          FlutterI18n.translate(context, "Comments.noComment"),
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
