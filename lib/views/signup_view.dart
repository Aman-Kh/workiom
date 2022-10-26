import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/providers/workspace_provider.dart';
import 'package:flutter_projects/widgets/custom_password_validated_fields.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //final GlobalKey<FormState> _form = GlobalKey<FormState>();
//
  // regular expression to check if string
  /*RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  //A function that validate user entered password
   validatePassword(String pass) {
    /*SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isRequireDigit =  pref.getBool(requireDigit);
    bool? isRequireNonAlphanumeric = pref.getBool(requireNonAlphanumeric);
    bool? isRequireLowercase =pref.getBool(requireLowercase);
    bool? isRequireUppercase =pref.getBool(requireUppercase);
    int?  requiredLength = pref.getInt(requiredLength);
    */
    print("validatePassword");
    String _password = pass.trim();
    var settings = context.read<WorkSpaceProvider>().passwordSettings;
    print(settings);
    if(_password.isEmpty){
      setState(() {
        password_strength = 0;
      });
    }
    if(settings != null)
    {
      print(settings.requireDigit);
      if (_password.length >= settings.requiredLength!)
      {
        setState(() {
          password_strength = 1 / 5;
        });
      }
      if ((settings.requireDigit! && _password.contains(containsDigits))
      ||  !settings.requireDigit!)
      {
        setState(() {
          password_strength = 2 / 5;
        });
      }
        if ( (settings.requireUppercase! && _password.contains(containsUppercase))
         || !settings.requireUppercase!)
        {
          setState(() {
            password_strength = 3 / 5;
          });
        }
      if ( (settings.requireLowercase! && _password.contains(containsLowercase))
      || settings.requireLowercase!)
        {
          setState(() {
            password_strength = 4 / 5;
          });
        }
      if ((settings.requireNonAlphanumeric! &&
          (_password.contains(containsLowercase)
        || _password.contains(containsUppercase)
        || _password.contains(containsDigits))
      )|| !settings.requireNonAlphanumeric!)
      {
        setState(() {
          password_strength = 5 / 5;
        });
      }

    }
  }
*/
  //
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
            return false;
          },
          child: LoadingOverlay(
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
                            '\u270B ',
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15,8,3,8),
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
                            controller: _emailController,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                              validator: (value) {
                                if (!emailRegex.hasMatch(value!)) {
                                  return "invalid Email";
                                } else {
                                  return "";
                                }
                              },
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "email",
                              border: const UnderlineInputBorder(),
                              prefixIcon: const Icon(Icons.email),
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
                      padding: const EdgeInsets.fromLTRB(15,8,3,8),
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
                            key: _form,
                            passwordSettings: context.watch<WorkSpaceProvider>().passwordSettings,
                            inActiveIcon: Icons.cancel,
                            activeIcon: Icons.done,
                            inputDecoration: InputDecoration(
                              hintText: "Enter password",
                              border: const UnderlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: primaryColor, width: 1.0),
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
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Confirm password"), // <-- Text
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
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 20,
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
