import 'package:app/screens/Admin/coupon_add.dart';
import 'package:app/screens/Admin/coupon_management.dart';
import 'package:app/screens/Admin/detail_of_coupon.dart';
import 'package:app/screens/Admin/detail_of_shipping_company.dart';
import 'package:app/screens/Admin/detail_of_user.dart';
import 'package:app/screens/Admin/home.dart';
import 'package:app/screens/Admin/product_management.dart';
import 'package:app/screens/Admin/shipping_company_add.dart';
import 'package:app/screens/Admin/shipping_company_management.dart';
import 'package:app/screens/admin/account.dart';
import 'package:app/screens/admin/customer_details.dart';
import 'package:app/screens/admin/detail_of_order.dart';
import 'package:app/screens/admin/message_management.dart';
import 'package:app/screens/admin/order_management.dart';
import 'package:app/screens/admin/sale_reports.dart';
import 'package:app/screens/admin/user_management.dart';
import 'package:app/screens/comment.dart';
import 'package:app/screens/comments.dart';
import 'package:app/screens/compare_book.dart';
import 'package:app/screens/confirm_order.dart';
import 'package:app/screens/filter_page.dart';
import 'package:app/screens/home/home.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/order_address.dart';
import 'package:app/screens/order_cart.dart';
import 'package:app/screens/order_details.dart';
import 'package:app/screens/order_summary.dart';
import 'package:app/screens/product_details.dart';
import 'package:app/screens/product_listing.dart';
import 'package:app/screens/settings/about.dart';
import 'package:app/screens/settings/account.dart';
import 'package:app/screens/settings/address_details.dart';
import 'package:app/screens/settings/addresses.dart';
import 'package:app/screens/settings/comments.dart';
import 'package:app/screens/settings/contact.dart';
import 'package:app/screens/settings/coupon_codes.dart';
import 'package:app/screens/settings/faq.dart';
import 'package:app/screens/settings/help.dart';
import 'package:app/screens/settings/language.dart';
import 'package:app/screens/settings/my_cards.dart';
import 'package:app/screens/settings/notifications.dart';
import 'package:app/screens/settings/order_details.dart';
import 'package:app/screens/settings/orders.dart';
import 'package:app/screens/settings/settings.dart';
import 'package:app/screens/settings/settings_settings.dart';
import 'package:app/screens/settings/update_password.dart';
import 'package:app/screens/sign_up.dart';
import 'package:app/screens/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static String get splash => "/";

  static String get home => "/home";

  static String get settings => "/settings";

  static String get settingsSettings => "/settingsSettings";

  static String get settingsAccount => "/settingsAccount";

  static String get settingsHelp => "/settingsHelp";

  static String get settingsContact => "/settingsContact";

  static String get settingsFaq => "/settingsFaq";

  static String get settingsAbout => "/settingsAbout";

  static String get settingsOrders => "/settingsOrders";

  static String get settingsOrderDetails => "/settingsOrderDetails";

  static String get settingsAddresses => "/settingsAddresses";

  static String get settingsAddressDetails => "/settingsAddressDetails";

  static String get settingsComments => "/settingsComments";

  static String get myCards => "/myCards";

  static String get settingsUpdatePassword => "/settingsUpdatePassword";

  static String get settingsNotifications => "/settingsNotifications";

  static String get settingsLanguage => "/settingsLanguage";

  static String get comment => "/comment";

  static String get settingsCouponCodes => "/settingsCouponCodes";

  static String get login => "/login";

  static String get signUp => "/signUp";

  static String get productListing => "/productListing";

  static String get filterPage => "/filterPage";

  static String get productDetails => "/productDetails";

  static String get comments => "/comments";

  static String get orderDetails => "/orderDetails";

  static String get orderAddress => "/orderAddress";

  static String get orderCart => "/orderCart";

  static String get confirmOrder => "/confirmOrder";

  static String get orderSummary => "/orderSummary";

  static String get compareBook => "/compareBook";

  static Admin get admin => Admin();
}

class Admin {
  String adminHome = "/adminHome";
  String saleReports = "/saleReports";
  String productManagement = "/productManagement";
  String shippingCompanyManagement = "/shippingCompanyManagement";
  String shippingCompanyAdd = "/addShippingCompany";
  String orderManagement = "/orderManagement";
  String detailOfOrder = "/detailOfOrder";
  String userManagement = "/userManagement";
  String detailOfUser = "/detailOfUser";
  String couponManagement = "/couponManagement";
  String detailOfCoupon = "/detailOfCoupon";
  String editCoupon = "/editCoupon";
  String addCoupon = "/addCoupon";
  String couponAdd = "/couponAdd";
  String detailOfShippingCompany = "/detailOfShippingCompany";
  String messageManagement = "/messageManagement";
  String account = "/admin";
  String customerDetails = "/customerDetails";
}

Map<String, Widget> routes = {
  Routes.splash: Splash(),
  Routes.home: Home(),
  Routes.settings: Settings(),
  Routes.settingsSettings: SettingsSettings(),
  Routes.settingsAccount: SettingsAccount(),
  Routes.settingsHelp: SettingsHelp(),
  Routes.settingsContact: SettingsContact(),
  Routes.settingsFaq: SettingsFaq(),
  Routes.settingsAbout: SettingsAbout(),
  Routes.settingsOrders: SettingsOrders(),
  Routes.settingsOrderDetails: SettingsOrderDetails(),
  Routes.settingsAddresses: SettingsAddresses(),
  Routes.settingsAddressDetails: SettingsAddressDetails(),
  Routes.settingsComments: SettingsComments(),
  Routes.settingsUpdatePassword: SettingsUpdatePassword(),
  Routes.settingsNotifications: SettingsNotifications(),
  Routes.settingsLanguage: SettingsLanguage(),
  Routes.comment: Comment(),
  Routes.settingsCouponCodes: SettingsCouponCodes(),
  Routes.login: Login(),
  Routes.signUp: SignUp(),
  Routes.productListing: ProductListing(),
  Routes.filterPage: FilterPage(),
  Routes.productDetails: ProductDetails(),
  Routes.comments: Comments(),
  Routes.orderDetails: OrderDetails(),
  Routes.orderAddress: OrderAddress(),
  Routes.orderCart: OrderCart(),
  Routes.confirmOrder: ConfirmOrder(),
  Routes.orderSummary: OrderSummary(),
  Routes.compareBook: CompareBook(),
  Routes.myCards: MyCards(),
  Routes.admin.adminHome: AdminHome(),
  Routes.admin.saleReports: SaleReports(),
  Routes.admin.productManagement: ProductManagement(),
  Routes.admin.shippingCompanyManagement: ShippingCompanyManagement(),
  Routes.admin.shippingCompanyAdd: ShippingCompanyAdd(),
  Routes.admin.orderManagement: OrderManagement(),
  Routes.admin.detailOfOrder: DetailOfOrder(),
  Routes.admin.userManagement: UserManagement(),
  Routes.admin.detailOfUser: DetailOfUser(),
  Routes.admin.couponManagement: CouponManagement(),
  Routes.admin.detailOfCoupon: DetailOfCoupon(),
  Routes.admin.couponManagement: CouponManagement(),
  Routes.admin.couponAdd: CouponAdd(),
  Routes.admin.detailOfShippingCompany: DetailOfShippingCompany(),
  Routes.admin.messageManagement: MessageManagement(),
  Routes.admin.account: AdminAccount(),
  Routes.admin.customerDetails: AdminCustomerDetails(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) => routes[settings.name],
  );
}
