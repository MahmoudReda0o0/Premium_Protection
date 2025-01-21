import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excp_training/main.dart';
import 'package:excp_training/model/firebase/FB_field_name.dart';
import 'package:excp_training/view/tasks/add_new_task.dart';
import 'package:excp_training/view/widget/SnackBarCustom.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/type_model.dart';

class FB_FirestoreTaskType {
  bool? success;
  String? message;
  List<String>? addedTypeList;

  FB_FirestoreTaskType({this.success, this.message, this.addedTypeList});

  static Future<FB_FirestoreTaskType> addTypeList(
      {required List<String> typeList}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final collectionRef = FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskType);
        final collectionGet = await collectionRef.get();
        if (collectionGet.docs.isEmpty) {
          // collection is empty create new document
          await FirebaseFirestore.instance
              .collection(FB.collectionUserInfo)
              .doc(user.uid)
              .collection(FB.collectionTaskType)
              .doc()
              .set({
            FB.typeAddedList: typeList,
          });
          return FB_FirestoreTaskType(
              success: true,
              message: 'everything is ok',
              addedTypeList: typeList);
        } else {
          // collection has document update document
          final fristDoc = collectionGet.docs.first.id;
          await collectionRef
              .doc(fristDoc)
              .update(TypeModel(addedList: typeList).toFirestore());
          return FB_FirestoreTaskType(
              success: true,
              message: 'everything is ok',
              addedTypeList: typeList);
        }
      } else {
        return FB_FirestoreTaskType(
            success: false, message: 'User is null', addedTypeList: []);
      }
    } catch (e) {
      print(e);
      return FB_FirestoreTaskType(
          success: false,
          message: 'firestore catch error: $e',
          addedTypeList: []);
    }
  }

  static Future<FB_FirestoreTaskType> getTypeList() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final collectionRef = FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskType);
        final collectionGet = await collectionRef.get();
        final docsRef = collectionGet.docs;
        if (docsRef.isEmpty) {
          return FB_FirestoreTaskType(
            success: true,
            message: 'Type List is empty',
            addedTypeList: [],
          );
        } else {
          final data = TypeModel.fromFirestore(docsRef.first.data());
          return FB_FirestoreTaskType(
            success: true,
            message: 'everything is ok',
            addedTypeList: data.addedList,
          );
        }
      } else {
        return FB_FirestoreTaskType(
          success: false,
          message: 'User is null',
          addedTypeList: [],
        );
      }
    } catch (e) {
      return FB_FirestoreTaskType(
        success: false,
        message: 'firestore catch error: $e',
        addedTypeList: [],
      );
    }
  }

  static Future<FB_FirestoreTaskType> updateTypeList(
      {required List<String> updatedTypeList}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final collectionRef = FirebaseFirestore.instance
            .collection(FB.collectionUserInfo)
            .doc(user.uid)
            .collection(FB.collectionTaskType);
        final collectionGet = await collectionRef.get();
        await collectionRef
            .doc(collectionGet.docs.first.id)
            .update(TypeModel(addedList: updatedTypeList).toFirestore());
       
        return FB_FirestoreTaskType(
            success: true, message: 'everything is ok', addedTypeList: []);
      } else {
        return FB_FirestoreTaskType(
            success: false, message: 'User is null', addedTypeList: []);
      }
    } catch (e) {
      return FB_FirestoreTaskType(
          success: false,
          message: 'firestore catch error: $e',
          addedTypeList: []);
    }
  }

  // static Future<FB_FirestoreTaskType> updateTypeList(
  //     {required List<String> addNewTypeList}) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final collectionRef = FirebaseFirestore.instance
  //           .collection(FB.collectionUserInfo)
  //           .doc(user.uid)
  //           .collection(FB.collectionTaskType);
  //       final collectionGet = await collectionRef.get();
  //       final docsRef = collectionGet.docs;
  //       if (docsRef.isEmpty) {
  //         //await collectionRef.add(TypeModel(addNewTypeList).toFirestore());
  //         await collectionRef.add(TypeModel(addNewTypeList).toFirestore());
  //         print('🤦‍♀️🤦‍♀️🤦‍♀️');
  //         return FB_FirestoreTaskType(
  //             success: true,
  //             message: 'everything is ok',
  //             addedTypeList: addNewTypeList);
  //       } else {
  //         final fristDoc = docsRef.first.id;
  //         await collectionRef
  //             .doc(fristDoc)
  //             .update(TypeModel(addNewTypeList).toFirestore());
  //         print('🤦🤦🤦');
  //         return FB_FirestoreTaskType(
  //           success: true,
  //           message: 'everything is ok',
  //           addedTypeList: addNewTypeList,
  //         );
  //       }
  //     } else {
  //       return FB_FirestoreTaskType(
  //         success: false,
  //         message: 'User is null',
  //       );
  //     }
  //   } catch (e) {
  //     return FB_FirestoreTaskType(
  //       success: false,
  //       message: 'firestore catch error: $e',
  //     );
  //   }
  // }

  // Future<FB_FirestoreTaskType> addOrUpdateTaskType(
  //     {required String newTaskType}) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       return FB_FirestoreTaskType(
  //         success: false,
  //         errorMessage: 'User not authenticated',
  //       );
  //     }

  //     // Reference to the Task Type collection
  //     final collectionRef = FirebaseFirestore.instance
  //         .collection(FB.collectionUserInfo)
  //         .doc(user.uid)
  //         .collection(FB.collectionTaskType);

  //     // Check if the collection has any documents
  //     final querySnapshot = await collectionRef.get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Collection exists; update the document
  //       final docRef =
  //           collectionRef.doc('e8GDAZggWVbLwDQI1cQW'); // Example document ID
  //       final snapshot = await docRef.get();

  //       if (snapshot.exists) {
  //         // If the document exists, update its typeList
  //         TypeModel typeModel = TypeModel.fromFirestore(snapshot.data()!);

  //         // Ensure the task doesn't already exist in the list
  //         if (typeModel.addedList != null &&
  //             !typeModel.addedList!.contains(newTaskType)) {
  //           typeModel.addedList!.add(newTaskType);
  //           await docRef.update(typeModel.toFirestore()); // Update the document
  //         }

  //         return FB_FirestoreTaskType(
  //           success: true,
  //           addedTypeList: typeModel,
  //         );
  //       } else {
  //         // If no document exists in the collection, create a new document
  //         TypeModel typeModel = TypeModel(
  //             [newTaskType], 'e8GDAZggWVbLwDQI1cQW'); // Example doc ID
  //         await docRef.set(typeModel.toFirestore());

  //         return FB_FirestoreTaskType(
  //           success: true,
  //           addedTypeList: typeModel,
  //         );
  //       }
  //     } else {
  //       // Collection does not exist; create it and add a new document
  //       final docRef =
  //           collectionRef.doc('e8GDAZggWVbLwDQI1cQW'); // Example document ID
  //       TypeModel typeModel =
  //           TypeModel([newTaskType], 'e8GDAZggWVbLwDQI1cQW'); // Example doc ID
  //       await docRef.set(typeModel.toFirestore());

  //       return FB_FirestoreTaskType(
  //         success: true,
  //         addedTypeList: typeModel,
  //       );
  //     }
  //   } catch (e) {
  //     return FB_FirestoreTaskType(
  //       success: false,
  //       errorMessage: e.toString(),
  //     );
  //   }
  // }

  // Future<FB_FirestoreTaskType> getTaskTypeList() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final response = await FirebaseFirestore.instance
  //           .collection(FB.collectionUserInfo)
  //           .doc(user.uid)
  //           .collection(FB.collectionTaskType)
  //           .doc('e8GDAZggWVbLwDQI1cQW')
  //           .get();
  //       if (response.exists) {
  //         Map<String, dynamic> data = response.data() as Map<String, dynamic>;
  //         TypeModel type = TypeModel.fromFirestore(data);
  //         return FB_FirestoreTaskType(
  //           success: true,
  //           errorMessage: 'everything is ok',
  //           typeList: [type],
  //         );
  //       } else {
  //         return FB_FirestoreTaskType(
  //           success: false,
  //           errorMessage: 'doc is null',
  //           typeList: [],
  //         );
  //       }
  //     } else {
  //       return FB_FirestoreTaskType(
  //         success: false,
  //         errorMessage: 'User is null',
  //         typeList: [],
  //       );
  //     }
  //   } catch (e) {
  //     return FB_FirestoreTaskType(
  //       success: false,
  //       errorMessage: 'firestore catch error: $e',
  //       typeList: [],
  //     );
  //   }
  // }
}
