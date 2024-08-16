import 'package:flutter/material.dart';
import 'package:pid_controller/model/pidmodel.dart';
import 'package:pid_controller/service_api.dart';
import 'package:pid_controller/switch/view/switch_view.dart';
import 'package:pid_controller/widget/custom_snackbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service_api = ServiceAPIs();
  late PidModel model_pid =
      PidModel(rl1: '0', rl2: '0', bc3: '0', bc4: '0', ads: '0');
  @override
  void initState() {
    //INIT SOCKET
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
                    image: AssetImage('assets/bg2.jpeg'),
                    fit: BoxFit.cover)),
            child: ListView(
              shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .3,
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
                          service_api
                              .loadPresetByID(int.parse(model_pid.rl1))
                              .then((value) {
                            customSnackBar(context: context, message: '$value');
                          });
                        },
                        imageAsset: 'img_landscape.png'),
                    // const SizedBox(
                    //   width: 35,
                    // ),
                    buttonImage(
                        onTap: () {
                          debugPrint('tap2');
                          service_api
                              .loadPresetByID(int.parse(model_pid.rl2))
                              .then((value) {
                            customSnackBar(context: context, message: '$value');
                          });
                        },
                        imageAsset: 'img_forest.png')
                  ],
                ),
                SizedBox(height: 16.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonImage(
                        onTap: () {
                          debugPrint('tap3');
                          service_api
                              .loadPresetByID(int.parse(model_pid.bc3))
                              .then((value) {
                            customSnackBar(context: context, message: '$value');
                          });
                        },
                        imageAsset: 'img_under.png'),
                    // const SizedBox(
                    //   width: 35,
                    // ),
                    buttonImage(
                        onTap: () {
                          debugPrint('tap4');
                          service_api
                              .loadPresetByID(int.parse(model_pid.bc4))
                              .then((value) {
                            customSnackBar(context: context, message: '$value');
                          });
                        },
                        imageAsset: 'img_van.png')
                  ],
                ),
                
              ],
            ),
          ),
          // Positioned(
          //   top:16.0,
          //   right:16.0,
          //   child: Text('BACK UP VER',style:TextStyle(color:Colors.grey,fontSize:36.0,fontWeight:  FontWeight.bold)),
          // ),
          // //Switch Button
          // Positioned(
          //   bottom: 16.0,
          //   right: 16.0,
          //   child:  SwitchButton(),
          // ),
          // //button ads screen
          // Positioned(
          //     bottom: 16.0,
          //     left: 16.0,
          //     child: TextButton.icon(
          //         icon: const Icon(Icons.ads_click, color: Colors.green),
          //         onPressed: () {
          //           // service_api
          //           //     .loadPresetByID(int.parse(model_pid.ads))
          //           //     .then((value) {
          //           //   customSnackBar(context: context, message: '$value');
          //           // });
          //         },
          //         label: const Text('ADS DISPLAY', style: TextStyle(color: Colors.white)))),
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
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/$imageAsset'))),
      width: 385,
      height: 200,
    ),
  );
}
