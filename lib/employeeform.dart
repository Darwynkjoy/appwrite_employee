import 'package:flutter/material.dart';

class Employeeform extends StatefulWidget{
  @override
  State<Employeeform> createState()=> _EmployeeformState();
}

class _EmployeeformState extends State<Employeeform>{

  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController location=TextEditingController();

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
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),),
                          labelText: "Name",labelStyle: TextStyle(fontSize: 20,color: Colors.blue),),
                    ),
                    TextField(
                      controller: age,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),),
                          labelText: "Age",labelStyle: TextStyle(fontSize: 20,color: Colors.blue),),
                    ),
                    TextField(
                      controller: location,
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