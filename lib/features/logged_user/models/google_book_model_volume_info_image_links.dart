import 'package:json_annotation/json_annotation.dart';

part 'google_book_model_volume_info_image_links.g.dart';

@JsonSerializable()
class ImageLinks {
  String? thumbnail;
  ImageLinks();

  factory ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$ImageLinksFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);
}
