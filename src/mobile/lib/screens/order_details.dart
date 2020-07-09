import 'package:app/design_system/atoms/address_box.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/credit_cart_box.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/cargo_item.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/shipping_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/order_address.dart';
import 'package:app/screens/order_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../router.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int selectedAddressIndex;
  int selectedShippingCompanyIndex;
  int selectedCartIndex;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        FlutterI18n.translate(context, message),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "OrderDetails.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      backgroundColor: PColors.darkBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "OrderDetails.savedAddresses"),
                          style: FontStyles.header(textColor: PColors.blueGrey),
                        ),
                        IconButton(
                          icon: Icon(PIcons.plus),
                          color: PColors.blueGrey,
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAddress(showSnackBar: showSnackBar)));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 120,
                      child: FutureBuilder(
                        future: model.getUserAddress(),
                        builder: (BuildContext context, AsyncSnapshot<List<ListAddressOutputDTO>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (selectedAddressIndex == null && model.selectedAddress != null) {
                                    if (snapshot.data[index].addressId == model.selectedAddress.addressId) {
                                      selectedAddressIndex = index;
                                    }
                                  }
                                  return AddressBox(
                                    addressID: snapshot.data[index].addressId,
                                    address: snapshot.data[index].address,
                                    city: snapshot.data[index].city,
                                    county: snapshot.data[index].county,
                                    isActive: selectedAddressIndex == index,
                                    onPressed: () {
                                      setState(() {
                                        selectedAddressIndex = index;
                                        model.selectedAddress = snapshot.data[index];
                                      });
                                    },
                                  );
                                },
                              );
                            }
                            return Center(
                              child: Text(
                                FlutterI18n.translate(context, "OrderDetails.noAddress"),
                                textAlign: TextAlign.center,
                                style: FontStyles.text(),
                              ),
                            );
                          }
                          return Loading();
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      FlutterI18n.translate(context, "OrderDetails.shippingCompany"),
                      style: FontStyles.header(textColor: PColors.blueGrey),
                    ),
                    SizedBox(height: 16),
                    Consumer<ShippingProvider>(
                      builder: (BuildContext context, ShippingProvider shippingProvider, Widget child) {
                        return FutureBuilder(
                          future: shippingProvider.getShippingCompanies(search: ""),
                          builder: (BuildContext context, AsyncSnapshot<List<ListingShippingCompaniesOutputDTO>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length > 0) {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: snapshot.data.asMap().entries.map((item) {
                                      if (selectedShippingCompanyIndex == null && model.selectedShippingCompany != null) {
                                        if (model.selectedShippingCompany.companyId == item.value.companyId) {
                                          selectedShippingCompanyIndex = item.key;
                                        }
                                      }
                                      return CargoItem(
                                        value: selectedShippingCompanyIndex,
                                        name: item.value.name,
                                        price: item.value.price,
                                        index: item.key,
                                        radio: (int e) {
                                          setState(() {
                                            selectedShippingCompanyIndex = e;
                                            model.selectedShippingCompany = item.value;
                                          });
                                        },
                                      );
                                    }).toList());
                              }
                              return Center(
                                child: Text(
                                  FlutterI18n.translate(context, "OrderDetails.noShippingFirm"),
                                  textAlign: TextAlign.center,
                                  style: FontStyles.text(),
                                ),
                              );
                            }
                            return Loading();
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "OrderDetails.creditCarts"),
                          style: FontStyles.header(textColor: PColors.blueGrey),
                        ),
                        IconButton(
                          icon: Icon(PIcons.plus),
                          color: PColors.blueGrey,
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCart()));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 120,
                      child: FutureBuilder(
                        future: model.getCreditCards(),
                        builder: (BuildContext context, AsyncSnapshot<List<ListCreditCartsOutputDTO>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length > 0) {
                              return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    if (selectedCartIndex == null && model.selectedCart != null) {
                                      if (model.selectedCart.cartNumber == snapshot.data[index].cartNumber) {
                                        selectedCartIndex = index;
                                      }
                                    }
                                    return CreditCartBox(
                                        cartNumber: snapshot.data[index].cartNumber,
                                        date: snapshot.data[index].date,
                                        owner: snapshot.data[index].owner,
                                        isActive: selectedCartIndex == index,
                                        onPressed: () {
                                          setState(() {
                                            selectedCartIndex = index;
                                            model.selectedCart = snapshot.data[index];
                                          });
                                        });
                                  });
                            }
                            return Center(
                              child: Text(
                                FlutterI18n.translate(context, "OrderDetails.noCreditCard"),
                                textAlign: TextAlign.center,
                                style: FontStyles.text(),
                              ),
                            );
                          }
                          return Loading();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: PButton(
                          text: FlutterI18n.translate(context, "OrderDetails.continue"),
                          onPressed: (model.selectedCart != null && model.selectedShippingCompany != null && model.selectedAddress != null)
                              ? () {
                                  Navigator.pushNamed(context, Routes.confirmOrder);
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
