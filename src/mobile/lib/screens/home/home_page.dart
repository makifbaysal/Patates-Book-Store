import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/book_preview.dart';
import 'package:app/design_system/molecules/home_carousel.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../../router.dart';
import '../product_details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, model, child) => Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              FutureBuilder(
                future: model.getBestSellerTen(),
                builder: (BuildContext context, AsyncSnapshot<List<ProductListingOutputDTO>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0)
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: HomeCarousel(
                            title: FlutterI18n.translate(context, "Home.mostSell"),
                            children: snapshot.data
                                .map((item) => BookPreview(
                                      width: (MediaQuery.of(context).size.width - 80) / 2,
                                      name: item.name,
                                      author: item.author,
                                      imgUrl: item.imageUrl,
                                      price: item.price,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductDetails(
                                                productId: item.id,
                                              ),
                                            ));
                                      },
                                    ))
                                .toList()),
                      );
                    else
                      return Container();
                  }
                  return Loading();
                },
              ),
              FutureBuilder(
                future: model.getWeeklyDealsTen(),
                builder: (BuildContext context, AsyncSnapshot<List<ProductListingOutputDTO>> snapshot) {
                  if (snapshot.hasData) {
                    return HomeCarousel(
                        title: FlutterI18n.translate(context, "Home.weeklyOpportunity"),
                        children: snapshot.data
                            .map((item) => BookPreview(
                                  width: (MediaQuery.of(context).size.width - 80) / 2,
                                  isWeekly: true,
                                  name: item.name,
                                  author: item.author,
                                  imgUrl: item.imageUrl,
                                  price: item.price,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            productId: item.id,
                                          ),
                                        ));
                                  },
                                ))
                            .toList());
                  }
                  return Loading();
                },
              )
            ],
          ),
          model.comparedProducts.length > 0
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(color: PColors.cardDark, borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "ProductListing.compare") + "(" + model.comparedProducts.length.toString() + ")",
                          style: FontStyles.text(textColor: PColors.white),
                        ),
                        model.comparedProducts.length == 2
                            ? InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.compareBook);
                                },
                                child: Text(
                                  FlutterI18n.translate(context, "ProductListing.compare"),
                                  style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
