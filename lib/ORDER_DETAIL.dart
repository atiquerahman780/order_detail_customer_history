import 'package:flutter/material.dart';


import 'ModalClass.dart';

var lineItem=[];



class orderDetail extends StatefulWidget {
  orderDetail({Key? key, required this.use1}) : super(key: key);
  Order use1;



  @override
  _orderDetailState createState() => _orderDetailState();
}
class _orderDetailState extends State<orderDetail> {
  int sum=0;


  @override
  void initState()
  {
    lineItem=widget.use1.lineItems as List;
    u.r=lineItem.length.toString();
    for(int i=0;i<lineItem.length;i++){
      int a=int.parse(widget.use1.lineItems![i].subtotal.toString());
      //print("a//a"+a.toString());
      sum=sum+a;
      String l=sum.toString();

    }
    print("sum="+sum.toString());
    //assignlistvaluefunction();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(" Order Detail"+widget.use1.id.toString()),
        ),
        body:Container(

          child:

          Column(
            children: [
              Expanded(

                child: Card(
                    child:  ListView.builder(

                        itemCount: lineItem.length,
                        //restorationId: u.r=lineItem.length as String,

                        itemBuilder: (context, index) {
                           String subtotal=widget.use1.lineItems![index].subtotal.toString();
                          // print(subtotal);
                           i.m=subtotal;



                          //print(lineItem.length);
                              /*for(int i=0;i<lineItem.length;i++){
                              int a=int.parse(widget.use1.lineItems![index].subtotal.toString());
                              //print("a//a"+a.toString());


                                  sum=sum+a;



                         String l=sum.toString();

                             }
                          print("sum="+sum.toString());*/



                          //String T = lineItem[index].;
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
                                        lineItem[index]
                                            .name,
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
                                                  Text(lineItem[index]
                                                      .quantity
                                                      .toString() + " x " +
                                                      lineItem[index]

                                                          .price.toString() +
                                                      " " + "Rs. " +
                                                      lineItem[index]

                                                          .subtotal.toString(),
                                                  ),
                                                ],
                                              )
                                    ),
                                  ],
                                )
                            );
                        })



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
                              child:Text(u.r )
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
                                child:Text("$sum")
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
                                child:Text("$sum")
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
  static String r='';
}
class i{
  static String m='';
}



