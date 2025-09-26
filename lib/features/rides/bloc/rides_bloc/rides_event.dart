import 'package:equatable/equatable.dart';

abstract class RidesEvent extends Equatable {
  const RidesEvent();

  @override
  List<Object?> get props => [];
}

class GetRidesEvent extends RidesEvent {}

class LoadMoreRidesEvent extends RidesEvent {}
