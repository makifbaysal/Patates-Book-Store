import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/book_preview.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../product_details.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<ProductListingOutputDTO> bookmarks = List();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, model, Widget child) {
        return BaseWidget<UserProvider>(
          model: model,
          onModelReady: () async {
            bookmarks = await model.getBookmarks();
          },
          builder: (context, model, child) => model.state != ServerState.Busy
              ? bookmarks.length > 0
                  ? GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: bookmarks.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(right: 16),
                      itemBuilder: (context, index) {
                        return BookPreview(
                          isShowPrice: false,
                          width: (MediaQuery.of(context).size.width - 80) / 3,
                          name: bookmarks[index].name,
                          price: bookmarks[index].price,
                          imgUrl: bookmarks[index].imageUrl,
                          author: bookmarks[index].author,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    productId: bookmarks[index].id,
                                  ),
                                ));
                          },
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, crossAxisSpacing: 4, childAspectRatio: 0.55, mainAxisSpacing: 4),
                    )
                  : Center(
                      child: Text(
                        FlutterI18n.translate(context, "Home.noBookinLibrary"),
                        style: FontStyles.text(),
                        textAlign: TextAlign.center,
                      ),
                    )
              : Loading(),
        );
      },
    );
  }
}
