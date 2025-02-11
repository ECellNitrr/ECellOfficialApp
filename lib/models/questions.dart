class Questions {
  String? question;
  List<String>? answers;
  int? correctIndex;
  bool? isImage;
  List<String>? images;

  Questions(
      {this.question,
      this.answers,
      this.correctIndex,
      this.images,
      required this.isImage});

  // factory Questions.fromJson(Map<String, dynamic> json) => Questions(
  //       question: json["question"],
  //       answers: List<String>.from(json["answers"].map((x) => x)),
  //       correctIndex: json["correctIndex"],
  //       images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
  //   );

  factory Questions.fromFirestore(Map<String, dynamic> data) {
    return Questions(
        question: data["question"],
        answers: List<String>.from(data["answers"].map((x) => x)),
        correctIndex: data["correctIndex"],
        isImage: data["isImage"],
        images: data["images"] == null
            ? null
            : List<String>.from(data["images"].map((x) => x)));
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
