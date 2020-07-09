import 'package:app/design_system/atoms/credit_cart_box.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/order_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class MyCards extends StatefulWidget {
  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PColors.cardDark,
        title: Text(FlutterI18n.translate(context, "SettingsMyCards.header")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: PColors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCart()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Consumer<UserProvider>(
                builder: (BuildContext context, model, Widget child) {
                  return FutureBuilder(
                    future: model.getCreditCards(),
                    builder: (BuildContext context, AsyncSnapshot<List<ListCreditCartsOutputDTO>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => CreditCartBox(
                              isVertical: true,
                              cartID: snapshot.data[index].cartId,
                              cartNumber: snapshot.data[index].cartNumber,
                              date: snapshot.data[index].date,
                              icon: PIcons.delete,
                              owner: snapshot.data[index].owner,
                              isSelectable: false,
                              showSnackBar: showSnackBar,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderCart(cartID: snapshot.data[index].cartId, showSnackBar: showSnackBar)));
                              },
                            ),
                          );
                        }
                        return Center(
                          child: Text(
                            FlutterI18n.translate(context, "SettingsMyCards.noCard"),
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
      ),
    );
  }
}
