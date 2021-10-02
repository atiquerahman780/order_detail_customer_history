import 'apiServices.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchData{

 static Future<List<Use>> getProductByID() async {


    final responseBody = (await http.get(Uri.parse('https://haidermart.cm4b.co.uk/wp-json/wc/v3/orders?customer=1&id=11808&consumer_key=ck_1010582ad3bb87d331c9e7e869c825b1acfb1c59&consumer_secret=cs_1e99be9f1c34d9e7c3a52e165d46b9859714cbb0')))
        .body;
     final decodedResponse = json.decode(responseBody);
   //  final decodedResponse = json.decode(response);
    final user = decodedResponse.json((e) => Use.fromJson(e));
  //     final Use yourObject = Use.fromJson(decodedResponse[0]);
    print("body response by ID "+user.toString());

//var list = yourObject.lineItems as List;
//   List<List> itemsList = list.map((i) => variationFromJson(i)).toList();
//    final List<Variation> varilist=json.decode(yourObject.variations!.);
//print("body response by ID "+list.length.toString()+""+list[2].toString());


//  The response body is an array of items.
    var productlis;
//= Products.fromJsonList(json.decode(responseBody));

    productlis= List<Use>.empty();


// print("body response by ID "+responseBody);

    return productlis; //imageList;
  }

}