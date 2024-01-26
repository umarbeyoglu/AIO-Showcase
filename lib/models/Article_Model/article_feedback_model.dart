class PostFeedback {
  final String id;
  final String authorstring;
  final String receiver;
  final String content;
  final DateTime timestamp;

  PostFeedback({this.id,this.authorstring,this.receiver,this.content,this.timestamp});

  factory  PostFeedback.fromJSON(Map<String, dynamic> jsonMap) {
    return  PostFeedback(
      id: jsonMap['id'] as String,
      authorstring: jsonMap['author'] as String,
      receiver: jsonMap['receiver'] as String,
      content: jsonMap['content'] as String,
      timestamp: jsonMap['timestamp'] as DateTime,
    );
  }
}