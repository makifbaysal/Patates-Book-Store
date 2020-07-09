import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/atoms/search_bar.dart';
import 'package:app/design_system/atoms/selectable_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/pdialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  final List<String> categories;
  final List<String> languages;
  final int highestPage;
  final int lowestPage;
  final int lowestPrice;
  final int highestPrice;
  final String search;
  final Function setFilters;

  FilterPage({this.categories, this.languages, this.highestPage, this.lowestPage, this.lowestPrice, this.highestPrice, this.search, this.setFilters});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode searchFocus = new FocusNode();
  Map<String, String> languageCodes = {
    "tr": "ProductLanguages.turkish",
    "en": "ProductLanguages.english",
    "de": "ProductLanguages.german",
    "ar": "ProductLanguages.arabic",
    "es": "ProductLanguages.spanish"
  };

  //Filter variables
  Map<String, bool> languages = {
    "ProductLanguages.turkish": false,
    "ProductLanguages.english": false,
    "ProductLanguages.german": false,
    "ProductLanguages.spanish": false,
    "ProductLanguages.arabic": false
  };

  int highestPage = 3000;
  int lowestPage = 0;
  int lowestPrice = 0;
  int highestPrice = 700;

  List<String> categories = new List();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void initState() {
    if (widget.languages.length > 0) {
      widget.languages.forEach((language) {
        languages[languageCodes[language]] = true;
      });
    }
    if (widget.categories.length > 0) {
      categories = widget.categories;
    }
    if (widget.search != null) {
      _searchController.text = widget.search;
    }
    if (widget.lowestPrice != null && widget.highestPrice != null) {
      lowestPrice = widget.lowestPrice;
      highestPrice = widget.highestPrice;
    }
    if (widget.lowestPage != null && widget.highestPage != null) {
      lowestPage = widget.lowestPage;
      highestPage = widget.highestPage;
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    searchFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Filter.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(FlutterI18n.translate(context, "Filter.filterWithWord"), style: FontStyles.header(textColor: PColors.blueGrey)),
                SizedBox(height: 12),
                SearchBar(
                  placeholderText: FlutterI18n.translate(context, "Filter.search"),
                  requestFocus: _requestFocus,
                  focusNode: searchFocus,
                  controller: _searchController,
                ),
                SizedBox(height: 20),
                Text(FlutterI18n.translate(context, "Filter.language"), style: FontStyles.header(textColor: PColors.blueGrey)),
                SizedBox(height: 12),
                Wrap(
                    runSpacing: 8,
                    children: languages.keys.toList().map((language) {
                      return SelectableBox(
                        text: FlutterI18n.translate(context, language),
                        isSelected: languages[language],
                        onPressed: () {
                          if (languages[language]) {
                            languages[language] = false;
                          } else {
                            languages[language] = true;
                          }
                          setState(() {});
                        },
                      );
                    }).toList()),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "Filter.category"), style: FontStyles.header(textColor: PColors.blueGrey)),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            List<String> categoryList = List();
                            return PDialog(
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "Filter.category"), style: FontStyles.bigTextField()),
                                SizedBox(
                                  height: 24,
                                ),
                                Consumer<ProductProvider>(
                                  builder: (context, model, child) => BaseWidget<ProductProvider>(
                                    model: model,
                                    onModelReady: () async {
                                      model.getCategories().then((categoryMap) {
                                        model.setState(ServerState.Busy);
                                        categoryList = categoryMap.keys.toList();
                                        model.setState(ServerState.Success);
                                      });
                                    },
                                    builder: (context, model, child) => model.state != ServerState.Busy
                                        ? ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: categoryList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) => MaterialButton(
                                              onPressed: () {
                                                model.setState(ServerState.Busy);
                                                if (categories.contains(categoryList[index])) {
                                                  categories.remove(categoryList[index]);
                                                } else {
                                                  categories.add(categoryList[index]);
                                                }
                                                model.setState(ServerState.Success);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 50,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Center(
                                                      child: Text(
                                                        categoryList[index],
                                                        style: FontStyles.textField(),
                                                      ),
                                                    ),
                                                    categories.contains(categoryList[index])
                                                        ? Icon(
                                                            Icons.check,
                                                            color: PColors.blueGrey,
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Loading(),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: PColors.blueGrey,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                categories.length > 0
                    ? Wrap(
                        runSpacing: 8,
                        children: categories.map((category) {
                          return SelectableBox(
                            text: category,
                            isSelected: true,
                            onPressed: () {
                              categories.remove(category);
                              setState(() {});
                            },
                          );
                        }).toList(),
                      )
                    : Text(
                        FlutterI18n.translate(context, "Filter.noCategory"),
                        style: FontStyles.textField(),
                      ),
                SizedBox(height: 20),
                Text(FlutterI18n.translate(context, "ProductAdd.pageNumberHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                SizedBox(height: 20),
                FlutterSlider(
                  handlerAnimation: FlutterSliderHandlerAnimation(
                    curve: Curves.elasticOut,
                    duration: Duration(milliseconds: 50),
                  ),
                  trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                      ),
                      inactiveTrackBar: BoxDecoration(
                        color: PColors.blueGrey,
                      )),
                  rightHandler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("")),
                  handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("")),
                  handlerHeight: 15,
                  handlerWidth: 15,
                  values: [lowestPage.toDouble(), highestPage.toDouble()],
                  rangeSlider: true,
                  max: 3000,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    lowestPage = lowerValue.toInt();
                    highestPage = upperValue.toInt();
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                Text(FlutterI18n.translate(context, "ProductAdd.priceHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                SizedBox(height: 20),
                FlutterSlider(
                  handlerAnimation:
                      FlutterSliderHandlerAnimation(curve: Curves.elasticOut, reverseCurve: null, duration: Duration(milliseconds: 700), scale: 1.4),
                  trackBar: FlutterSliderTrackBar(
                      activeTrackBar: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                      ),
                      inactiveTrackBar: BoxDecoration(
                        color: PColors.blueGrey,
                      )),
                  rightHandler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("")),
                  handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                        color: PColors.new_primary_button_b_y_ire_m,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text("")),
                  values: [lowestPrice.toDouble(), highestPrice.toDouble()],
                  handlerHeight: 15,
                  handlerWidth: 15,
                  rangeSlider: true,
                  max: 700,
                  min: 0,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    lowestPrice = lowerValue.toInt();
                    highestPrice = upperValue.toInt();
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    PButton(
                      color: PColors.new_primary_button_b_y_ire_m,
                      text: FlutterI18n.translate(context, "Filter.apply"),
                      onPressed: () {
                        List<String> langs = List();
                        languages.keys.toList().forEach((language) {
                          if (languages[language]) {
                            languageCodes.keys.toList().forEach((code) {
                              if (languageCodes[code] == language) {
                                langs.add(code);
                              }
                            });
                          }
                        });
                        widget.setFilters(_searchController.text, langs, categories, lowestPage, highestPage, lowestPrice, highestPrice);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
