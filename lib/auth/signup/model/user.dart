import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User(
      {this.firstName,
       this.lastName,
       this.email,
       this.password,
       this.phone, this.isLoggedIn=false
       });
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? password;
  @HiveField(5)
  late bool isLoggedIn;
}
