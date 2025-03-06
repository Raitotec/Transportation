import '../Models/User.dart';

class UserApi {
  Future<List<User>> getNames() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Return mock data
    return [
      User(email: '1', token: 'Alice'),
      User(email: '2', token: 'Bob'),
      User(email: '3', token: 'Charlie'),
      User(email: '4', token: 'David'),
      User(email: '5', token: 'Eve'),
    ];
  }
}