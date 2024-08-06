import 'package:portone_flutter_package/constants/constants.dart';
import 'package:portone_flutter_package/dto/requests/bank_list_request.dart';
import 'package:portone_flutter_package/dto/requests/billing_details.dart';
import 'package:portone_flutter_package/dto/requests/chanex_token_request.dart';
import 'package:portone_flutter_package/dto/requests/checkout_with_direct_bank_transfer_request.dart';
import 'package:portone_flutter_package/dto/requests/checkout_with_installation_request.dart';
import 'package:portone_flutter_package/dto/requests/merchant_details.dart';
import 'package:portone_flutter_package/dto/requests/order_details.dart';
import 'package:portone_flutter_package/dto/requests/shipping_details.dart';
import 'package:portone_flutter_package/dto/requests/web_checkout_request.dart';
import 'package:portone_flutter_package/dto/requests/with_tokenization_request.dart';
import 'package:portone_flutter_package/dto/requests/without_tokenization_request.dart';

import 'utilities/jwt_token_generation.dart';
import 'utilities/random_strings_generation.dart';
import 'utilities/signature_hash_generation.dart';

class Requests {
  final devEnvironment = DEV;
  final portoneKey = "NPSkZZYefGyKvBxi";
  final secretKey =
      "6c8d964e7d472076eae7beb0a1f5b2b81c0afbb479307a211029ace597656957";
  final mobileNo = "+919913379694";
  final environment = SANDBOX;
  final currency = "THB";
  final paymentChannel = "MOMOPAY";
  final paymentMethod = "MOMOPAY_WALLET";
  final customerUUID = "c60005e1-164c-46fa-b7a1-fbee11543493";
  final transactionType = "PURCHASE"; // PURCHASE || PREAUTH
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJQT1JUT05FIiwiaXNzIjoiTlBTa1paWWVmR3lLdkJ4aSIsImlhdCI6MTYzNTM4OTQxNiwiZXhwIjoxODM1Mzg5NDE2fQ.qZNDiG7l3UCCyd75c6Bc2kka_iw9rDayUjghH-Jfg_w";

  /*
  Signature Has can be generated on server side by following the steps given in the documentation.
  To generate a signature hash on the server side using a secret key that will be included in the payload.
  https://www.docs.portone.cloud/docs/integration_guide/signatures/payment_request
   */
  JwtTokenGeneration jwt = JwtTokenGeneration();
  RandomStringsGeneration randomString = RandomStringsGeneration();

  String getJWTToken() {
    return "Bearer ${jwt.getJWTToken()}";
  }

  WebCheckoutRequest getRequestBody() {
    String orderId = randomString.getRandomString(6);
    WebCheckoutRequest webCheckoutRequest = WebCheckoutRequest(
        amount: 19010.23,
        billingDetails: BillingDetails(
            billingAddress: BillingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            billingEmail: "markweins@gmail.com",
            billingName: "Test mark",
            billingPhone: "+848959893980"),
        portOneKey: portoneKey,
        countryCode: "VN",
        currency: currency,
        defaultGuestCheckout: false,
        description: "By Aagam",
        env: devEnvironment,
        expiryHours: 1,
        failureUrl: "https://dev-checkout.chaipay.io/failure.html",
        isCheckoutEmbed: false,
        merchantDetails: MerchantDetails(
            name: "Gumnam",
            backUrl: "https://demo.chaipay.io/checkout.html",
            logo:
                "https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg",
            promoCode: null,
            promoDiscount: 10000.00,
            shippingCharges: 10000.00),
        merchantOrderId: orderId,
        orderDetails: <OrderDetails>[
          OrderDetails(
              id: "knb", name: "kim nguyen bao", price: 19010.23, quantity: 1)
        ],
        mobileRedirectUrl: "portone://checkout",
        shippingDetails: ShippingDetails(
            shippingAddress: ShippingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            shippingEmail: "markweins@gmail.com",
            shippingName: "Test mark",
            shippingPhone: "+848959893980"),
        showBackButton: true,
        showShippingDetails: true,
        source: "mobile",
        successUrl: "https://dev-checkout.chaipay.io/success.html",
        environment: environment);

    return webCheckoutRequest;
  }

