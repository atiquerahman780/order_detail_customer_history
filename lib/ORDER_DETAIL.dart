import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_detail/FetchData.dart';
import 'package:order_detail/ModalClass.dart';
import 'package:order_detail/ORDER_DETAIL.dart';

import 'package:order_detail/apiServices.dart';

var users=[];

class orderDetail extends StatefulWidget {

  orderDetail({Key? key, required this.use1}) : super(key: key);
   Order use1;



  @override
  _orderDetailState createState() => _orderDetailState();
}
class _orderDetailState extends State<orderDetail> {
  assignlistvaluefunction();



  /*String weburl="https://haidermart.cm4b.co.uk/";
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


   *//* var productlis = Order.fromJsonList(json.decode(response.body));

    for(int i=0;i<productlis.length;i++)
      {
        var list =  productlis[i].lineItems as List;
        for(int j=0;j<list.length;j++)
        {

          print("body response by ID "+list[j].name.toString());


        }

      }*//*
*/

    //return []; //imageList;
  //}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Order Detail"+widget.use1.id.toString()),
        ),
        body:Container(

           child:  /*ElevatedButton(

             onPressed: () {
               var list = widget.use1.lineItems as List;
               for(int i=0;i<list.length;i++)
                 {

                 }



              // FetchData.getProductByID();
               print(list.toString());
             },
             child: const Text('Enabled'),
           ),*/

           Column(
            children: [
              Expanded(

                child: Card(
                  child:  ListView.builder(

                              itemCount: 5,

                              itemBuilder: (context, index) {
                              //  String T = users[index].id.toString();
                               /* u.r = T;
                                print(u.r);
                                print(
                                    users[index].total);*/
                                return
                                  Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(

                                              title: Text(
                                                users[index]
                                                    .name,
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                              ),
                                              subtitle: Text("Large Size unit"
                                              ),
                                    /*          isThreeLine: true,
                                              leading: Image.network(
                                                  "https://picsum.photos/seed/picsum/200/300"),
                                              trailing: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(users[index]
                                                      .quantity
                                                      .toString() + " x " +
                                                      users[index]

                                                          .price.toString() +
                                                      " " + "Rs. " +
                                                      users[index]

                                                          .subtotal.toString(),
                                                  ),
                                                ],
                                              )*/
                                          ),
                                        ],
                                      )
                                  );
                              })



                ),
              ),
            /*  Container(
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
              )*/
            ],
          ),
        )
    );
  }

  assignlistvaluefunction() {
     users=widget.use1.lineItems as List;


  }
}


