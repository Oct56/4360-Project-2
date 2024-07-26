class NewPost{
  String id;
  String username;
  String caption;
  String imageURL;
  List<String> likes;

  NewPost({required this.id, required this.username, required this.caption, required this.imageURL, required this.likes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'caption': caption,
      'imageURL': imageURL,
      'likes': likes
    };
  }

  factory NewPost.fromMap(Map<String, dynamic> map) {
    return NewPost(
      id: map['id'],
      username: map['username'],
      caption: map['caption'],
      imageURL: map['imageURL'],
      likes: List<String>.from(map['likes'])
    );
  }
}