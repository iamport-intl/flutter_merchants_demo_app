import 'dart:async';
import 'dart:convert';
import 'package:portone_flutter_package/portone_services/portone_impl.dart';
import 'package:portone_flutter_package/dto/requests/add_customer_request.dart';
import 'package:portone_flutter_package/dto/requests/delete_card_request.dart';
import 'package:portone_flutter_package/dto/responses/add_card_for_customer_response.dart';
import 'package:portone_flutter_package/dto/responses/add_customer_response.dart';
import 'package:portone_flutter_package/dto/responses/bank_list_response.dart';
import 'package:portone_flutter_package/dto/responses/chanex_token_response.dart';
import 'package:portone_flutter_package/dto/responses/creditcard_details_response.dart';
import 'package:portone_flutter_package/dto/responses/direct_bank_transfer_details_response.dart';
import 'package:portone_flutter_package/dto/responses/generic_response.dart';
import 'package:portone_flutter_package/dto/responses/get_customer_data_response.dart';
import 'package:portone_flutter_package/dto/responses/get_otp_response.dart';
import 'package:portone_flutter_package/dto/responses/list_cards_for_customer_response.dart';
import 'package:portone_flutter_package/dto/responses/payment_method_response.dart';
import 'package:portone_flutter_package/dto/responses/routes_list_response.dart';
import 'package:portone_flutter_package/dto/responses/with_tokenization_response.dart';
import 'package:portone_flutter_package/dto/responses/without_tokenization_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_merchants_demo_app/requests.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PortOneApp());
  }
}

