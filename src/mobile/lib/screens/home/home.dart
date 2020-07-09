import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/product_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../router.dart';
import 'cart.dart';
import 'categories.dart';
import 'home_page.dart';
import 'library.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;

  void _onItemTapped(int index, UserProvider model) async {
    if (index > 1) {
      if (model.idToken != null) {
        setState(() {
          _currentPage = index;
        });
      } else {
        if (index == 2) {
          final action = await OPDialog.yesAbortDialog(
            context,
            FlutterI18n.translate(context, "Home.libraryWarning"),
            FlutterI18n.translate(context, "Login.header"),
            FlutterI18n.translate(context, "Home.goBack"),
          );
          if (action == DialogActionState.Yes) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        } else {
          final action = await OPDialog.yesAbortDialog(
            context,
            FlutterI18n.translate(context, "Home.cartWarning"),
            FlutterI18n.translate(context, "Login.header"),
            FlutterI18n.translate(context, "Home.goBack"),
          );
          if (action == DialogActionState.Yes) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        }
      }
    } else {
      setState(() {
        _currentPage = index;
      });
    }
  }

  Widget _getPage() {
    switch (_currentPage) {
      case 0:
        return HomePage();
      case 1:
        return Categories();
      case 2:
        return Library();
      case 3:
        return Cart();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: PColors.darkBackground,
        appBar: PAppBar(
          children: <Widget>[
            Consumer<UserProvider>(
              builder: (BuildContext context, model, Widget child) => Text(
                model.nameSurname != null
                    ? FlutterI18n.translate(context, "Home.welcome") + model.nameSurname
                    : FlutterI18n.translate(context, "Home.welcome"),
                style: FontStyles.header(),
              ),
            )
          ],
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListing()));
              },
              child: Icon(PIcons.search),
            ),
            Consumer<UserProvider>(
              builder: (context, model, child) => IconButton(
                icon: Icon(
                  PIcons.more,
                  color: PColors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settings);
                },
              ),
            ),
          ],
        ),
        body: Padding(padding: EdgeInsets.fromLTRB(24, 32, 0, 0), child: _getPage()),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            backgroundColor: PColors.cardDark,
            iconSize: 50,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon((_currentPage == 0 ? PIcons.filledhomepage : PIcons.emptyhomepage)),
                title: Text(
                  FlutterI18n.translate(context, "Home.home"),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(_currentPage == 1 ? PIcons.filledcategory : PIcons.emptycategory),
                title: Text(
                  FlutterI18n.translate(context, "Home.categories"),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(_currentPage == 2 ? PIcons.filledbookmark : PIcons.emptybookmark),
                title: Text(
                  FlutterI18n.translate(context, "Home.library"),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(_currentPage == 3 ? PIcons.filledcart : PIcons.emptycart),
                title: Text(
                  FlutterI18n.translate(context, "Home.cart"),
                ),
              ),
            ],
            currentIndex: _currentPage,
            selectedItemColor: PColors.white,
            unselectedItemColor: PColors.blueGrey,
            onTap: (index) {
              _onItemTapped(index, model);
            },
          ),
        ),
      ),
    );
  }
}
