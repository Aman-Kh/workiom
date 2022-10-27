import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/constants/route_generator.dart';
import 'package:flutter_projects/providers/base_provider.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:flutter_projects/widgets/custom_password_validated_fields.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: veryDarkBlueColor),
              onPressed: () => Navigator.pop(context)),
          elevation: 0,
          backgroundColor: whiteColor,
        ),
        backgroundColor: whiteColor,
        body: LoadingOverlay(
          color: Colors.black,
          opacity: 0.1,
          isLoading: false,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 20, 8),
                    child: Text(
                      "Enter a strong password",
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
                          '👋🏻',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 8, 3, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Your work mail",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (!emailRegex.hasMatch(value!)) {
                              return "invalid Email";
                            }
                          },
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //context.read<WorkSpaceProvider>().changePassViewSignIn();
                                  _emailController.clear();
                                  context
                                      .read<BaseProvider>()
                                      .setErrorText("");
                                },
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  size: 20,
                                )),
                            hintText: "email",
                            border: const UnderlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 20,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: greyColor, width: 1.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(2.0)),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 8, 3, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Your password",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomPasswordValidatedFields(
                          textEditingController: _passwordController,
                          passwordSettings: context
                              .watch<WorkSpaceProvider>()
                              .passwordSettings,
                          inActiveIcon: Icons.cancel,
                          activeIcon: Icons.done,
                          inputDecoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<WorkSpaceProvider>()
                                      .changePassViewSignIn();
                                },
                                icon: Icon(
                                    size: 20,
                                    Provider.of<WorkSpaceProvider>(context,
                                                listen: false)
                                            .showPassSignIn
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                            hintText: "Enter password",
                            border: const UnderlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 20,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: greyColor, width: 1.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(2.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade400),
                          foregroundColor:
                              MaterialStateProperty.all(blackColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          context.read<BaseProvider>().setBusy(true);
                          SharedPreferences pref =  await SharedPreferences.getInstance();
                          pref.setString(userEmail, _emailController.text);
                          pref.setString(userPassword, _passwordController.text);

                          print(pref.getString(userEmail));
                          print(pref.getString(userPassword));
                          context.read<BaseProvider>().setBusy(false);
                          Navigator.pushNamed(
                              context, RouteNames.signUpWorkSpaceView);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Confirm password",
                              style: primaryButtonBoldTextStyle,
                            ), // <-- Text
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                                // <-- Icon
                                Icons.keyboard_return_outlined,
                                size: 24.0,
                                color: whiteColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Stay Organized with",
                style: TextStyle(
                    color: Colors.grey[600], fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
