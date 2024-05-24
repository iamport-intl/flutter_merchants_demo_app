import 'dart:convert' show Utf8Encoder, base64Encode;
import 'package:crypto/crypto.dart';
import '../requests.dart';

class SignatureHash {
  String getSignatureHash(
      {required String amount,
      required String currency,
      required String failureUrl,
      required String orderId,
      required String portoneKey,
      required String successUrl}) {
    Requests requests = Requests();

    Map<String, String> params = {
      "amount": amount,
      "client_key": portoneKey,
      "currency": currency,
      "failure_url": failureUrl,
      "merchant_order_id": orderId,
      "success_url": successUrl
    };
    String message = "";
    params.forEach((key, value) {
      var encodedValue = Uri.encodeComponent(value);
      if (message.isNotEmpty) {
        message = message + "&$key=$encodedValue";
      } else {
        message = message + "$key=$encodedValue";
      }
    });

    final keyBytes = const Utf8Encoder().convert(requests.secretKey);
    final dataBytes = const Utf8Encoder().convert(message);
    final hmacBytes = Hmac(sha256, keyBytes).convert(dataBytes).bytes;
    final hmacBase64 = base64Encode(hmacBytes);

    print("SignatureHash--> $hmacBase64");
    return hmacBase64;
  }
}
