import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ModalClass.dart';
String weburl="https://haidermart.cm4b.co.uk/";
String consumerKey="ck_1010582ad3bb87d331c9e7e869c825b1acfb1c59";
String secreteKey="cs_1e99be9f1c34d9e7c3a52e165d46b9859714cbb0";

var client=http.Client();
Future<Atiq> createAlbum(Atiq atiq,Ing shippingAddress) async {
  // Map<String, String> map22 = new Map();
  // Map<String, dynamic> shippingAddres = shippingAddress.toJson()
  //   ..removeWhere(
  //           (dynamic key, dynamic value) => key == null  );
  // print("wwwwwwwwwwwwww");
  //
  // print(shippingAddres);

  // Map<String,dynamic> bi = new Map<String,dynamic>();
  // bi["a"] = "ttst";
  // bi["b"] = 466;
  // bi["c"] = true;
  // print(jsonEncode(bi).toString());
  // print("Allah");
  // print(atiq.);


  String d = jsonEncode(shippingAddress.toJson()).toString();
 // Map<String, dynamic> meaon =
   String g = jsonEncode(atiq.toJson());
  print("testatiquebefore");
  print(g);
  print("testatiqueafter");



  //Map<String, dynamic> oneMap = {};
  //oneMap.addAll(meaon);
 //print("fffffffffffffffffff"+meaon.toString());
  //Map<String, dynamic> finalone = oneMap;
  //print("lllllllllllllllllllll"+finalone.toString());


  var response=await client.post(
      Uri.parse(weburl+"/wp-json/wc/v3/orders?&consumer_key=$consumerKey&consumer_secret=$secreteKey"),
      //headers:requestheader,

    headers: <String, String>{
       'Content-type':'application/json',
      // 'Accept': 'application/json',
      //'Content-type':'application/x-www-form-urlencoded',
    },
       body:g
    /*{
        "payment_method": "XXXX-XXXXmmmmmm-XXXX-lllllllXXXX",
        'payment_method_title': "true",




      },*/
      // jsonDecode(g),
      //1 jsonEncode(g),
      //
    //body:jsonEncode(g)
    //lllll json.encode(g),
    //json.decode(g),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("201");
    print(response.body);
    print("ooooo");
    return Atiq.fromJson(jsonDecode(response.body));

  } else {
    print("201error${response.statusCode}");
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}



class DatatoApi extends StatefulWidget {
  const DatatoApi({Key? key}) : super(key: key);

  @override
  _DatatoApiState createState() {
    return _DatatoApiState();
  }
}

class _DatatoApiState extends State<DatatoApi> {
  final TextEditingController _controller = TextEditingController();
  Future<Atiq>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {

            setState(() {
              Ing shipping=Ing(firstName: "atique",lastName: "Rahman",address1: "Javeed Colony Faroqabad",address2: "Jhelum",
                  city: "Sheikhupura",state: "Punjab",postcode: "39500",country: "Pakistan");
              print("befor");
              print(shipping.toJson());

              print("after");

              Ing billing =Ing(firstName: "Atique",lastName: "Rahman",address1: "Javeed Colony Faroqabad",address2: "Jhelum",
                  city: "Sheikhupura",state: "Punjab",postcode: "39500",country: "Pakistan",
                  email: "atiquerahman780@gmail.com",phone: "03022663141");

              print("befor billing");
              print(billing.toJson());

              print("after billing");

              LineItem lineite=LineItem(productId: 11831,quantity: 1,variationId: 0);
              LineItem lineite1=LineItem(productId: 11595,quantity: 1,variationId: 0);
              ShippingLine shippinglines=ShippingLine(methodId: "12",methodTitle: "free",total: "1200");
              Atiq atiq = Atiq(paymentMethod: "Cash on delivery",paymentMethodTitle: "Cash on delivery",setPaid: false,
                  billing: billing,shipping: shipping,
                  lineItems: [lineite,lineite1],shippingLines: [shippinglines] );
              _futureAlbum = createAlbum(atiq,shipping);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Atiq> buildFutureBuilder() {
    return FutureBuilder<Atiq>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("pass");
        } else if (snapshot.hasError) {
          return Text("fail"+'${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

Atiq atiqFromJson(String str) => Atiq.fromJson(json.decode(str));

String atiqToJson(Atiq data) => json.encode(data.toJson());

class Atiq {
  Atiq({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.lineItems,
    this.shippingLines,
  });

  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  Ing? billing;
  Ing? shipping;
  List<LineItem>? lineItems;
  List<ShippingLine>? shippingLines;

  factory Atiq.fromJson(Map<String, dynamic> json) => Atiq(
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    setPaid: json["set_paid"],
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    lineItems: List<LineItem>.from(json["line_items"].map((x) => LineItem.fromJson(x))),
    shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "set_paid": setPaid,
    "billing": billing!.toJson(),
    "shipping": shipping!.toJson(),
    "line_items": List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "shipping_lines": List<dynamic>.from(shippingLines!.map((x) => x.toJson())),
  };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
  };
}

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
    this.variationId,
  });

  int? productId;
  int? quantity;
  int? variationId;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    productId: json["product_id"],
    quantity: json["quantity"],
    variationId: json["variation_id"] == null ? null : json["variation_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    "variation_id": variationId == null ? null : variationId,
  };
}

class ShippingLine {
  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String? methodId;
  String? methodTitle;
  String? total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
    methodId: json["method_id"],
    methodTitle: json["method_title"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "method_id": methodId,
    "method_title": methodTitle,
    "total": total,
  };
}


// class Mano {
//   String? paymentMethod;
//   String? paymentMethodTitle;
//   bool? setPaid;
//   Billing? billing;
//   Shipping? shipping;
//   List<LineItems>? lineItems;
//   List<ShippingLines>? shippingLines;
//
//   Mano(
//       {this.paymentMethod,
//         this.paymentMethodTitle,
//         this.setPaid,
//         this.billing,
//         this.shipping,
//         this.lineItems,
//         this.shippingLines});
//
//   Mano.fromJson(Map<String, dynamic> json) {
//     paymentMethod = json['payment_method'];
//     paymentMethodTitle = json['payment_method_title'];
//     setPaid = json['set_paid'];
//     billing =
//     json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
//     shipping = json['shipping'] != null
//         ? new Shipping.fromJson(json['shipping'])
//         : null;
//     if (json['line_items'] != null) {
//       lineItems = <LineItems>[];
//       json['line_items'].forEach((v) {
//         lineItems!.add(new LineItems.fromJson(v));
//       });
//     }
//     if (json['shipping_lines'] != null) {
//       shippingLines = <ShippingLines>[];
//       json['shipping_lines'].forEach((v) {
//         shippingLines!.add(new ShippingLines.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['payment_method'] = this.paymentMethod;
//     data['payment_method_title'] = this.paymentMethodTitle;
//     data['set_paid'] = this.setPaid;
//     if (this.billing != null) {
//       data['billing'] = this.billing!.toJson();
//       //data['billing'] = jsonEncode(this.billing!).toString();
//     }
//     if (this.shipping != null) {
//       data['shipping'] = this.shipping!.toJson();
//       //data['shipping'] = jsonEncode(this.shipping!).toString();
//     }
//     if (this.lineItems != null) {
//       data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
//     }
//     if (this.shippingLines != null) {
//       data['shipping_lines'] =
//           this.shippingLines!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Billing {
//   String? firstName;
//   String? lastName;
//   String? address1;
//   String? address2;
//   String? city;
//   String? state;
//   String? postcode;
//   String? country;
//   String? email;
//   String? phone;
//
//   Billing(
//       {this.firstName,
//         this.lastName,
//         this.address1,
//         this.address2,
//         this.city,
//         this.state,
//         this.postcode,
//         this.country,
//         this.email,
//         this.phone});
//
//   Billing.fromJson(Map<String, dynamic> json) {
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     address1 = json['address_1'];
//     address2 = json['address_2'];
//     city = json['city'];
//     state = json['state'];
//     postcode = json['postcode'];
//     country = json['country'];
//     email = json['email'];
//     phone = json['phone'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['address_1'] = this.address1;
//     data['address_2'] = this.address2;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['postcode'] = this.postcode;
//     data['country'] = this.country;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     return data;
//   }
// }
//
// class Shipping {
//   String? firstName;
//   String? lastName;
//   String? address1;
//   String? address2;
//   String? city;
//   String? state;
//   String? postcode;
//   String? country;
//
//   Shipping(
//       {this.firstName,
//         this.lastName,
//         this.address1,
//         this.address2,
//         this.city,
//         this.state,
//         this.postcode,
//         this.country});
//
//   Shipping.fromJson(Map<String, dynamic> json) {
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     address1 = json['address_1'];
//     address2 = json['address_2'];
//     city = json['city'];
//     state = json['state'];
//     postcode = json['postcode'];
//     country = json['country'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['address_1'] = this.address1;
//     data['address_2'] = this.address2;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     data['postcode'] = this.postcode;
//     data['country'] = this.country;
//     return data;
//   }
// }
//
// class LineItems {
//   int? productId;
//   int? quantity;
//   int? variationId;
//
//   LineItems({this.productId, this.quantity, this.variationId});
//
//   LineItems.fromJson(Map<String, dynamic> json) {
//     productId = json['product_id'];
//     quantity = json['quantity'];
//     variationId = json['variation_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['product_id'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['variation_id'] = this.variationId;
//     return data;
//   }
// }
//
// class ShippingLines {
//   String? methodId;
//   String? methodTitle;
//   String? total;
//
//   ShippingLines({this.methodId, this.methodTitle, this.total});
//
//   ShippingLines.fromJson(Map<String, dynamic> json) {
//     methodId = json['method_id'];
//     methodTitle = json['method_title'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['method_id'] = this.methodId;
//     data['method_title'] = this.methodTitle;
//     data['total'] = this.total;
//     return data;
//   }
// }

