import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/crud_data.dart';
import 'cardWidget.dart';
class ViewList extends StatefulWidget {
  const ViewList({super.key});
  @override
  State<ViewList> createState() => _ViewListState();
}
class _ViewListState extends State<ViewList> {
  // List ageunder=[20,21,22,23,24,25,26,27,28,29,30];
  Stream<List<UserModel>> userList(){
    return FirebaseFirestore.instance.collection('collections')
    // .limit()
    // .where('age',whereIn: ageunder)
        .snapshots()
        .map((event) => event.docs.map((e) => UserModel.fromJson(e.data())).toList());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.yellow,
        child: StreamBuilder(
            stream: userList(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if(snapshot.hasData){
                List<UserModel>? user= snapshot.data;
                print(user!.length);
                return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardAdd(user: user,index: index,);
                  },
                );
              }
              else{
                return CircularProgressIndicator();
              }
            }
        ),

      ),
    ),
    );
  }
}
