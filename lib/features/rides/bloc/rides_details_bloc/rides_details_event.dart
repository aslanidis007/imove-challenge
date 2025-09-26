import 'package:equatable/equatable.dart';

abstract class RidesDetailsEvent extends Equatable {
  const RidesDetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetRidesDetailsEvent extends RidesDetailsEvent {
  final String serviceId;

  const GetRidesDetailsEvent({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}