  WithTokenizationRequest getTokenizationRequest() {
    String orderId = randomString.getRandomString(6);
    WithTokenizationRequest tokenizationRequest = WithTokenizationRequest(
        amount: 50010.12,
        billingDetails: BillingDetails(
            billingAddress: BillingAddress(
                city: "TH",
                countryCode: "TH",
                locale: "en",
                line1: "address",
                line2: "address_2",
                postalCode: "400202",
                state: "Mah"),
            billingEmail: "markweins@gmail.com",
            billingName: "Test mark",
            billingPhone: mobileNo),
        shippingDetails: ShippingDetails(
            shippingAddress: ShippingAddress(
                city: "TH",
                countryCode: "TH",
                locale: "en",
                line1: "address",
                line2: "address_2",
                postalCode: "400202",
                state: "Mah"),
            shippingEmail: "markweins@gmail.com",
            shippingName: "Test mark",
            shippingPhone: mobileNo),
        tokenParams: TokenParams(
            expiryMonth: "04",
            expiryYear: "2025",
            saveCard: true,
            partialCardNumber: "4111 1******1111",
            token: "09d14c38ac8e4b93ae0005655f4901f1",
            type: "visa"),
        currency: currency,
        failureUrl: "https://www.bing.com",
        key: portoneKey,
        merchantOrderId: orderId,
        orderDetails: [
          OrderDetails(
              id: "knb", name: "kim nguyen bao", price: 1000, quantity: 1)
        ],
        pmtChannel: paymentChannel,
        pmtMethod: paymentMethod,
        redirectUrl: "portone://checkout",
        source: "mobile",
        successUrl: "https://www.google.com",
        environment: environment,
        transactionType: transactionType,
        routingParams: RoutingParams(type: "failover", routeRef: null));

    return tokenizationRequest;
  }

  WithoutTokenizationRequest getWithoutTokenizationRequest() {
    String orderId = randomString.getRandomString(6);
    WithoutTokenizationRequest tokenizationRequest = WithoutTokenizationRequest(
        amount: 20000.12,
        billingDetails: BillingDetails(
            billingAddress: BillingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            billingEmail: "markweins@gmail.com",
            billingName: "Test mark",
            billingPhone: "+848959893980"),
        currency: currency,
        env: "dev",
        failureUrl: "https://www.bing.com",
        key: portoneKey,
        merchantOrderId: orderId,
        orderDetails: [
          OrderDetails(
              id: "knb", name: "kim nguyen bao", price: 20000.12, quantity: 1)
        ],
        pmtChannel: paymentChannel,
        pmtMethod: paymentMethod,
        redirectUrl: "portone://checkout",
        shippingDetails: ShippingDetails(
            shippingAddress: ShippingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            shippingEmail: "markweins@gmail.com",
            shippingName: "Test mark",
            shippingPhone: mobileNo),
        successUrl: "https://www.google.com",
        environment: environment,
        source: "mobile",
        transactionType: transactionType);

    return tokenizationRequest;
  }

  ChanexTokenRequest getChanexTokenRequest() {
    ChanexTokenRequest chanexTokenRequest = omiseCreditCard();
    return chanexTokenRequest;
  }

  CheckoutWithDirectBankTransferRequest
      getCheckoutWithDirectBankTransferRequest() {
    String orderId = randomString.getRandomString(6);
    CheckoutWithDirectBankTransferRequest request =
        CheckoutWithDirectBankTransferRequest(
            amount: 50010,
            billingDetails: BillingDetails(
                billingAddress: BillingAddress(
                    city: "VND",
                    countryCode: "VN",
                    line1: "address",
                    line2: "address_2",
                    locale: "en",
                    postalCode: "400202",
                    state: "Mah"),
                billingEmail: "markweins@gmail.com",
                billingName: "Test mark",
                billingPhone: mobileNo),
            currency: currency,
            env: "dev",
            failureUrl: "https://www.bing.com",
            key: portoneKey,
            source: "mobile",
            merchantOrderId: orderId,
            orderDetails: [
              OrderDetails(
                  id: "knb", name: "kim nguyen bao", price: 1000, quantity: 1)
            ],
            pmtChannel: paymentChannel,
            pmtMethod: paymentMethod,
            shippingDetails: ShippingDetails(
                shippingAddress: ShippingAddress(
                    city: "VND",
                    countryCode: "VN",
                    line1: "address",
                    line2: "address_2",
                    locale: "en",
                    postalCode: "400202",
                    state: "Mah"),
                shippingEmail: "markweins@gmail.com",
                shippingName: "Test mark",
                shippingPhone: mobileNo),
            successUrl: "https://www.google.com",
            environment: environment,
            transactionType: transactionType);

    return request;
  }

