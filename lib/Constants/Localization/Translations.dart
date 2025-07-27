import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'language.dart';

class Translations {
  static Future<Translations> load(Locale locale) {
    final String name = (locale.countryCode != null && locale.countryCode!.isEmpty)
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((dynamic _) {
      Intl.defaultLocale = localeName;
      return new Translations();
    });
  }

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }


String get  CompanyNumber {
    return Intl.message(
      'CompanyNumber',
      name: 'CompanyNumber',
    );
  }
  String get  CompanyNumber_Validation {
    return Intl.message(
      'CompanyNumber_Validation',
      name: 'CompanyNumber_Validation',
    );
  }
  String get  Login_btn {
    return Intl.message(
      'Login_btn',
      name: 'Login_btn',
    );
  }
  String get  Lang {
    return Intl.message(
      'Lang',
      name: 'Lang',
    );
  }
  String get ErrorTitle {
    return Intl.message(
      'ErrorTitle',
      name: 'errorTitle',
    );
  }
  String get ErrorDes {
    return Intl.message(
      'ErrorDes',
      name: 'errorDes',
    );
  }
  String get CheckInternet {
    return Intl.message(
      'CheckInternet',
      name: 'checkInternet',
    );
  }
  String get Please {
    return Intl.message(
      'Please',
      name: 'please',
    );
  }
  String get LastVersion {
    return Intl.message(
      'LastVersion',
      name: 'lastVersion',
    );
  }
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'ok',
    );
  }
  String get Password_Validation {
    return Intl.message(
      'Password_Validation',
      name: 'password_Validation',
    );
  }
  String get Email_Validation {
    return Intl.message(
      'Email_Validation',
      name: 'email_Validation',
    );
  }
  String get Password {
    return Intl.message(
      'Password',
      name: 'password',
    );
  }
  String get Email {
    return Intl.message(
      'Email',
      name: 'email',
    );
  }
  String get Home {
    return Intl.message(
      'Home',
      name: 'home_page',
    );
  }  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
    );
  } String get NoData {
    return Intl.message(
      'NoData',
      name: 'noData',
    );
  }String get Orders {
    return Intl.message(
      'Orders',
      name: 'orders',
    );
  }
  String get Orders_now {
    return Intl.message(
      'Orders_now',
      name: 'order_now',
    );
  }
  String get Orders_later {
    return Intl.message(
      'Orders_later',
      name: 'order_later',
    );
  }
  String get Orders_end {
    return Intl.message(
      'Orders_end',
      name: 'order_end',
    );
  }
  String get Order_num {
    return Intl.message(
      'Order_num',
      name: 'order_num',
    );
  }
  String get date {
    return Intl.message(
      'date',
      name: 'date',
    );
  }
  String get time {
    return Intl.message(
      'time',
      name: 'time',
    );
  }
  String get load_attachment {
    return Intl.message(
      'load_attachment',
      name: 'load_attachment',
    );
  }
  String get aramco_attachment {
    return Intl.message(
      'aramco_attachment',
      name: 'aramco_attachment',
    );
  }
  String get delivery_attachment {
    return Intl.message(
      'delivery_attachment',
      name: 'delivery_attachment',
    );
  }
  String get load_location {
    return Intl.message(
      'load_location',
      name: 'load_location',
    );
  }
  String get delivery_location {
    return Intl.message(
      'delivery_location',
      name: 'delivery_location',
    );
  }
  String get send_request {
    return Intl.message(
      'send_request',
      name: 'send_request',
    );
  }  String get show {
    return Intl.message(
      'show',
      name: 'show',
    );
  }
  String get no {
    return Intl.message(
      'no',
      name: 'no',
    );
  }
  String get okey {
    return Intl.message(
      'okey',
      name: 'okey',
    );
  }  String get success {
    return Intl.message(
      'success',
      name: 'success',
    );
  }
  String get sure {
    return Intl.message(
      'sure',
      name: 'sure',
    );
  } String get Expenses {
    return Intl.message(
      'Expenses',
      name: 'Expenses',
    );
  }
  String get ExpensesKind {
    return Intl.message(
      'ExpensesKind',
      name: 'ExpensesKind',
    );
  }
  String get amount {
    return Intl.message(
      'amount',
      name: 'amount',
    );
  }
  String get please {
    return Intl.message(
      'please',
      name: 'please',
    );
  }
  String get vaildNum {
    return Intl.message(
      'vaildNum',
      name: 'vaildNum',
    );
  }  String get ExpensesAdd {
    return Intl.message(
      'ExpensesAdd',
      name: 'ExpensesAdd',
    );
  }String get invoice_attachment {
    return Intl.message(
      'invoice_attachment',
      name: 'invoice_attachment',
    );
  }String get language {
    return Intl.message(
      'language',
      name: 'language',
    );
  }String get save_request {
    return Intl.message(
      'save_request',
      name: 'save_request',
    );
  }
  String get end_request {
    return Intl.message(
      'end_request',
      name: 'end_request',
    );
  } String get aramco_add_attachment {
    return Intl.message(
      'aramco_add_attachment',
      name: 'aramco_add_attachment',
    );
  }
  String get delivery_add_attachment {
    return Intl.message(
      'delivery_add_attachment',
      name: 'delivery_add_attachment',
    );
  }  String get enterData {
    return Intl.message(
      'enterData',
      name: 'enterData',
    );
  }String get notification {
    return Intl.message(
      'notification',
      name: 'notification',
    );
  }
}
