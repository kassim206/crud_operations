
import 'package:flutter/material.dart';
import '../../model/crud_data.dart';
import 'edit.dart';
class CardAdd extends StatefulWidget {
  CardAdd({required this.index, required this.user});
  var index;
  List<UserModel>user;
  @override
  State<CardAdd> createState() => _CardAddState();
}

class _CardAddState extends State<CardAdd> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController  = TextEditingController();
  // final TextEditingController phoneController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)),
        child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                Text(widget.user[widget.index].userName.toString()),
                Text(widget.user[widget.index].userAge.toString()),
              ],
            ),
            trailing: Column(
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditUser(
                        countobj: widget.user[widget.index],

                      )));
                    },
                    child: Icon(Icons.edit)),
                SizedBox(height: 6,),
                GestureDetector(
                    onTap: (){
                      widget.user[widget.index].ref!.delete();
                    },
                    child: Icon(Icons.delete)),
              ],
            )

        ),
      ),
    );
  }
}
