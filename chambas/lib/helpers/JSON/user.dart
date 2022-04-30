
class ParseUser {
    ParseUser({
        required this.name,
        required this.lastname,
        required this.address,
        required this.age,
        required this.phone,
        required this.email,
        required this.role,
        required this.verify,
        required this.google,
        required this.createdAt,
        required this.img,
        required this.uid,
    });

    String name;
    String lastname;
    String address;
    String age;
    String phone;
    String email;
    String role;
    bool verify;
    bool google;
    DateTime createdAt;
    String img;
    String uid;

    factory ParseUser.fromJson(Map<String, dynamic> json) => ParseUser(
        name: json["name"],
        lastname: json["lastname"],
        address: json["address"],
        age: json["age"],
        phone: json["phone"],
        email: json["email"],
        role: json["role"],
        verify: json["verify"],
        google: json["google"],
        createdAt: DateTime.parse(json["createdAt"]),
        img: json["img"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "address": address,
        "age": age,
        "phone": phone,
        "email": email,
        "role": role,
        "verify": verify,
        "google": google,
        "createdAt": createdAt.toIso8601String(),
        "img": img,
        "uid": uid,
    };
}

class Usuario {
    Usuario({
        required this.id,
        required this.name,
        required this.lastname,
    });

    String id;
    String name;
    String lastname;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['_id'],
        name: json['name'],
        lastname: json['lastname'],
    );

    Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'lastname': lastname,
    };
}

class Reference {
    Reference({
        required this.id,
        required this.name,
        required this.lastname,
        required this.img
    });

    String id;
    String name;
    String lastname;
    String img;

    factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        img: json["img"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "img": img
    };
}
