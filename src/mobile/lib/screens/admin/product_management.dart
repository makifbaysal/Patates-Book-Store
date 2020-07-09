import 'dart:async';

import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/home_card.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/or.dart';
import 'package:app/design_system/atoms/search_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/screens/Admin/product_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ProductManagement extends StatefulWidget {
  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  TextEditingController _searchController = TextEditingController();
  FocusNode searchFocusNode = new FocusNode();
  ProductListingReturnOutputDTO products = ProductListingReturnOutputDTO();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductProvider productProvider;

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
      FlutterI18n.translate(context, message),
    )));

    Timer(const Duration(milliseconds: 1000), () async {
      products = await productProvider.getProducts(search: _searchController.text, size: 20, from: 0);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "ProductManagement.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AdminHomeCard(
              boxColor: PColors.green1,
              boxIcon: PIcons.addproduct,
              text: FlutterI18n.translate(context, "ProductManagement.addProduct"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductAdd(isEditable: true, showSnackBar: showSnackBar),
                    ));
              },
            ),
            SizedBox(height: 20),
            Or(),
            SizedBox(height: 24),
            Text(FlutterI18n.translate(context, "ProductManagement.search"), style: FontStyles.header()),
            SizedBox(height: 12),
            Consumer<ProductProvider>(
              builder: (context, model, child) => SearchBar(
                  placeholderText: FlutterI18n.translate(context, "ProductManagement.placeholderSearch"),
                  requestFocus: _requestFocus,
                  focusNode: searchFocusNode,
                  controller: _searchController,
                  onChange: (searchText) async {
                    products = await model.getProducts(search: searchText, size: 20, from: 0);
                    setState(() {});
                  }),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, model, child) => BaseWidget<ProductProvider>(
                    model: model,
                    onModelReady: () async {
                      productProvider = model;
                      model.setState(ServerState.Busy);
                      products = await model.getProducts(search: _searchController.text, size: 20, from: 0);
                      model.setState(ServerState.Success);
                    },
                    builder: (context, model, child) => model.state != ServerState.Busy
                        ? products.products.length > 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: products.products.length,
                                itemBuilder: (context, index) {
                                  return AdminListingCard(
                                    imgUrl: products.products[index].imageUrl,
                                    boxIcon: PIcons.favouritebook,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductAdd(
                                              productID: products.products[index].id,
                                              isEditable: false,
                                              showSnackBar: showSnackBar,
                                            ),
                                          ));
                                    },
                                    children: <Widget>[
                                      Text(
                                        products.products[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyles.bigTextField(),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        products.products[index].author,
                                        style: FontStyles.textField(),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "₺" + products.products[index].price.toString(),
                                        style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  FlutterI18n.translate(context, "ProductManagement.searchError"),
                                  textAlign: TextAlign.center,
                                  style: FontStyles.text(),
                                ),
                              )
                        : Loading()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
