import 'package:flutter/material.dart';
import 'package:pid_controller/model/pidmodel.dart';
import 'package:pid_controller/service_api.dart';
// import 'package:pid_controller/socket_manager.dart';
import 'package:pid_controller/widget/custom_snackbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service_api = ServiceAPIs();
  late PidModel model_pid = PidModel(rl1: '0', rl2: '0', bc3: '0', bc4: '0',ads:'0');
  // final socketIO = SocketManager();
  @override
  void initState() {
    //INIT SOCKET
    // socketIO.initSocket();
    //INIT API
    service_api.fetchEnum().then((value) {
      setState(() {
        model_pid = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pid_bg2.png'), fit: BoxFit.cover)),
            child:ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height*.315,
                  // height: height*.315,
                  width: width,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonImage(
                        onTap: () {
                          debugPrint('tap1 ${model_pid.rl1}');
                          service_api.loadPresetByID(int.parse(model_pid.rl1)).then((value) {
                            customSnackBar(
                                      context: context,
                                      message: '$value');
                          });
                        },
                        imageAsset: 'pid_rl1.png'),
                    // const SizedBox(
                    //   width: 35,
                    // ),
                    buttonImage(
                        onTap: () {
                          debugPrint('tap2');
                          //id 3
                          service_api.loadPresetByID(int.parse(model_pid.rl2)).then((value) {
                            customSnackBar(
                                      context: context,
                                      message: '$value');
                          });
                        },
                        imageAsset: 'pid_rl2.png')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonImage(
                        onTap: () {
                          debugPrint('tap3');
                           service_api.loadPresetByID(int.parse(model_pid.bc3)).then((value) {
                            customSnackBar(
                                      context: context,
                                      message: '$value');
                          });
                        },
                        imageAsset: 'pid_bc3.png'),
                    // const SizedBox(
                    //   width: 35,
                    // ),
                    buttonImage(
                        onTap: () {
                          debugPrint('tap4');
                           service_api.loadPresetByID(int.parse(model_pid.bc4)).then((value) {
                            customSnackBar(
                                      context: context,
                                      message: '$value');
                          });
                        },
                        imageAsset: 'pid_bc4.png')
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     buttonImage(
                //         onTap: () {
                //           debugPrint('tap5');
                //            service_api.loadPresetByID(int.parse(model_pid.ads)).then((value) {
                //             customSnackBar(
                //                       context: context,
                //                       message: '$value');
                //           });
                //         },
                //         imageAsset: 'pid_ads.png'),
                    
                //   ],
                // ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}

Widget buttonImage({imageAsset, onTap}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      decoration: BoxDecoration(image: 
        DecorationImage(image: AssetImage('assets/$imageAsset'))
      ),
      width: 400,
      height: 212.5,
    ),
  );
}
