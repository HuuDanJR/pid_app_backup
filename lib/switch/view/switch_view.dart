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

  void handleSwitchAction(SwitchState state, BuildContext context) async {
    if (isProcessing) return;
    isProcessing = true;
    try {
      if (state is SwitchOn) {
        debugPrint("SwitchOn value true");
        // await service_api.restartCronJob();
      } else if (state is SwitchOff) {
        debugPrint("SwitchOn value false");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isProcessing = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProcessing =
        false; // Ensure isProcessing is false when the widget is initialized
  }

  @override
  void dispose() {
    debounce?.cancel(); // Dispose the debounce timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(const Duration(milliseconds: 500),
            () => handleSwitchAction(state, context));
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoSwitch(
                    value: state is SwitchOn,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(ToggleSwitch());
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    style: const TextStyle(color: Colors.white),
                    state is SwitchOn ? 'ENABLE AUTO' : 'DISABLE AUTO',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton.icon(
                icon: const Icon(Icons.stop_circle, color: Colors.red),
                onPressed: () async {
                  debugPrint('stop auto');
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Stop auto switch for PID screens"),
                        content: Text( 'Ads screen will not be display automatically, restart to make it work!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('CANCEL')),
                          TextButton.icon(
                              icon: Icon(Icons.verified_user_sharp),
                              onPressed: () async{
                                debugPrint('run stop cronjob');
                                // await service_api.stopCronJob().whenComplete((){
                                //   Navigator.of(context).pop();
                                // });
                              },
                              label: const Text('CONFIRM'))
                        ],
                      );
                    },
                  );
                },
                label:
                    Text('STOP AUTO', style: TextStyle(color: Colors.white))),
          ],
        );
      },
    );
  }
}
