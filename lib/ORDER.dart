import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:order_detail/ORDER_DETAIL.dart';

import 'package:order_detail/apiServices.dart';

import 'ModalClass.dart';
class DataFromApi extends StatefulWidget {
  List<Order> users = [];
  var use;
  DataFromApi({Key? key}) : super(key: key);



  @override
  _DataFromApiState createState() => _DataFromApiState();
}



class _DataFromApiState extends State<DataFromApi> {
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
       var productlis = Order.fromJsonList(json.decode(response.body));
       List<Order> users = productlis;

       print("getCustomerOrders successfully response"+response.body);
       var jsonData= jsonDecode(response.body);
       print(jsonData);
       print("user model size before"+ widget.users.length.toString());
       for(var u in jsonData){
         print("loop1");

         Order user = Order.fromJson(u);
         print("loop2");
        /* try {
           print(widget.users[0]);
         }catch(e){
           print(e.toString());
         }*/
         widget.users=users;
         print("loop3");
       }
       print("user model size after"+ widget.users.length.toString());

     }
     else{
       print("getCustomerOrders not Got Response"+response.body);
     }


     //final bytes = File(Image.asset("assets/images/splash1.png").p).readAsBytesSync();
    // return response.statusCode==200?true:false;

     //return   widget.users.statusCode==200?true:false;
     return widget.users;
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body:Container(

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
                        itemCount: widget.users.length,

                        itemBuilder: (context,index){
                          return ListTile(

                            title: Text("Order: #"+
                                widget.users[index].id.toString(),style: TextStyle(color: Colors.black
                            ),
                            ),
                            subtitle: Text("Status "
                             //   widget.users[index].status+"   Total: Rs. "+widget.users[index].total,style: TextStyle(color: Colors.black38,),
                            ),
                            isThreeLine: true,
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => orderDetail(use1: widget.users[index] )),
                              );
                            },

                          );
                        });
                }
            ),
          ),
        )
    );
  }
}









