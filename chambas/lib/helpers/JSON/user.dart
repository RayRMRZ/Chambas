
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
