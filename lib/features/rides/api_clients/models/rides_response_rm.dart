import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';
import 'rides_rm.dart';

class RidesResponseRm extends Equatable {
  final int page;
  final int pageSize;
  final int total;
  final UnmodifiableListView<RidesRm>? rides;

  RidesResponseRm({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.rides,
  }) {
    Guard.against.negative(page, name: 'page');
    Guard.against.negative(pageSize, name: 'pageSize');
    Guard.against.negative(total, name: 'total');
  }

  factory RidesResponseRm.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return RidesResponseRm(
      page: data['page'] as int,
      pageSize: data['pageSize'] as int,
      total: data['total'] as int,
      rides: UnmodifiableListView(
        (data['items'] as List<dynamic>?)
                ?.map((e) => RidesRm.fromJson(e as Map<String, dynamic>))
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
