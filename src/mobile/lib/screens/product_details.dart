import 'package:app/design_system/atoms/admin/add_photo_card.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/book_preview.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/comment.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../router.dart';
import 'comments.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  ProductDetails({Key key, this.productId}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ProductProvider>(
      builder: (context, userProvider, productProvider, child) => FutureBuilder(
        future: productProvider.getProductDetail(productId: widget.productId, userId: userProvider.userId),
        builder: (context, AsyncSnapshot<ProductDetailOutputDTO> snapshot) => Scaffold(
          backgroundColor: PColors.darkBackground,
          appBar: PAppBar(
            isCenter: true,
            children: <Widget>[],
            actions: <Widget>[
              productProvider.comparedProducts.length < 2 || productProvider.comparedProducts.contains(widget.productId)
                  ? IconButton(
                      onPressed: () {
                        if (!productProvider.comparedProducts.contains(widget.productId)) {
                          productProvider.comparedProducts.add(widget.productId);
                          productProvider.setState(ServerState.Success);
                        } else {
                          productProvider.comparedProducts.remove(widget.productId);
                          productProvider.setState(ServerState.Success);
                        }
                      },
                      icon: Icon(Icons.compare_arrows,
                          color: productProvider.comparedProducts.contains(widget.productId) ? PColors.green1 : PColors.white, size: 25),
                    )
                  : Container(),
              snapshot.hasData
                  ? IconButton(
                      onPressed: () async {
                        if (userProvider.userId != null) {
                          if (snapshot.data.bookmark) {
                            await userProvider.deleteFromBookmark(widget.productId);
                            if (userProvider.state == ServerState.Success) {
                              snapshot.data.bookmark = false;
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                FlutterI18n.translate(context, "ProductDetail.bookmarkError"),
                              )));
                            }
                          } else {
                            await userProvider.addBookmark(widget.productId);
                            if (userProvider.state == ServerState.Success) {
                              snapshot.data.bookmark = true;
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                FlutterI18n.translate(context, "ProductDetail.bookmarkError"),
                              )));
                            }
                          }
                          userProvider.setState(ServerState.Success);
                        } else {
                          final action = await OPDialog.yesAbortDialog(
                            context,
                            FlutterI18n.translate(context, "Home.libraryWarning"),
                            FlutterI18n.translate(context, "Login.header"),
                            FlutterI18n.translate(context, "Home.goBack"),
                          );
                          if (action == DialogActionState.Yes) {
                            Navigator.pushReplacementNamed(context, Routes.login);
                          }
                        }
                      },
                      icon: Icon(snapshot.data.bookmark != null && (snapshot.data?.bookmark ?? false) ? PIcons.filledbookmark : PIcons.emptybookmark,
                          color: PColors.white, size: 25),
                    )
                  : Container()
            ],
          ),
          body: snapshot.hasData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: PColors.cardDark,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                        ),
                        child: Column(
                          children: <Widget>[
                            AddPhotoCard(
                              isEditable: false,
                              imageURL: snapshot.data.imageUrl,
                            ),
                            SizedBox(height: 12),
                            Text(
                              snapshot.data.name,
                              style: FontStyles.bookHeader(textColor: PColors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(snapshot.data.author, style: FontStyles.text(textColor: PColors.blueGrey)),
                            SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Comments(productID: widget.productId),
                                      ));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: SmoothStarRating(
                                          allowHalfRating: false,
                                          onRated: (v) {},
                                          starCount: 5,
                                          rating: snapshot.data.star,
                                          size: 20.0,
                                          isReadOnly: true,
                                          filledIconData: PIcons.filledstar,
                                          halfFilledIconData: PIcons.halfstar,
                                          color: PColors.orange,
                                          borderColor: PColors.orange,
                                          spacing: 0.0),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data.page.toString() + " " + FlutterI18n.translate(context, "ProductDetail.page"),
                                            style: FontStyles.text(textColor: PColors.blueGrey),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Comments(productID: widget.productId),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(snapshot.data.commentCount.toString() + FlutterI18n.translate(context, "ProductDetail.review"),
                                        style: FontStyles.smallText(textColor: PColors.blueGrey)),
                                    userProvider.userId != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Comment(
                                                            productID: widget.productId,
                                                          )));
                                            },
                                            child: Text(
                                              FlutterI18n.translate(context, "ProductDetail.makeComment"),
                                              style: FontStyles.smallText(textColor: PColors.new_primary_button_b_y_ire_m),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Row(
                              children: snapshot.data.category.asMap().entries.map((category) {
                            return Container(
                              margin: EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Constants.colors[category.key % Constants.colors.length],
                              ),
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              child: Text(
                                category.value,
                                style: FontStyles.smallText(textColor: PColors.white),
                              ),
                            );
                          }).toList()),
                          SizedBox(height: 12),
                          Text(FlutterI18n.translate(context, "ProductDetail.about"), style: FontStyles.header(textColor: PColors.white)),
                          SizedBox(height: 12),
                          Text(snapshot.data.description, style: FontStyles.textField(textColor: PColors.blueGrey)),
                          SizedBox(height: 12),
                          Text(FlutterI18n.translate(context, "ProductDetail.buyersBought"), style: FontStyles.header(textColor: PColors.white)),
                          SizedBox(height: 12),
                          Container(
                            height: 200,
                            child: Consumer<ProductProvider>(
                              builder: (context, model, child) => FutureBuilder(
                                future: model.getRelationalProducts(widget.productId),
                                builder: (BuildContext context, AsyncSnapshot<List<ProductListingOutputDTO>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      return ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) => BookPreview(
                                              name: snapshot.data[index].name,
                                              price: snapshot.data[index].price,
                                              author: snapshot.data[index].author,
                                              width: 70,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProductDetails(
                                                        productId: snapshot.data[index].id,
                                                      ),
                                                    ));
                                              },
                                              imgUrl: snapshot.data[index].imageUrl));
                                    }
                                    return Center(
                                      child: Text(
                                        FlutterI18n.translate(context, "ProductDetail.noBook"),
                                        style: FontStyles.text(),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  return Loading();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Loading(),
          bottomNavigationBar: snapshot.hasData
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    color: PColors.cardDark,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
                            "₺" + (snapshot.data.price != null ? snapshot.data.price.toString() : "--.--"),
                            style: FontStyles.bookHeader(textColor: PColors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Consumer<UserProvider>(builder: (BuildContext context, model, Widget child) {
                            return PButton(
                              text: FlutterI18n.translate(context, "ProductDetail.addToCart"),
                              onPressed: () async {
                                if (model.userId != null) {
                                  var response = await model.addToShoppingCard(widget.productId, 1);
                                  if (response == "Success") {
                                    Navigator.pop(context);
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                      FlutterI18n.translate(context, "ProductDetail.alreadyInCart"),
                                    )));
                                  }
                                } else {
                                  final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "ProductDetail.loginToAddCart"),
                                      FlutterI18n.translate(context, "ProductDetail.login"),
                                      FlutterI18n.translate(context, "ProductDetail.back"));
                                  if (action == DialogActionState.Yes) {
                                    Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.login));
                                  }
                                }
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
