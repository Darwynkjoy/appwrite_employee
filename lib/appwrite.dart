import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static  const endpoint="https://cloud.appwrite.io/v1";
  static const projectId="67987c53002485853dd0";
  static const databasesId="67987cd6003a0462f22d";
  static const collectionId="67987cf80030935b9185";

  AppwriteService(){
    client =Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases=Databases(client);
  }

  Future<List<Document>> getEmployeeDetails()async{
    try{
      final result =await databases.listDocuments(databaseId: databasesId, collectionId: collectionId);
      return result.documents;
    }catch(e){
      print("error loading tasks: $e");
      rethrow;
    }
  }

Future<Document> addEmployeeDetails(String name,String age,String location)async{
  try{
    final documentId=ID.unique();

    final result = await databases.createDocument(
      collectionId:collectionId,
      databaseId: databasesId,
      data:{
        "name":name,
        "age":age,
        "location":location,
      },
      documentId:documentId,
    );
    return result;
  }catch(e){
    print("error creating task:$e");
    rethrow;
  }
}

Future<Document> updateEmployeeDetails(String documentId,String name,String age,String location)async{
  try{
    final result= await databases.updateDocument(
      collectionId:collectionId,
      databaseId: databasesId,
      documentId: documentId,
      data:{
        "name":name,
        "age":age,
        "location":location,
      },
    );
    return result;
  }catch(e){
    print("error updating task:$e");
    rethrow;
  }
}

Future<void> deleteEmployee(String documentId)async{
  try{
    await databases.deleteDocument(
      collectionId:collectionId,
      documentId: documentId,
      databaseId: databasesId,
    );
  }catch(e){
    print("error updating task:$e");
    rethrow;
  }
}
}

