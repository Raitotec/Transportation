class DelegateDataModel {
  User? user;
  Authorisation? authorisation;

  DelegateDataModel({this.user, this.authorisation});

  DelegateDataModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    authorisation = json['authorisation'] != null
        ? new Authorisation.fromJson(json['authorisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.authorisation != null) {
      data['authorisation'] = this.authorisation!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;

  User(
      {this.id,
        this.name,
        this.email,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']??"";
    email = json['email']??"";
    image=json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}


class Authorisation {
  String? token;
  List<UserPermissions>? userPermissions;

  Authorisation({this.token, this.userPermissions});

  Authorisation.fromJson(Map<String, dynamic> json) {
    token = json['token']??"";
    if (json['user_permissions'] != null) {
      userPermissions = <UserPermissions>[];
      json['user_permissions'].forEach((v) {
        userPermissions!.add(new UserPermissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userPermissions != null) {
      data['user_permissions'] =
          this.userPermissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPermissions {
  int? id;
  String? name;
  String? displayName;
  String? description;
  bool? hasPermission;

  UserPermissions(
      {this.id,
        this.name,
        this.displayName,
        this.description,
        this.hasPermission});

  UserPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    hasPermission = json['has_permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['has_permission'] = this.hasPermission;
    return data;
  }
}


