import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pid_controller/service_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../export.dart';
import 'dart:async';


class SwitchButton extends StatefulWidget {
  SwitchButton({Key? key}) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  final service_api = ServiceAPIs();
  Timer? debounce;
  bool isProcessing = false;

  void handleSwitchAction(SwitchState state) {
    if (isProcessing) return;

    isProcessing = true;

    if (state is SwitchOn) {
      print("status = true");
      service_api.restartCronJob().then((_) {
        isProcessing = false;
      });
    } else if (state is SwitchOff) {
      print("status = false");
      service_api.stopCronJob().then((_) {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(Duration(milliseconds: 300), () => handleSwitchAction(state));

        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CupertinoSwitch(
                value: state is SwitchOn,
                onChanged: (value) {
                  context.read<SwitchBloc>().add(ToggleSwitch());
                },
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                style: TextStyle(color: Colors.white),
                state is SwitchOn ? 'ENABLE AUTO' : 'DISABLE AUTO',
              ),
            ],
          ),
        );
      },
    );
  }
}