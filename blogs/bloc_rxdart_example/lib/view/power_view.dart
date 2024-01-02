import 'package:bloc_rxdart_example/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PowerView extends StatelessWidget {
  const PowerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power'),
      ),
      body: BlocListener<PowerNotifierBloc, PowerNotifierState>(
        listener: (context, state) {
          switch (state) {
            case PowerNotifierSuccess():
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Power change notified')),
                );
            case PowerNotifierError():
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text('Failed to notify power change')),
                );
            default:
              break;
          }
        },
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PowerSwitch(),
              SizedBox(height: 16),
              LastPowerDataUpdate(),
            ],
          ),
        ),
      ),
    );
  }
}

class PowerSwitch extends StatelessWidget {
  const PowerSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerSwitchBloc, PowerSwitchState>(
      builder: (context, state) {
        return Switch(
          value: state.power,
          onChanged: (value) {
            context.read<PowerSwitchBloc>().add(const ToggleSwitch());
          },
        );
      },
    );
  }
}

class LastPowerDataUpdate extends StatelessWidget {
  const LastPowerDataUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PowerDataBloc, PowerDataState>(
      builder: (context, state) {
        return switch (state) {
          PowerDataLoading() =>
            const Center(child: CircularProgressIndicator()),
          PowerDataLoaded(:final powerData) =>
            Center(child: Text(powerData.toString())),
          PowerDataError(:final failure) =>
            Center(child: Text(failure.message)),
        };
      },
    );
  }
}
