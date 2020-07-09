import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/screens/product_listing.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map<String, int> categories = new Map<String, int>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (BuildContext context, model, Widget child) {
      return BaseWidget<ProductProvider>(
        model: model,
        onModelReady: () async {
          categories = await model.getCategories();
        },
        builder: (context, model, child) => model.state != ServerState.Busy
            ? GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(right: 24),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListing(
                              category: categories.keys.toList()[index],
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Constants.colors[index % Constants.colors.length], borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            categories.keys.toList()[index],
                            style: FontStyles.text(textColor: PColors.white),
                          ),
                          Text(
                            categories[categories.keys.toList()[index]].toString(),
                            style: FontStyles.bigText(textColor: PColors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 16, childAspectRatio: 1.7, mainAxisSpacing: 16),
              )
            : Loading(),
      );
    });
  }
}
