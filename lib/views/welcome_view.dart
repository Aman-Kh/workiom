import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/constants/route_generator.dart';
import 'package:flutter_projects/providers/base_provider.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';


class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: veryDarkBlueColor),
              onPressed: () {}
            ),
            Text("Sign in",style: TextStyle(fontSize: 18,color: veryDarkBlueColor),)
          ],
        ),
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      backgroundColor: whiteColor,
      body: LoadingOverlay(
        color: Colors.black,
        opacity: 0.1,
        isLoading: context.watch<BaseProvider>().isBusy,
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
                        '👋🏻',style: TextStyle(fontSize: 18),
                      ),
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
                        height: 50,
                        child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(veryLightGreyColor),
                          foregroundColor: MaterialStateProperty.all(blackColor),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                        ),
                        onPressed: () {},

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children:  [
                               Image(
                                 alignment: Alignment.center,
                                 image: AssetImage("assets/google_icon.png"),
                                 width: 13,
                                 height: 13,
                               ),
                               SizedBox(width: 5,),
                               Text("Continue with Google",style: primaryButtonBoldTextStyle.copyWith(color: blackColor),)
                              ],
                            ),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Center(child: Text("Or",style: blackSmallTextStyle.copyWith( fontSize: 11,color: Colors.grey.shade600),)),
                      const SizedBox(
                        height: 28,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(veryDarkBlueColor),
                            foregroundColor: MaterialStateProperty.all(whiteColor),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                          ),
                          onPressed: () async{
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            context.read<BaseProvider>().setBusy(true);
                            //var editionId =
                            await context.read<WorkSpaceProvider>().getEditionIds();
                            print("EDITION ID");
                            await context.read<WorkSpaceProvider>().getPasswordComplexitySetting();
                            var access_token = pref.getString(accessToken);
                            print(access_token);
                            if(access_token == null || access_token.isEmpty) {
                              context.read<BaseProvider>().setBusy(false);
                              Navigator.pushNamed(context, RouteNames.signUpView);
                            }
                            else
                            {
                              context.read<BaseProvider>().setBusy(false);
                              var isLoggedIn = await context.read<WorkSpaceProvider>().getCurrentLoginInformations();
                              if(isLoggedIn)
                              {
                                var _userName = pref.getString(userName);
                                var _tenantName = pref.getString(tenantName);
                                if( _userName != null && _userName!.isNotEmpty &&
                                  _tenantName != null &&_tenantName!.isNotEmpty)
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'User ${_userName} is Logged in with Tenant ${_tenantName}'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ));
                                }
                                else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'User is Logged in'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ));
                                }
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Text("Continue with email",style: primaryButtonBoldTextStyle,), // <-- Text
                              SizedBox(
                                width: 8,
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
                  height: 3,
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
                              fontSize: 12,
                              overflow: TextOverflow.clip,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms Of Service",
                                style: blackSmallTextStyle.copyWith(
                                    fontSize: 12,
                                    decoration:
                                    TextDecoration.underline),
                              ),
                              TextSpan(
                                text: " And ",
                                style: blackSmallTextStyle.copyWith(
                                    fontSize: 12,),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: blackSmallTextStyle.copyWith(
                                    fontSize: 12,
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

