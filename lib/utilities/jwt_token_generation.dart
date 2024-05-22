
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../requests.dart';

class JwtTokenGeneration {
  String getJWTToken() {
    Requests requests = Requests();

    final claimSet = JwtClaim(
        issuedAt: DateTime.now(),
        expiry: DateTime.now().add(const Duration(seconds: 100)),
        issuer: "PORTONE",
        subject: requests.portoneKey,
        otherClaims: <String, dynamic>{
          "typ": "JWT",
          "alg": "HS256",
        });

    String token = issueJwtHS256(claimSet, requests.secretKey);
    print("JWTToken--> $token");

    return token;
  }
}
