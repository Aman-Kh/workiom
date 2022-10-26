import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/constants/route_generator.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkBlueColor,
      ),
      backgroundColor: whiteColor,
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: LoadingOverlay(
          color: Colors.black,
          opacity: 0.1,
          isLoading: false,
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Text("Create your free account",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          "Let's start an amazing journey!",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        const Text(
                          '\u270B ',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, RouteNames.signUpView);
                          },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                 Image(
                                   image: AssetImage("assets/google_icon.png"),
                                   width: 15,
                                   height: 15,
                                 ),
                                 Text("Continue with Google")
                                ],
                              ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(child: Text("Or")),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async{
                              await context.read<WorkSpaceProvider>().getPasswordComplexitySetting();
                              Navigator.pushNamed(context, RouteNames.signUpView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: const [
                                Text("Continue with email"), // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  // <-- Icon
                                  Icons.keyboard_return_outlined,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: RichText(
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "By signing up, you agree ",
                              style: blackSmallTextStyle.copyWith(
                                fontSize: 13,
                                overflow: TextOverflow.clip,
                              ),
                              children: [
                                TextSpan(
                                  text: "Terms Of Service",
                                  style: blackSmallTextStyle.copyWith(
                                      fontSize: 13,
                                      decoration:
                                      TextDecoration.underline),
                                ),
                                TextSpan(
                                  text: " And ",
                                  style: blackSmallTextStyle,
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: blackSmallTextStyle.copyWith(
                                      fontSize: 13,
                                      decoration:
                                      TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8,0,8,20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Stay Organized with",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 5),
            Image.asset(
              'assets/logo.png',
              height: 80,
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}