  CheckoutWithInstallationRequest getCheckoutWithInstallationRequest() {
    String orderId = randomString.getRandomString(6);
    CheckoutWithInstallationRequest request = CheckoutWithInstallationRequest(
        amount: 50010,
        billingDetails: BillingDetails(
            billingAddress: BillingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            billingEmail: "markweins@gmail.com",
            billingName: "Test mark",
            billingPhone: mobileNo),
        currency: currency,
        env: "dev",
        failureUrl: "https://www.bing.com",
        key: portoneKey,
        source: "mobile",
        merchantOrderId: orderId,
        orderDetails: [
          OrderDetails(
              id: "knb", name: "kim nguyen bao", price: 1000, quantity: 1)
        ],
        pmtChannel: paymentChannel,
        pmtMethod: paymentMethod,
        redirectUrl: "portone://checkout",
        shippingDetails: ShippingDetails(
            shippingAddress: ShippingAddress(
                city: "VND",
                countryCode: "VN",
                line1: "address",
                line2: "address_2",
                locale: "en",
                postalCode: "400202",
                state: "Mah"),
            shippingEmail: "markweins@gmail.com",
            shippingName: "Test mark",
            shippingPhone: mobileNo),
        successUrl: "https://www.google.com",
        bankDetails: gbppBankDetails(),
        environment: environment,
        transactionType: transactionType);

    return request;
  }

  BankListRequest getBankListRequest() {
    const paymentMethod = "OMISE_INSTALLMENT";
    BankListRequest request = BankListRequest();
    request.amount = 20023;
    request.environment = environment;
    request.iamportKey = portoneKey;
    request.isMerchantSponsored = false;
    request.methodKey = paymentMethod;
    request.overrideDefault = false;
    return request;
  }

  BankDetails gbppBankDetails() {
    BankDetails bankDetails = BankDetails(
        bankCode: "004",
        bankName: "Kasikorn Bank",
        isMerchantSponsored: false,
        installmentPeriod: InstallmentPeriod(month: 8, interest: 0));
    return bankDetails;
  }

  BankDetails omiseBankDetails() {
    BankDetails bankDetails = BankDetails(
        bankCode: "installment_bay",
        bankName: "Krungsri",
        isMerchantSponsored: false,
        installmentPeriod: InstallmentPeriod(month: 4, interest: 0.8));
    return bankDetails;
  }

  ChanexTokenRequest adayenCard() {
    ChanexTokenRequest card = ChanexTokenRequest(
        cardholderName: "NGUYEN VAN A",
        cardType: "Visa",
        cardNumber: "4111111145551142",
        expirationMonth: "03",
        expirationYear: "2030",
        serviceCode: "737",
        saveCard: true);
    return card;
  }

  ChanexTokenRequest omiseCreditCard() {
    ChanexTokenRequest card = ChanexTokenRequest(
        cardNumber: "4242424242424242",
        cardType: "Visa",
        cardholderName: "NGUYEN VAN A",
        serviceCode: "123",
        expirationYear: "2025",
        expirationMonth: "05",
        saveCard: true);
    return card;
  }

  ChanexTokenRequest vtcPayCreditCard() {
    ChanexTokenRequest card = ChanexTokenRequest(
        cardNumber: "4111111111111111",
        cardType: "Visa",
        cardholderName: "NGUYEN VAN A",
        serviceCode: "123",
        expirationYear: "2030",
        expirationMonth: "01",
        saveCard: true);
    return card;
  }

  ChanexTokenRequest gbppDebiCard() {
    ChanexTokenRequest card = ChanexTokenRequest(
        cardNumber: "4535017710535741",
        cardType: "Visa",
        cardholderName: "NGUYEN VAN A",
        serviceCode: "184",
        expirationYear: "2028",
        expirationMonth: "05",
        saveCard: true);
    return card;
  }
}
