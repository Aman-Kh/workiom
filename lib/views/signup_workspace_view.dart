import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

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
                      child: Text("Enter your company name",
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
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         const  Text("Your company or team name",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _workSpaceController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Workspace name*     .workiom.com",
                              border: UnderlineInputBorder(),
                              //fillColor: lightPrimaryColor,
                              //filled: false,
                              prefixIcon: const Icon(Icons.groups),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(2.0)),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Your first name",
                            style:  TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
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
                              fillColor: lightPrimaryColor,
                              filled: true,
                              prefixIcon: const Icon(Icons.format_align_left),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          TextField(
                            controller: _lastNameController,
                            style: (blackSmallBoldTextStyle),
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            cursorColor: blackColor,
                            decoration: InputDecoration(
                              hintText: "Enter your last name",
                              border: UnderlineInputBorder(),
                              fillColor: lightPrimaryColor,
                              filled: true,
                              prefixIcon: const Icon(Icons.format_align_left),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            var editionId = await context.read<WorkSpaceProvider>().getEditionIds();
                            print("EDITION ID");
                            print(editionId);
                            var passwordSetttings = await context.read<WorkSpaceProvider>().getPasswordComplexitySetting();
                            print("PASSWORD SETTTINGS");
                            print(passwordSetttings);
                            if(_workSpaceController.text != null && _workSpaceController.text.isNotEmpty) {
                              var tenantSettings = await context.read<WorkSpaceProvider>()
                                  .checkIfTenantIsAvailable(
                                  _workSpaceController.text);
                              print(tenantSettings?.tenantId.toString());
                            }
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInView()));
                            */
                            //Navigator.pushNamed(context, RouteNames.signInView);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                               Text("Create Workspace"), // <-- Text
                               SizedBox(
                                width: 5,
                              ),
                                Icon( // <-- Icon
                                Icons.keyboard_return_outlined,
                                size: 24.0,
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
      ),
    );
  }
}

