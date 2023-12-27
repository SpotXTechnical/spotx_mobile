import 'package:equatable/equatable.dart';

abstract class CampDetailsEvent extends Equatable {}

class GetCampDetails extends CampDetailsEvent {
  final int id;
  GetCampDetails(this.id);

  @override
  List<Object?> get props => [id];
}
class ChangeContentType extends CampDetailsEvent {
  ChangeContentType();

  @override
  List<Object?> get props => [];
}
