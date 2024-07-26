import 'dart:convert';

class Base64DTO {
  final String id;
  final String source;
  Base64DTO({
    required this.id,
    required this.source,
  });

  Base64DTO copyWith({
    String? id,
    String? source,
  }) {
    return Base64DTO(
      id: id ?? this.id,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'source': source,
    };
  }

  factory Base64DTO.fromMap(Map<String, dynamic> map) {
    return Base64DTO(
      id: map['id'] as String,
      source: map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Base64DTO.fromJson(String source) =>
      Base64DTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Base64DTO(id: $id, source: $source)';

  @override
  bool operator ==(covariant Base64DTO other) {
    if (identical(this, other)) return true;

    return other.id == id && other.source == source;
  }

  @override
  int get hashCode => id.hashCode ^ source.hashCode;
}
