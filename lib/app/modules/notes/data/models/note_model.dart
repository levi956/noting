import 'package:hive_flutter/hive_flutter.dart';
import 'package:noting/app/shared/functions/datetime_functions.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime? deletedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.deletedAt,
  });

  String get date => formatDateTime(createdAt);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"].toString(),
      title: json["name"],
      content: json["body"],
      createdAt: generateRandomDateTimeWithinCurrentWeek(),
      deletedAt: null,
    );
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
