class Social {
    Social({
        required this.media,
    });

    Media media;

    factory Social.fromJson(Map<String, dynamic> json) => Social(
        media: Media.fromJson(json["media"]),
    );

    Map<String, dynamic> toJson() => {
        "media": media.toJson(),
    };
}

class Media {
    Media({
        required this.facebook,
        required this.whatsapp,
        required this.linkedin,
        required this.github,
        required this.youtube,
        required this.instagram,
        required this.twitter,
    });

    String facebook;
    String whatsapp;
    String instagram;
    String github;
    String twitter;
    String youtube;
    String linkedin;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        facebook: json["facebook"] ?? '',
        whatsapp: json["whatsapp"] ?? '',
        linkedin: json["linkedin"] ?? '',
        github: json["github"] ?? '',
        youtube: json["youtube"] ?? '',
        instagram: json["instagram"] ?? '',
        twitter: json["twitter"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "github": github,
        "youtube" : youtube,
        "linkedin" : linkedin
    };
}
class Meta {
    Meta({
        required this.likes,
        required this.dislikes,
    });

    int likes;
    int dislikes;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        likes: json["likes"],
        dislikes: json["Dislikes"],
    );

    Map<String, dynamic> toJson() => {
        "likes": likes,
        "Dislikes": dislikes,
    };
}