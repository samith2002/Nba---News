import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List news;
  
  Future fetchNews()async{
    http.Response response;
    response = await http.get(Uri.parse("https://fly.sportsdata.io/v3/nba/scores/json/News?key=fc58623284094f8aa811525f6820edf7"));
    setState(() {
      if (response.statusCode==200){
        news = json.decode(response.body);
      }
    });
  }

  @override
  void initState() {
    fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: Scaffold(
        appBar:AppBar(
          backgroundColor:Colors.black,
          title:Text(
            "NBA NEWS",
          ),
          centerTitle:true,
        ),
        body:ListView.builder(
          shrinkWrap:true,
          itemCount:news.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                Padding(
                  padding:EdgeInsets.all(10),
                  child: Container(
                    child:Text(news[index]["Title"],style:TextStyle(fontSize:30,color:Colors.black,fontWeight:FontWeight.bold),),
                  ),
                ),
                SizedBox(
                  height:10,
                  width:double.infinity,
                  child:Divider(color:Colors.red.shade900,thickness:5,),
                ),
                Container(
                  padding:EdgeInsets.all(15),
                  child:Text(news[index]["Content"],style:TextStyle(fontSize:22,color:Colors.black,fontWeight:FontWeight.bold),),
                ),
                Padding(
                  padding:EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Categories : ",style:TextStyle(fontSize:20,color:Colors.black,fontWeight:FontWeight.bold,),),
                          Container(
                            child:Text(news[index]["Categories"],style:TextStyle(fontSize:20,color:Colors.red.shade900,fontWeight:FontWeight.bold),),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Player ID: ",style:TextStyle(fontSize:20,color:Colors.black,fontWeight:FontWeight.bold,),),
                          Container(
                            child:Text(news[index]["PlayerID"].toString(),style:TextStyle(fontSize:20,color:Colors.red.shade900,fontWeight:FontWeight.bold),),
                          ),
                        ],
                  ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Team ID: ",style:TextStyle(fontSize:20,color:Colors.black,fontWeight:FontWeight.bold,),),
                          Container(
                            child:Text(news[index]["TeamID"].toString(),style:TextStyle(fontSize:20,color:Colors.red.shade900,fontWeight:FontWeight.bold),),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text("Updated: ",style:TextStyle(fontSize:20,color:Colors.black,fontWeight:FontWeight.bold,),),
                          Container(
                            child:Text(news[index]["TimeAgo"].toString(),style:TextStyle(fontSize:20,color:Colors.red.shade900,fontWeight:FontWeight.bold),),
                          ),
                        ],
                      ),

                ]
                  ),
                )],
            );
    },


      ),
    ),
    );
  }
}




