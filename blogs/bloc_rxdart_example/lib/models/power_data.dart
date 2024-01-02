// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PowerData extends Equatable {
  const PowerData({
    required this.voltage,
    required this.current,
    required this.lastUpdated,
  });

  final double voltage;
  final double current;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [voltage, current, lastUpdated];

  PowerData copyWith({
    double? voltage,
    double? current,
    DateTime? lastUpdated,
  }) {
    return PowerData(
      voltage: voltage ?? this.voltage,
      current: current ?? this.current,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
