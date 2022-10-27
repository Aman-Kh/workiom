import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/constants/route_generator.dart';
import 'package:flutter_projects/providers/base_provider.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupWorkSpaceView extends StatelessWidget {
  SignupWorkSpaceView({Key? key}) : super(key: key);
  final TextEditingController _workSpaceController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final String usernameTakenMessage = 'Email already taken';
  final String emailTakenMessage = 'Email is already taken.';

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
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Text(
                      "Enter your company name",
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
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Your company or team name",
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
                            if (_workSpaceController.text.isEmpty) {
                              return "WorkSpace cannot be Empty!";
                            }
                          },
                          controller: _workSpaceController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Workspace name*     .workiom.com",
                            border: UnderlineInputBorder(),
                            prefixIcon: const Icon(Icons.groups),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.0),
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Your first name",
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
                            if (_firstNameController.text.isNotEmpty &&
                                (upperCaseRegex
                                    .hasMatch(_firstNameController.text) ||
                                lowerCaseRegex
                                    .hasMatch(_firstNameController.text))) {
                              return null;
                            } else {
                              return " Letters only";
                            }
                          },
                          controller: _firstNameController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Enter your first name",
                            prefixIcon: const Icon(Icons.format_align_left),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Your last name",
                          style: blackSmallBoldTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (_lastNameController.text.isNotEmpty &&
                                (upperCaseRegex
                                    .hasMatch(_lastNameController.text) ||
                                lowerCaseRegex
                                    .hasMatch(_lastNameController.text))) {
                              return null;
                            } else {
                              return " Letters only";
                            }
                          },
                          controller: _lastNameController,
                          style: (blackSmallBoldTextStyle),
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          cursorColor: blackColor,
                          decoration: InputDecoration(
                            hintText: "Enter your last name",
                            border: UnderlineInputBorder(),
                            prefixIcon: const Icon(Icons.format_align_left),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
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
                          if (!_form.currentState!.validate()) {
                            return;
                          }
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          if (_workSpaceController.text != null &&
                              _workSpaceController.text.isNotEmpty) {
                            var tenantSettings = await context
                                .read<WorkSpaceProvider>()
                                .checkIfTenantIsAvailable(
                                    _workSpaceController.text);
                            if (tenantSettings?.tenantId != null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Workspace is used, try with different Workspace!'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ));
                              //context.read<BaseProvider>().setErrorText("Workspace is used!");
                              return;
                            }
                            else if(tenantSettings?.tenantId == null) // Can Create User
                            {
                              pref.setString(tenantName, _workSpaceController.text);
                              var regsiterMode = await context.read<WorkSpaceProvider>().registerNewUser
                                (_firstNameController.text,
                                 _lastNameController.text,
                                 _workSpaceController.text);
                              if(regsiterMode != null )
                                {
                                  var accessToken = await context.read<WorkSpaceProvider>().getAccesstoken
                                    (_firstNameController.text,
                                      _lastNameController.text,
                                      _workSpaceController.text);
                                  /*print("accessToken");
                                  print(accessToken);*/
                                  if(accessToken != null && accessToken.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Successfully Registered!'),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 2),
                                        ));
                                    Navigator.pushNamed(
                                        context, RouteNames.homeView);
                                  }
                                }
                              //Navigator.pushNamed(context, routeName)
                            }
                            //print(tenantSettings?.tenantId.toString());
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Create Workspace",
                                style:
                                    primaryButtonBoldTextStyle), // <-- Text
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              // <-- Icon
                              Icons.keyboard_return_outlined,
                              size: 24.0,
                              color: whiteColor,
                            ),
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

  String? validateTenant(String? value) {}
}
