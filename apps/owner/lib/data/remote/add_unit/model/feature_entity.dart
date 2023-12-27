import 'package:equatable/equatable.dart';
import 'package:owner/generated/json/base/json_field.dart';
import 'package:owner/generated/json/feature_entity.g.dart';

@JsonSerializable()
class Feature extends Equatable {
  factory Feature.fromJson(Map<String, dynamic> json) => $FeatureFromJson(json);

  Map<String, dynamic> toJson() => $FeatureToJson(this);

  int? id;
  String? name;
  String? url;
  bool isSelected;

  Feature({this.name, this.url, this.isSelected = false, this.id});

  static createFeature(List<Feature>? features) {
    List<Feature> newList = List.empty(growable: true);
    if (features != null) {
      for (var element in features) {
        newList.add(Feature(name: element.name, url: element.url, isSelected: element.isSelected, id: element.id));
      }
    }
    return newList;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, url, isSelected, id];
}
