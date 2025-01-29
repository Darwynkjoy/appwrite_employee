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

  @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _employees=[];
    _loadEmployeeDetails();
  }

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

    if(name.isNotEmpty && age.isNotEmpty && location.isNotEmpty){
      try{
        if(_editingEmployeeId == null){
          await _appwriteService.addEmployeeDetails(name, age, location);
        }else{
          await _appwriteService.updateEmployeeDetails(name, age, location,_editingEmployeeId!);
        }
          nameC.clear();
          ageC.clear();
          locationC.clear();
          _editingEmployeeId == null;
          _loadEmployeeDetails();
      }catch(e){
        print("error adding or Deleting task:$e");
      }
    }
  }
    Future<void> _deleteEmployeeDetails(String taskId)async{
      try{
        await _appwriteService.deleteEmployee(taskId);
        _loadEmployeeDetails();
      }catch(e){
        print("error deleting task:$e");
      }
    }

  void _editEmployeeDetails(Employee employee){
    nameC.text = employee.name;
    ageC.text=employee.age;
    locationC.text=employee.location;
    _editingEmployeeId=employee.id;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Form"),
        centerTitle: true,
      ),

      //
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        itemCount: _employees.length,
        itemBuilder: (context,index){
          final employer=_employees[index];
          
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: const Color.fromARGB(255, 183, 232, 255)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${employer.name}",style: TextStyle(fontSize: 16,),),
                  Text("Age: ${employer.age}",style: TextStyle(fontSize: 16,),),
                  Text("Loacation: ${employer.location}",style: TextStyle(fontSize: 16,),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        _editEmployeeDetails(employer);
                        showModalBottomSheet(context: context, builder: (BuildContext context){
            return _buildEmployeeForm();
           
          });

                      }, icon: Icon(Icons.edit,color: Colors.blue,)),
                      IconButton(onPressed: (){
                        _deleteEmployeeDetails(employer.id);
                      }, icon: Icon(Icons.delete,color: Colors.blue,))
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),

      //adding details button
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (BuildContext context){
            return _buildEmployeeForm();
           
          });
        },
        child: Icon(Icons.add,color: Colors.blue,),
        ),
    );
  }
  Widget _buildEmployeeForm(){
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
                    onPressed: (){
                      _addOrUpdateEmployeeDetails();
                      Navigator.pop(context);
                    },
                    child: Text(_editingEmployeeId == null ? "Add" : "Update",style: TextStyle(fontSize: 20,color: Colors.white),))
                  ],
              
                ),
              ),
            );
  }
}