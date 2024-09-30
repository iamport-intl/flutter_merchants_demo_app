import 'dart:async';
import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:portone_flutter_package/dto/requests/add_customer_request.dart';
import 'package:portone_flutter_package/dto/requests/delete_card_request.dart';
import 'package:portone_flutter_package/portone_services/portone_impl.dart';
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

class PortOneApp extends StatefulWidget {
  const PortOneApp({super.key});

  @override
  State<PortOneApp> createState() => _PortOneAppState();
}

class _PortOneAppState extends State<PortOneApp> {
  String environment = "sandbox";
  late PortOneImpl portone;
  String? paymentStatus;
  Requests requests = Requests();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
    portone = PortOneImpl(context, environment);

    portone.setPaymentStatusListener(
        callback: (Map<String, dynamic> paymentStatus) {
      final json = jsonEncode(paymentStatus);
      print('CHAI_PaymentStatus-> $json');
    });
    portone.setOtpListener(callback: (GetOtpResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setPaymentMethodsListener(
        callback: (PaymentMethodResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setSavedCardsListener(
        callback: (CreditCardDetailsResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setCheckoutWithTokenizationListener(
        callback: (WithTokenizationResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setCheckoutWithoutTokenizationListener(
        callback: (WithoutTokenizationResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setTokenCallBackListener(callback: (ChanexTokenResponse response) {
      final json = jsonEncode(response);
      print('CHAI_Response-> $response--> $json');
    });
    portone.setPaymentLinkListener(callback: (String paymentLink) {
      print('CHAI_PaymentLink-> $paymentLink');
    });
    portone.setBankListListener(callback: (BankListResponse response) {
      final json = jsonEncode(response);
      print('CHAI_BankList-> $json');
    });
    portone.setDBTDetailsListener(callback: (DBTDetailsResponse response) {
      final json = jsonEncode(response);
      print('CHAI_DBTDetails-> $json');
    });

    portone.setAddCustomerListener(callback: (AddCustomerResponse response) {
      final json = jsonEncode(response);
      print('CHAI_AddCustomer-> $json');
    });

    portone.setGetCustomerDataListener(
        callback: (GetCustomerDataResponse response) {
      final json = jsonEncode(response);
      print('CHAI_GetCustomer-> $json');
    });

    portone.setListCardsForCustomerListener(
        callback: (ListCardsForCustomerResponse response) {
      final json = jsonEncode(response);
      print('CHAI_ListCustomer-> $json');
    });

    portone.setAddCardForCustomerListener(
        callback: (AddCardForCustomerResponse response) {
      final json = jsonEncode(response);
      print('CHAI_AddCard-> $json');
    });

    portone.setDeleteCardForCustomerListener(
        callback: (GenericResponse response) {
      final json = jsonEncode(response);
      print('CHAI_DeleteCard-> $json');
    });

    portone.setCaptureTransactionListener(callback: (GenericResponse response) {
      final json = jsonEncode(response);
      print('CHAI_CapturedTransaction-> $json');
    });

    portone.setRoutesListListener(callback: (RoutesListResponse response) {
      final json = jsonEncode(response);
      print('CHAI_RoutesList-> $json');
    });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PortOne',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              backgroundColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              shadowColor: Colors.white.withOpacity(0.6),
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            title: const Center(
                child: Text(
              'PortOne',
              style: TextStyle(color: Colors.white),
            )),
          ),
          body: Container(
            color: Colors.black,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          portone.checkoutUsingEmbed(requests.getJWTToken(),
                              requests.portoneKey, requests.getCheckoutEmbedRequest());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Checkout \nEmbed',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        )),
                    OutlinedButton(
                        onPressed: () {
                          portone.getOTP(requests.mobileNo);
                          portone.getPaymentMethods(
                              requests.portoneKey, requests.currency, null);
                          portone.getSavedCards("", requests.portoneKey,
                              requests.mobileNo, "278058");
                          portone.checkoutWithTokenization(
                              requests.getTokenizationRequest(), null);
                          portone.checkoutWithoutTokenization(
                              requests.getWithoutTokenizationRequest(), null);
                          portone.checkoutUsingNewCard(
                              requests.getTokenizationRequest(),
                              requests.getChanexTokenRequest(),
                              requests.getJWTToken());
                          portone.checkoutUsingDirectBankTransfer(
                              requests
                                  .getCheckoutWithDirectBankTransferRequest(),
                              null);
                          portone.checkoutUsingInstallation(
                              requests.getCheckoutWithInstallationRequest(),
                              null);
                          portone.getBankList(requests.paymentChannel,
                              requests.getBankListRequest());
                          portone.getDBTDetails(requests.portoneKey);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Checkout \nConnect',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                    onPressed: () {
                      portone.addCustomer(
                          requests.getJWTToken(),
                          requests.portoneKey,
                          AddCustomerRequest(
                              name: "Aagam",
                              customerRef: "",
                              emailAddress: "",
                              phoneNumber: requests.mobileNo));
                      portone.getCustomer(requests.getJWTToken(),
                          requests.portoneKey, requests.customerUUID);
                      portone.addCardForCustomer(
                          requests.customerUUID,
                          requests.getJWTToken(),
                          requests.portoneKey,
                          requests.getChanexTokenRequest(),
                          null);
                      portone.listCardsForCustomer(requests.customerUUID,
                          requests.getJWTToken(), requests.portoneKey);
                      portone.deleteCardForCustomer(
                          requests.customerUUID,
                          requests.getJWTToken(),
                          requests.portoneKey,
                          DeleteCardRequest(
                              token: "735eaf72a0a14965aced3e1f9a339b0b"));
                      portone.captureTransaction("2SDCUiBEv34oqeIdEDv1pftGeeY",
                          requests.getJWTToken(), requests.portoneKey);
                      portone.getRoutesList(
                          requests.portoneKey, requests.getJWTToken());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Additional \nMethods',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    )),
                const SizedBox(height: 20.0),
                Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 5, // The blur radius
                        offset: Offset(0, 3), // Offset in x and y direction (horizontal, vertical)
                      ),
                    ],
                    shape: BoxShape
                        .rectangle, // Set the shape to rectangle (default)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          paymentStatus ??
                              "Payment Status to be displayed here. ",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
