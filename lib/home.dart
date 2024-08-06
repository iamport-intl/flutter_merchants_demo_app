import 'dart:async';
import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:portone_flutter_package/portone_services/portone_impl.dart';
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
      this.paymentStatus = jsonEncode(paymentStatus);
      setState(() {});
      print('CHAI_PaymentStatus-> $json');
    });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      portone.processPaymentStatus(uri.toString(), "sandbox");
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Center(child: Text('PortOne')),
          ),
          body: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: OutlinedButton(
                      onPressed: () {
                        portone.checkoutUsingWeb(requests.getJWTToken(),
                            requests.portoneKey, requests.getRequestBody());
                      },
                      child: const Text('Pay Now'))),
              const SizedBox(height: 20.0),
              Text(
                paymentStatus.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ));
  }
}
