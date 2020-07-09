import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/screens/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class CompareBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PColors.cardDark,
        title: Text(
          FlutterI18n.translate(context, "Compare.compare"),
          style: FontStyles.header(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
        child: Consumer<ProductProvider>(
          builder: (BuildContext context, ProductProvider model, Widget child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder(
                        future: model.getProductDetail(productId: model.comparedProducts[0]),
                        builder: (BuildContext context, AsyncSnapshot<ProductDetailOutputDTO> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (model.comparedProducts.length > 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductDetails(
                                              productId: model.comparedProducts[0],
                                            ),
                                          ));
                                    }
                                  },
                                  child: Container(
                                    width: 140,
                                    height: 216,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              snapshot.data.imageUrl,
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(snapshot.data.name, style: FontStyles.bigTextField(textColor: PColors.white)),
                                SizedBox(height: 8),
                                Text(snapshot.data.author, style: FontStyles.text(textColor: PColors.blueGrey)),
                                SizedBox(height: 40),
                                Text("₺" + snapshot.data.price.toString(), style: FontStyles.text(textColor: PColors.blue2)),
                                SizedBox(height: 20),
                                Text(snapshot.data.category.join(", "), style: FontStyles.text(textColor: PColors.blueGrey)),
                                SizedBox(height: 20),
                                Text(snapshot.data.star.toStringAsFixed(2) + "/5", style: FontStyles.text(textColor: PColors.blueGrey)),
                                SizedBox(height: 20),
                                Text(snapshot.data.commentCount.toString() + FlutterI18n.translate(context, "Compare.review"),
                                    style: FontStyles.text(textColor: PColors.blueGrey)),
                                SizedBox(height: 20),
                                Text(snapshot.data.page.toString() + FlutterI18n.translate(context, "Compare.page"),
                                    style: FontStyles.text(textColor: PColors.blueGrey)),
                              ],
                            );
                          }
                          return Loading();
                        },
                      ),
                      SizedBox(width: 40),
                      model.comparedProducts.length > 1
                          ? FutureBuilder(
                              future: model.getProductDetail(productId: model.comparedProducts[1]),
                              builder: (BuildContext context, AsyncSnapshot<ProductDetailOutputDTO> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ProductDetails(
                                                  productId: model.comparedProducts[1],
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 216,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                    snapshot.data.imageUrl,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(snapshot.data.name, style: FontStyles.bigTextField(textColor: PColors.white)),
                                      SizedBox(height: 8),
                                      Text(snapshot.data.author, style: FontStyles.text(textColor: PColors.blueGrey)),
                                      SizedBox(height: 40),
                                      Text("₺" + snapshot.data.price.toString(), style: FontStyles.text(textColor: PColors.blue2)),
                                      SizedBox(height: 20),
                                      Text(snapshot.data.category.join(", "), style: FontStyles.text(textColor: PColors.blueGrey)),
                                      SizedBox(height: 20),
                                      Text(snapshot.data.star.toStringAsFixed(2) + "/5", style: FontStyles.text(textColor: PColors.blueGrey)),
                                      SizedBox(height: 20),
                                      Text(snapshot.data.commentCount.toString() + FlutterI18n.translate(context, "Compare.review"),
                                          style: FontStyles.text(textColor: PColors.blueGrey)),
                                      SizedBox(height: 20),
                                      Text(snapshot.data.page.toString() + FlutterI18n.translate(context, "Compare.page"),
                                          style: FontStyles.text(textColor: PColors.blueGrey)),
                                    ],
                                  );
                                }
                                return Loading();
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: PButton(
                  onPressed: () {
                    Navigator.pop(context);
                    model.comparedProducts = [];
                    model.setState(ServerState.Success);
                  },
                  color: PColors.red,
                  text: FlutterI18n.translate(context, "Compare.clear"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
