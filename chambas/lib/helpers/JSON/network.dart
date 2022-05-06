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
        required this.instagram,
        required this.github,
    });

    String facebook;
    String instagram;
    String github;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        facebook: json["facebook"],
        instagram: json["instagram"],
        github: json["github"],
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "github": github,
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