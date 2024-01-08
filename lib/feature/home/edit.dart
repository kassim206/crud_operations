import 'package:flutter/material.dart';
import '../../model/crud_data.dart';
class EditUser extends StatefulWidget {
  final UserModel countobj;
  EditUser({required this.countobj});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController? usernameController;
  TextEditingController? ageController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController =TextEditingController(text: widget.countobj.userName);
    ageController =TextEditingController(text: widget.countobj.userAge.toString());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 88,),
            TextFormField(
              controller: usernameController,
            ),
            const SizedBox(height: 24,),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: 'Enter your age',
              ),
            ),
            const SizedBox(height: 24,),
            const SizedBox(height: 14,),
            GestureDetector(
              onTap: (){

              },
              child: GestureDetector(
                onTap: () async {

                  if(
                  usernameController?.text == ""||
                      ageController?.text ==""
                  ){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Enter all details")));
                  }else{
                    var a =widget.countobj.copyWith(
                      userName: usernameController!.text,
                      userAge: int.parse(ageController!.text),
                    );
                    Navigator.pop(context);
                    widget.countobj.ref?.update(a.toJson());
                  }
                },
                child: Container(
                  child: const Text('Edited'),
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
            ),
            const SizedBox(height: 12,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category, color: Colors.black,),
              label: '',
            ),
          ]),
    );
  }
}
