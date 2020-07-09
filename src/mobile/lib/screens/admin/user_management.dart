import 'dart:async';

import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/search_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import 'detail_of_user.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagement createState() => _UserManagement();
}

class _UserManagement extends State<UserManagement> {
  final TextEditingController _textController = new TextEditingController();
  final FocusNode _searchFocusNode = new FocusNode();
  List<AdminGetUserDetailsOutputDTO> users = List();
  AdminProvider adminProvider;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      users = await adminProvider.getUsers(search: _textController.text);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "UserManagement.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      backgroundColor: PColors.darkBackground,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "UserManagement.search"),
              style: FontStyles.header(textColor: PColors.blueGrey),
            ),
            SizedBox(
              height: 12,
            ),
            Consumer<AdminProvider>(
              builder: (BuildContext context, AdminProvider model, Widget child) => SearchBar(
                placeholderText: FlutterI18n.translate(context, "UserManagement.placeholderSearch"),
                controller: _textController,
                focusNode: _searchFocusNode,
                requestFocus: _requestFocus,
                onChange: (search) async {
                  users = await model.getUsers(search: search);
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Consumer<AdminProvider>(
                builder: (context, model, child) => BaseWidget<AdminProvider>(
                  model: model,
                  onModelReady: () async {
                    adminProvider = model;
                    users = await model.getUsers();
                  },
                  builder: (context, model, child) => model.state != ServerState.Busy
                      ? users.length > 0
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return AdminListingCard(
                                  boxIcon: PIcons.account,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailOfUser(
                                            user: users[index],
                                            showSnackBar: showSnackBar,
                                          ),
                                        ));
                                  },
                                  children: <Widget>[
                                    Text(
                                      users[index].name,
                                      style: FontStyles.bigTextField(),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      users[index].email,
                                      style: FontStyles.textField(textColor: PColors.blueGrey),
                                    ),
                                    SizedBox(height: 4),
                                    users[index].phone != null
                                        ? Text(
                                            users[index].phone,
                                            style: FontStyles.text(textColor: PColors.blueGrey),
                                          )
                                        : Container()
                                  ],
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                FlutterI18n.translate(context, "UserManagement.searchError"),
                                textAlign: TextAlign.center,
                                style: FontStyles.text(),
                              ),
                            )
                      : Loading(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
