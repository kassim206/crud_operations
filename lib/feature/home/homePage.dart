import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudapp/feature/home/view_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/crud_data.dart';
import '../Auth/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController  = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    ageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 88,),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                  ),
                ),
                const SizedBox(height: 24,),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your age',
                  ),
                ),
                const SizedBox(height: 24,),
                const SizedBox(height: 14,),
                GestureDetector(
                  onTap: (){
                    if(
                    usernameController?.text == ""||
                        ageController?.text ==""
                    ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Enter all details")));
                    }else{
                      var newuser =UserModel(userName:usernameController.text,
                          userAge:int.parse(ageController!.text),
                          createDate: DateTime.now());
                      FirebaseFirestore.instance.collection('collections').
                      add(newuser.toJson()).then((value) async {

                        var a=await value.get().then((valu){

                          value.update({
                            'ref':     valu.reference,
                          });
                          value.update({
                            'uid': valu.id,
                          });
                        } );

                      }
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("successfully added")));
                      usernameController.clear();
                      ageController.clear();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewList()));
                    }
                  },
                  child: Container(
                    child: const Text('Add New User'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)
                      ),
                    ),
                        color: Colors.blue
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(left: 100,top: 50),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewList()));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.black,
                          child: Center(child: Text('View',style: TextStyle(color: Colors.white),)),

                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.remove('isLogged');
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Container(
                            width: 70,
                            height: 50,
                            color: Colors.black,
                            child: Center(child: Text('LogOut',style: TextStyle(color: Colors.white),)),

                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
