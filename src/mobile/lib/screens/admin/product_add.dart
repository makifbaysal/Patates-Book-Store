import 'dart:io';

import 'package:app/design_system/atoms/admin/add_photo_card.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

// ignore: must_be_immutable
class ProductAdd extends StatefulWidget {
  final String productID;
  bool isEditable;
  final Function(String) showSnackBar;

  ProductAdd({Key key, this.productID, this.isEditable = false, this.showSnackBar}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _pageNumberController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _aboutBookController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  File imageFile;
  String imgURL;
  bool _autoValidate = false;
  String language;

  FocusNode bookNameFocusNode = new FocusNode();
  FocusNode authorFocusNode = new FocusNode();
  FocusNode priceFocusNode = new FocusNode();
  FocusNode pageNumberFocusNode = new FocusNode();
  FocusNode categoryFocusNode = new FocusNode();
  FocusNode aboutBookFocusNode = new FocusNode();
  FocusNode stockFocusNode = new FocusNode();
  ProductDetailOutputDTO productDetail;

  GlobalKey<FormState> formKey = new GlobalKey();
  List<String> categories = new List();
  Map<String, String> languages = {
    "tr": "ProductLanguages.turkish",
    "en": "ProductLanguages.english",
    "de": "ProductLanguages.german",
    "ar": "ProductLanguages.arabic",
    "es": "ProductLanguages.spanish"
  };

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _bookNameController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    _pageNumberController.dispose();
    _categoryController.dispose();
    _aboutBookController.dispose();
    _stockController.dispose();

    bookNameFocusNode.dispose();
    authorFocusNode.dispose();
    priceFocusNode.dispose();
    pageNumberFocusNode.dispose();
    categoryFocusNode.dispose();
    aboutBookFocusNode.dispose();
    stockFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        leading: widget.isEditable && widget.productID != null
            ? IconButton(
                onPressed: () {
                  _bookNameController.text = productDetail.name;
                  _authorController.text = productDetail.author;
                  _priceController.text = productDetail.price.toString();
                  _pageNumberController.text = productDetail.page.toString();
                  _stockController.text = productDetail.stock.toString();
                  language = productDetail.language.toString();
                  categories = productDetail.category;
                  _aboutBookController.text = productDetail.description;
                  imgURL = productDetail.imageUrl;
                  setState(() {
                    widget.isEditable = false;
                  });
                },
                icon: Icon(Icons.clear),
              )
            : null,
        children: <Widget>[
          Text(
              FlutterI18n.translate(
                context,
                widget.isEditable ? widget.productID == null ? "ProductAdd.header" : "ProductAdd.updateProduct" : "ProductShow.header",
              ),
              style: FontStyles.header())
        ],
        actions: widget.isEditable
            ? <Widget>[
                Consumer<ProductProvider>(
                  builder: (BuildContext context, model, child) => IconButton(
                    onPressed: model.state != ServerState.Busy
                        ? () async {
                            if (formKey.currentState.validate()) {
                              if (widget.productID != null) {
                                var updateProductInputDTO = UpdateProductInputDTO();
                                updateProductInputDTO.id = widget.productID;
                                updateProductInputDTO.name = _bookNameController.text;
                                updateProductInputDTO.author = _authorController.text;
                                updateProductInputDTO.price = double.parse(_priceController.text);
                                updateProductInputDTO.page = int.parse(_pageNumberController.text);
                                updateProductInputDTO.stock = int.parse(_stockController.text);
                                updateProductInputDTO.language = language;
                                updateProductInputDTO.description = _aboutBookController.text;
                                updateProductInputDTO.category = categories;
                                await model.updateProduct(updateProductInputDTO);
                                if (model.state == ServerState.Success) {
                                  if (imageFile != null) {
                                    await model.updateProductImage(widget.productID, imageFile);
                                  }
                                }
                                if (model.state == ServerState.Success) {
                                  setState(() {
                                    widget.isEditable = false;
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "ProductAdd.successUpdate"),
                                  )));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "ProductAdd.errorUpdate"),
                                  )));
                                }
                              } else {
                                if (imageFile != null) {
                                  await model.addProduct(
                                    _aboutBookController.text,
                                    double.parse(_priceController.text),
                                    categories,
                                    _bookNameController.text,
                                    _authorController.text,
                                    language,
                                    int.parse(_stockController.text),
                                    int.parse(_pageNumberController.text),
                                    imageFile,
                                  );
                                  if (model.state == ServerState.Success) {
                                    Navigator.pop(context);
                                    widget.showSnackBar("ProductAdd.successAdd");
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          FlutterI18n.translate(context, "ProductAdd.warning"),
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        FlutterI18n.translate(context, "ProductAdd.photoWarning"),
                                      ),
                                    ),
                                  );
                                }
                              }
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          }
                        : null,
                    icon: Icon(PIcons.save),
                  ),
                )
              ]
            : <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isEditable = true;
                    });
                  },
                  icon: Icon(PIcons.edit, color: PColors.white, size: 25),
                ),
                Consumer<ProductProvider>(
                  builder: (context, model, child) => IconButton(
                    onPressed: () async {
                      final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "ProductAdd.askDeleteProduct"),
                          FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                          color: PColors.red);
                      if (action == DialogActionState.Yes) {
                        await model.deleteProduct(widget.productID);
                        if (model.state == ServerState.Success) {
                          Navigator.pop(context);
                          widget.showSnackBar("ProductAdd.successDelete");
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            FlutterI18n.translate(context, "ProductAdd.errorDelete"),
                          )));
                        }
                      }
                    },
                    icon: Icon(PIcons.delete, color: PColors.red, size: 25),
                  ),
                )
              ],
      ),
      body: Consumer2<ProductProvider, UserProvider>(
        builder: (context, productProvider, userProvider, child) => BaseWidget<ProductProvider>(
          model: productProvider,
          onModelReady: () async {
            if (widget.productID != null) {
              productDetail = await productProvider.getProductDetail(productId: widget.productID, userId: userProvider.userId);
              if (productProvider.state == ServerState.Success) {
                _bookNameController.text = productDetail.name;
                _authorController.text = productDetail.author;
                _priceController.text = productDetail.price.toStringAsFixed(2);
                _pageNumberController.text = productDetail.page.toString();
                _stockController.text = productDetail.stock.toString();
                language = productDetail.language.toString();
                categories = productDetail.category;
                _aboutBookController.text = productDetail.description;
                imgURL = productDetail.imageUrl;
                setState(() {});
              }
            }
          },
          builder: (context, model, child) => productProvider.state != ServerState.Busy
              ? Form(
                  key: formKey,
                  autovalidate: _autoValidate,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: AddPhotoCard(
                                isEditable: widget.isEditable,
                                onPressed: () async {
                                  var img = await ImagePicker.pickImage(source: ImageSource.camera);
                                  setState(() {
                                    imageFile = img;
                                  });
                                },
                                image: imageFile,
                                imageURL: imgURL,
                                icon: PIcons.addpicture),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(FlutterI18n.translate(context, "ProductAdd.bookHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _bookNameController,
                                  focusNode: bookNameFocusNode,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderBook"),
                                  onPressed: () {},
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "ProductAdd.placeholderBook");
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 28),
                                Text(FlutterI18n.translate(context, "ProductAdd.authorHeader"),
                                    style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _authorController,
                                  focusNode: authorFocusNode,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderAuthor"),
                                  onPressed: () {},
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "ProductAdd.placeholderAuthor");
                                    else
                                      return null;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      /* PRICE && PAGE NUMBER ROW */
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              /* Fiyat Ekleme */
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "ProductAdd.priceHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(
                                  height: 8,
                                ),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _priceController,
                                  focusNode: priceFocusNode,
                                  requestFocus: _requestFocus,
                                  keyboardType: TextInputType.number,
                                  placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderPrice"),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "ProductAdd.placeholderPrice");
                                    else if (double.parse(value) == 0) {
                                      return FlutterI18n.translate(context, "ProductAdd.priceGreaterThanZero");
                                    } else
                                      return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "ProductAdd.pageNumberHeader"),
                                    style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _pageNumberController,
                                  focusNode: pageNumberFocusNode,
                                  requestFocus: _requestFocus,
                                  keyboardType: TextInputType.number,
                                  placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderPageNumber"),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "ProductAdd.placeholderPageNumber");
                                    else if (int.parse(value) == 0)
                                      return FlutterI18n.translate(context, "ProductAdd.pageNotEqualToZero");
                                    else
                                      return null;
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "ProductAdd.stockHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _stockController,
                                  focusNode: stockFocusNode,
                                  keyboardType: TextInputType.number,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderStock"),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "ProductAdd.placeholderStock");
                                    else
                                      return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "ProductAdd.languageHeader"),
                                    style: FontStyles.header(textColor: PColors.blueGrey)),
                                SizedBox(
                                  height: 8,
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintText: FlutterI18n.translate(context, "Select"),
                                    fillColor: PColors.cardDark,
                                    filled: true,
                                    errorStyle: FontStyles.smallText(),
                                    hintStyle: FontStyles.textField(),
                                    border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(color: PColors.cardDark)),
                                    focusedBorder: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(15),
                                        ),
                                        borderSide: BorderSide(color: PColors.cardDark)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 6.0),
                                  ),
                                  isExpanded: true,
                                  value: language,
                                  icon: widget.isEditable
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: PColors.blueGrey,
                                        )
                                      : Container(),
                                  style: FontStyles.textField(textColor: PColors.white),
                                  validator: (value) => value == null ? FlutterI18n.translate(context, "ProductAdd.placeholderLanguage") : null,
                                  items: languages.keys.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(FlutterI18n.translate(context, languages[value])),
                                    );
                                  }).toList(),
                                  disabledHint: Text(
                                    language != null ? FlutterI18n.translate(context, languages[language]) : FlutterI18n.translate(context, "Select"),
                                    style: FontStyles.textField(textColor: PColors.white),
                                  ),
                                  onChanged: widget.isEditable
                                      ? (value) {
                                          setState(() {
                                            language = value;
                                          });
                                        }
                                      : null,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(FlutterI18n.translate(context, "ProductAdd.categoryHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                          SizedBox(height: 8),
                          Container(
                            height: 28,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: widget.isEditable
                                      ? () {
                                          setState(() {
                                            categories.removeAt(index);
                                          });
                                        }
                                      : null,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Constants.colors[index % Constants.colors.length],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    child: Row(
                                      children: <Widget>[
                                            Text(
                                              categories[index],
                                              style: FontStyles.smallText(textColor: PColors.white),
                                            ),
                                          ] +
                                          (widget.isEditable
                                              ? <Widget>[
                                                  SizedBox(width: 4),
                                                  Icon(Icons.close, size: 12, color: PColors.white),
                                                ]
                                              : []),
                                    ),
                                  ),
                                );
                              },
                              itemCount: categories.length,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          SizedBox(height: 8),
                          widget.isEditable
                              ? Container(
                                  child: PTextField(
                                    onPressed: categories.length < 3
                                        ? () {
                                            if (_categoryController.text.length >= 3) {
                                              var txt = _categoryController.text.titleCase;
                                              categories.add(txt);
                                              _categoryController.clear();
                                              setState(() {});
                                            }
                                          }
                                        : null,
                                    suffixIcon: categories.length < 3 ? Icons.done : null,
                                    enabled: categories.length < 3,
                                    maxLine: 1,
                                    controller: _categoryController,
                                    focusNode: categoryFocusNode,
                                    requestFocus: _requestFocus,
                                    placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderCategory"),
                                    validator: (value) {
                                      if (categories.length > 0) {
                                        return null;
                                      } else if (categories.length > 3) {
                                        return FlutterI18n.translate(context, "ProductAdd.categoryWarningMax");
                                      } else {
                                        return FlutterI18n.translate(context, "ProductAdd.categoryWarningMin");
                                      }
                                    },
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(FlutterI18n.translate(context, "ProductAdd.aboutBookHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                          SizedBox(height: 8),
                          PTextField(
                            enabled: widget.isEditable,
                            maxLine: 5,
                            controller: _aboutBookController,
                            focusNode: aboutBookFocusNode,
                            requestFocus: _requestFocus,
                            placeholderText: FlutterI18n.translate(context, "ProductAdd.placeholderAboutBook"),
                            validator: (String value) {
                              if (value.isEmpty)
                                return FlutterI18n.translate(context, "ProductAdd.placeholderAboutBook");
                              else
                                return null;
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )
              : Loading(),
        ),
      ),
    );
  }
}
