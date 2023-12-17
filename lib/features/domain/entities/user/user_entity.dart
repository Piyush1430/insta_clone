import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? userName;
  final String? name;
  final String? bio;
  final String? website;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  //this data not stored in DB
  final String? password;
  final String? otherUid;

  const UserEntity({
    this.uid,
    this.email,
    this.userName,
    this.name,
    this.bio,
    this.website,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
    this.password,
    this.otherUid,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        userName,
        name,
        bio,
        website,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        totalPosts,
        password,
        otherUid,
      ];
}
