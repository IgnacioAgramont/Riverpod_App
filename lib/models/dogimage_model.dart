class DogImage {
  String message;

  DogImage({required this.message});

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return DogImage(
      message: json['message'],
    );
  } 
}
