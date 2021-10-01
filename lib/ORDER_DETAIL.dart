import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_detail/ORDER_DETAIL.dart';

import 'package:order_detail/apiServices.dart';
class orderDetail extends StatefulWidget {
  List<Mano> users = [];
  var use;


  orderDetail({Key? key, required this.id}) : super(key: key);

  //({Key? key, required this.title}) : super(key: key);


  final String id;
  @override
  _orderDetailState createState() => _orderDetailState();
}



class _orderDetailState extends State<orderDetail> {
  String weburl="https://haidermart.cm4b.co.uk/";
  String consumerKey="ck_1010582ad3bb87d331c9e7e869c825b1acfb1c59";
  String secreteKey="cs_1e99be9f1c34d9e7c3a52e165d46b9859714cbb0";

  var client=http.Client();
  Future getCustomerOrders(String id) async{

    Map<String,String> requestheader={
      'Content-type':'application/x-www-form-urlencoded',
    };
    var response=await client.get(
      Uri.parse(weburl+"/wp-json/wc/v3/orders?customer=$id&consumer_key=$consumerKey&consumer_secret=$secreteKey"),
      headers:requestheader,

    );
    if(response.statusCode==200)
    {
      print("getCustomerOrders successfully response"+response.body);
      var jsonData= jsonDecode(response.body);
      print(jsonData);
      print("user model size before"+ widget.users.length.toString());
      for(var u in jsonData){
        print("loop1");


        Mano user = Mano(id: widget.users.first.id, name: widget.users.first.name, productId: widget.users.first.productId, variationId: widget.users.first.variationId, quantity: widget.users.first.quantity, taxClass: taxClass, subtotal: subtotal, subtotalTax: widget.users.first.subtotalTax, total: widget.users.first.total, totalTax: widget.users.first.totalTax, taxes: widget.users.first.taxes, metaData: widget.users.first.metaData, sku: widget.users.first.sku, price: widget.users.first.price).f(u);

        print("loop2");

        widget.users.add(user);
        print("loop3");
      }


      print("user model size after"+ widget.users.length.toString());

    }
    else{
      print("getCustomerOrders not Got Response"+response.body);
    }



    return widget.users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.id+" Order Detail"),
        ),
        body:Container(

          child: Column(
            children: [
              Expanded(

                child: Card(
                  child: FutureBuilder(
                      future: getCustomerOrders('1'),
                      builder: (context, snapshot){
                        if(snapshot.data==null) {
                          return Container(
                            child: Center(

                              child: Text('Loding...'),

                            ),
                          );


                        }
                        else
                          return ListView.builder(

                              itemCount: widget.users[0].lineItems.length,

                              itemBuilder: (context, index) {
                                /*String T = widget.users[index].id.toString();
                                u.r = T;
                                print(u.r);
                                print(
                                    widget.users[index].lineItems[index].total);*/
                                return
                                  Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(

                                              title: Text(
                                                widget.users[index]
                                                    .lineItems[index].name,
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                              ),
                                              subtitle: Text("Large Size unit"
                                              ),
                                              isThreeLine: true,
                                              leading: Image.network(
                                                  "https://picsum.photos/seed/picsum/200/300"),
                                              trailing: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(widget.users[index]
                                                      .lineItems[index].quantity
                                                      .toString() + " x " +
                                                      widget.users[index]
                                                          .lineItems[index]
                                                          .price.toString() +
                                                      " " + "Rs. " +
                                                      widget.users[index]
                                                          .lineItems[index]
                                                          .subtotal.toString(),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ],
                                      )
                                  );
                              });
                        }

                  ),
                ),
              ),
              Container(
                height: 110,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(" Item(s)")
                            ),
                            Expanded(child: SizedBox()),
                            Align(
                              alignment: Alignment.topRight,
                              child:Text("sdg")
                            ),
                          ],
                        ),
                       Row(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(" Item Total")
                            ),
                            Expanded(child: SizedBox()),
                            Align(
                                alignment: Alignment.topRight,
                                child:Text("1")
                            ),

                          ],
                        ),

                       Row(

                          children: [

                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(" Deliver Charges")
                            ),
                            Expanded(child: SizedBox()),
                            Align(
                                alignment: Alignment.topRight,
                                child:Text("0")
                            ),

                          ],
                        ),


                         Row(

                          children: [

                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(" Discount")
                            ),
                            Expanded(child: SizedBox()),
                            Align(
                                alignment: Alignment.topRight,
                                child:Text("0")
                            ),

                          ],
                        ),
                      // Line


                      const Divider(
                        height: 5,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),

                       Row(

                          children: [

                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(" Total Price")
                            ),
                            Expanded(child: SizedBox()),
                            Align(
                                alignment: Alignment.topRight,
                                child:Text(u.r)
                            ),

                          ],
                        ),



                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
class u{
  static String r ='';
}

// To parse this JSON data, do
//
//     final mano = manoFromJson(jsonString);



List<Mano> manoFromJson(String str) => List<Mano>.from(json.decode(str).map((x) => Mano.fromJson(x)));

String manoToJson(List<Mano> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mano {
  Mano({
    required this.id,
    required this.name,
    required  this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required  this.subtotalTax,
    required  this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.sku,
    required  this.price,
    this.parentName,
  });

  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<dynamic> metaData;
  String sku;
  int price;
  dynamic parentName;

  factory Mano.fromJson(Map<String, dynamic> json) => Mano(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    quantity: json["quantity"],
    taxClass: json["tax_class"],
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
    sku: json["sku"],
    price: json["price"],
    parentName: json["parent_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "tax_class": taxClass,
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "total": total,
    "total_tax": totalTax,
    "taxes": List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
    "sku": sku,
    "price": price,
    "parent_name": parentName,
  };
}

