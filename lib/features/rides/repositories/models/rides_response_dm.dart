import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';
import 'rides_dm.dart';

class RidesResponseDm extends Equatable {
  final int page;
  final int pageSize;
  final int total;
  final UnmodifiableListView<RidesDm>? rides;

  RidesResponseDm({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.rides,
  }) {
    Guard.against.negative(page, name: 'page');
    Guard.against.negative(pageSize, name: 'pageSize');
    Guard.against.negative(total, name: 'total');
  }

  factory RidesResponseDm.fromJson(Map<String, dynamic> json) {
    return RidesResponseDm(
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
      total: json['total'] as int,
      rides: UnmodifiableListView(
        (json['items'] as List<dynamic>?)
                ?.map((e) => RidesDm.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'pageSize': pageSize,
    'total': total,
    'rides': rides,
  };

  @override
  List<Object?> get props => [page, pageSize, total, rides];
}
