import "dart:developer";

import 'package:insta_clone/features/data/data_source/remote_data_sources/remote_data_sources.dart';
import "package:insta_clone/features/data/models/user/user_model.dart";
import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:insta_clone/utils/global_variables.dart";

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl(
      {required this.firebaseFirestore,
      required this.firebaseAuth,
      required this.firebaseStorage});

  @override
  Future<void> createUser(UserEntity user) async {
    try {
      final userCollection = firebaseFirestore.collection(FirebaseConst.users);
      final uid = await getCurrentUid();
      userCollection.doc(uid).get().then((userDoc) async {
        final newUser = UserModel(
          uid: uid,
          name: user.name,
          email: user.email,
          bio: user.bio,
          following: user.following,
          website: user.website,
          profileUrl: user.profileUrl,
          userName: user.userName,
          totalFollowers: user.totalFollowers,
          followers: user.followers,
          totalFollowing: user.totalFollowing,
          totalPosts: user.totalPosts,
        ).toJson();

        if (!userDoc.exists) {
          userCollection.doc(uid).set(newUser);
        } else {
          userCollection.doc(uid).update(newUser);
        }
      });
    } catch (e) {
      toast("Some eoor occured");
    }
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUsers(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map(
          (querySnapshots) => querySnapshots.docs
              .map(
                (e) => UserModel.fromSnapshot(e),
              )
              .toList(),
        );
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map(
          (querySnapshot) =>
              querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList(),
        );
  }

  @override
  Future<bool> isLogIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> isLogout() async => await firebaseAuth.signOut();
  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      } else {
        log("Field shouldn't be empty");
      }
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("user not found");
      } else if (e.code == "wrong-password") {
        toast("Invalid email or password");
      }
    }
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((value) async {
        if (value.user?.uid != null) {
          await createUser(user);
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
      }
    }
  }

  @override
  Future<void> updateuser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if (user.userName != "" && user.userName != null) {
      userInformation['username'] = user.userName;
    }

    if (user.website != "" && user.website != null) {
      userInformation['website'] = user.website;
    }

    if (user.profileUrl != "" && user.profileUrl != null) {
      userInformation['profileUrl'] = user.profileUrl;
    }

    if (user.bio != "" && user.bio != null) userInformation['bio'] = user.bio;

    if (user.name != "" && user.name != null) {
      userInformation['name'] = user.name;
    }

    if (user.totalFollowing != null) {
      userInformation['totalFollowing'] = user.totalFollowing;
    }

    if (user.totalFollowers != null) {
      userInformation['totalFollowers'] = user.totalFollowers;
    }

    if (user.totalPosts != null) {
      userInformation['totalPosts'] = user.totalPosts;
    }

    return userCollection.doc(user.uid).update(userInformation);
  }
}
