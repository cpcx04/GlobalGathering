class PostDto {
  final String relatedEvent;
  final String comment;

  PostDto({required this.relatedEvent, required this.comment});

  Map<String, dynamic> toJson() {
    return {'relatedEvent': relatedEvent, 'comment': comment};
  }
}
