import 'package:appwrite_employee/appwrite.dart';
import 'package:appwrite_employee/list.dart';
import 'package:flutter/material.dart';

class Employeeform extends StatefulWidget{
  @override
  State<Employeeform> createState()=> _EmployeeformState();
}

class _EmployeeformState extends State<Employeeform>{

  late AppwriteService _appwriteService;
  late List<Employee> _employees;

  TextEditingController nameC=TextEditingController();
  TextEditingController ageC=TextEditingController();
  TextEditingController locationC=TextEditingController();

  String? _editingEmployeeId; // track the id of the employye being edited

  Future <void> _loadEmployeeDetails()async{
    try{
      final tasks=await _appwriteService.getEmployeeDetails();
      setState(() {
        _employees = tasks.map((e) => Employee.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading tasks:$e");
    }
  }

  Future<void> _addOrUpdateEmployeeDetails()async{
    final name=nameC.text;
    final age=ageC.text;
    final location=locationC.text;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Form"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 400,
                width: 410,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: nameC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),),
                          labelText: "Name",labelStyle: TextStyle(fontSize: 20,color: Colors.blue),),
                    ),
                    TextField(
                      controller: ageC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),),
                          labelText: "Age",labelStyle: TextStyle(fontSize: 20,color: Colors.blue),),
                    ),
                    TextField(
                      controller: locationC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),),
                          labelText: "Location",labelStyle: TextStyle(fontSize: 20,color: Colors.blue),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                    onPressed: (){},
                    child: Text("Add",style: TextStyle(fontSize: 20,color: Colors.white),))
                  ],
              
                ),
              ),
            );
          });
        },
        child: Icon(Icons.add,color: Colors.blue,),
        ),
    );
  }
}