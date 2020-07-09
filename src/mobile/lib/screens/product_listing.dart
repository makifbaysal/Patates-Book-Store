import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/book_preview.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/screens/filter_page.dart';
import 'package:app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../router.dart';

class ProductListing extends StatefulWidget {
  final String category;

  ProductListing({this.category});

  @override
  _ProductListingState createState() => _ProductListingState();
}

class Choice {
  String title;
  String value;

  Choice({this.title, this.value});
}

class _ProductListingState extends State<ProductListing> {
  //Filter variables
  String sort;
  List<String> categories = new List();
  List<String> languages = new List();
  int highestPage;
  int lowestPage;
  int lowestPrice;
  int highestPrice;
  String search;

  //Page variables
  int from;
  int size = 18;

  List<ProductListingOutputDTO> products = [];

  void _select(Choice choice) {
    sort = choice.value;
    from = 0;
    products = [];
    setState(() {});
  }

  setFilters(
      String search, List<String> languages, List<String> categories, int lowestPage, int highestPage, int lowestPrice, int highestPrice) async {
    from = 0;
    sort = null;
    products = [];
    this.search = search;
    this.languages = languages;
    this.categories = categories;
    this.lowestPage = lowestPage;
    this.highestPage = highestPage;
    this.lowestPrice = lowestPrice;
    this.highestPrice = highestPrice;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.category != null) {
      categories.add(widget.category);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          TextField(
            textInputAction: TextInputAction.search,
            style: FontStyles.textField(textColor: PColors.white),
            onChanged: (value) {
              search = value;
              setState(() {});
            },
            decoration: InputDecoration(hintText: "Search", hintStyle: FontStyles.textField(textColor: PColors.white), border: InputBorder.none),
          )
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (BuildContext context, ProductProvider model, Widget child) => FutureBuilder(
          future: model.getProducts(
              category: categories,
              size: size,
              from: from,
              languages: languages,
              sort: sort,
              search: search,
              highestPage: highestPage,
              highestPrice: highestPrice,
              lowestPage: lowestPage,
              lowestPrice: lowestPrice),
          builder: (context, AsyncSnapshot<ProductListingReturnOutputDTO> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.products;
            }
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: PopupMenuButton<Choice>(
                                offset: Offset(15, 50),
                                onSelected: _select,
                                icon: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      PIcons.orderby,
                                      color: PColors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      FlutterI18n.translate(context, "ProductListing.sort"),
                                      style: FontStyles.header(),
                                    )
                                  ],
                                ),
                                itemBuilder: (BuildContext context) {
                                  return <Choice>[
                                    Choice(title: FlutterI18n.translate(context, "ProductListing.ascPrice"), value: "asc"),
                                    Choice(title: FlutterI18n.translate(context, "ProductListing.descPrice"), value: "desc"),
                                  ].map((Choice choice) {
                                    return PopupMenuItem<Choice>(
                                      value: choice,
                                      child: Text(choice.title),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              color: PColors.blueGrey,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilterPage(
                                          categories: categories,
                                          highestPage: highestPage,
                                          highestPrice: highestPrice,
                                          languages: languages,
                                          lowestPage: lowestPage,
                                          lowestPrice: lowestPrice,
                                          search: search,
                                          setFilters: setFilters,
                                        ),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      PIcons.filter,
                                      color: PColors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      FlutterI18n.translate(context, "Filter.header"),
                                      style: FontStyles.header(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: snapshot.hasData
                            ? products.length > 0
                                ? NotificationListener<ScrollNotification>(
                                    onNotification: (ScrollNotification scrollInfo) {
                                      if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && snapshot.data.productCount - size >= 0) {
                                        size += size;
                                        setState(() {});
                                      }
                                      return;
                                    },
                                    child: GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: products.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return BookPreview(
                                          width: (MediaQuery.of(context).size.width - 80) / 3,
                                          name: products[index].name,
                                          price: products[index].price,
                                          imgUrl: products[index].imageUrl,
                                          author: products[index].author,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProductDetails(
                                                    productId: products[index].id,
                                                  ),
                                                ));
                                          },
                                        );
                                      },
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3, crossAxisSpacing: 4, childAspectRatio: 1 / 2.1, mainAxisSpacing: 4),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      FlutterI18n.translate(context, "Home.noBookinSearch"),
                                      style: FontStyles.text(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                            : Loading(),
                      )
                    ],
                  ),
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
            );
          },
        ),
      ),
    );
  }
}
