// import 'package:flutter/material.dart';
// import 'package:pid_controller/model/pidmodel.dart';
// import 'package:pid_controller/service_api.dart';
// import 'package:pid_controller/socket_manager.dart';
// import 'package:pid_controller/widget/custom_snackbar.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({super.key});

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   // final service_api = ServiceAPIs();
//   // final socketIO = SocketManager();
//   @override
//   void initState() {
//     //INIT SOCKET
//     // socketIO.initSocket();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     socketIO.disposeSocket();
//     super.dispose();
//   }

//   @override
//   void didChangeDependencies() {
//     socketIO.disposeSocket();
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         body: SizedBox(
//             height: height,
//             width: width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       print('dispose socket');
//                       socketIO.disposeSocket();
//                     },
//                     child: Text('Stop')),
//                 TextButton(
//                     onPressed: () {
//                       print('restart socket');
//                     },
//                     child: Text('Restart')),
//               ],
//             )));
//   }
// }
