import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pid_controller/service_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pid_controller/widget/custom_snackbar.dart';
import '../export.dart';
import 'dart:async';



class SwitchButton extends StatelessWidget {
  final serviceApi = ServiceAPIs();
  void handleSwitchAction(SwitchState state, BuildContext context) async {
    try {
      if (state is SwitchOn) {
        debugPrint("SwitchOn value true");
        // await serviceApi.restartCronJob();
      } else if (state is SwitchOff) {
        debugPrint("SwitchOff value false");
        // await serviceApi.stopCronJob();
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        // Immediately handle switch action when state changes
        handleSwitchAction(state, context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoSwitch(
                  value: state is SwitchOn,
                  activeColor: Colors.blue,
                  trackColor: Colors.grey,
                  focusColor: Colors.blue,
                  onChanged: (value) {
                    context.read<SwitchBloc>().add(ToggleSwitch());
                  },
                ),
                const SizedBox(width: 8.0),
                Text(
                  style: const TextStyle(color: Colors.white),
                  state is SwitchOn ? 'ENABLE AUTO' : 'DISABLE AUTO',
                ),
              ],
            ),
            const SizedBox(height: 16.0),
       
            state is SwitchOn ?  Tooltip(
              message: "Click button to stop auto function",
              child: TextButton.icon(
                icon: const Icon(Icons.stop_circle, color: Colors.red),
                onPressed: () {
                  debugPrint('stop auto');
                  context.read<SwitchBloc>().add(SwitchOffEvent());
                              // Optionally call the API to stop the cron job
                              // await serviceApi.stopCronJob().then((value) {
                              //   customSnackBar(context: context, message: 'Stop auto successfully');
                              // }).whenComplete(() {
                              //   Navigator.of(context).pop();
                              // });
              
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: const Text("Stop auto switch for PID screens"),
                  //       content: const Text(
                  //         'Ads screen will not be display automatically, restart to make it work!',
                  //       ),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: const Text('CANCEL'),
                  //         ),
                  //         TextButton.icon(
                  //           icon: const Icon(Icons.verified_user_sharp),
                  //           onPressed: ()  {
                  //             debugPrint('run stop cronjob');
                  //             context.read<SwitchBloc>().add(SwitchOffEvent());
                  //             // Optionally call the API to stop the cron job
                  //             // await serviceApi.stopCronJob().then((value) {
                  //             //   customSnackBar(context: context, message: 'Stop auto successfully');
                  //             // }).whenComplete(() {
                  //             //   Navigator.of(context).pop();
                  //             // });
                  //           },
                  //           label: const Text('CONFIRM'),
                  //         ),
                  //       ],
                  //     );
                    // },
                  // );
                },
                label: const Text('STOP AUTO', style: TextStyle(color: Colors.white)),
              ),
            ) : Text("AUTO MODE: OFF",style: TextStyle(color:Colors.white),),
          ],
        );
      },
    );
  }
}