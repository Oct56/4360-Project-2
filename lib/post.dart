class NewPost {
  String id;
  String userId;
  String username;
  String caption;
  String imageURL;

  NewPost({
    required this.id,
    required this.userId,
    required this.username,
    required this.caption,
    required this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'caption': caption,
      'imageURL': imageURL,
    };
  }

  factory NewPost.fromMap(Map<String, dynamic> map) {
    return NewPost(
      id: map['id'],
      userId: map['userId'],
      username: map['username'],
      caption: map['caption'],
      imageURL: map['imageURL'],
    );
  }
}
