import 'package:flutter/material.dart';
import 'package:flutter_projects/constants/constants.dart';
import 'package:flutter_projects/models/password_settings.dart';
import 'package:flutter_projects/widgets/custom_pass_check_requirements.dart';

class CustomPasswordValidatedFields extends StatefulWidget {
  /// Password `validation` is given at the bottom which can be `modified` accordingly.
  /// Full package can be modified easily

  /// Input decoration of Text field by default it is OutlineInputBorder
  final InputDecoration? inputDecoration;

  /// textEditingController for the field
  final TextEditingController? textEditingController;

  /// textInputAction for the field. By default its set to [done]
  final TextInputAction? textInputAction;

  /// onEditComplete callBack for the field
  final void Function()? onEditComplete;

  /// onFieldSubmitted callBack for the field
  final String Function(String)? onFieldSubmitted;

  /// focusNode for the field
  final FocusNode? focusNode;

  /// cursorColor
  final Color? cursorColor;

  /// textStyle of the Text in field
  final TextStyle? textStyle;

  /// Password requirements attributes
  /// iconData for the icons when requirement is completed
  final IconData? activeIcon;

  /// iconData for the icons when the requirement is incomplete/inActive
  final IconData? inActiveIcon;

  /// color of the text when requirement is completed
  final Color? activeRequirementColor;

  /// color of the text when the requirement is not completed/inActive
  final Color? inActiveRequirementColor;
  final PasswordSettings passwordSettings;// = PasswordSettings.defaultSettings();

  /// Constructor
  CustomPasswordValidatedFields({
    Key? key,
    required this.passwordSettings,
    /// [default inputDecoration]
    this.inputDecoration = const InputDecoration(
        hintText: "Enter password",
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder()),
    this.textEditingController,

    /// [default textInputAction]
    this.textInputAction = TextInputAction.done,
    this.onEditComplete,
    this.onFieldSubmitted,
    this.focusNode,
    this.cursorColor,
    this.textStyle,

    /// Password requirements initialization
    /// [default inActiveIcon]
    this.inActiveIcon = Icons.check_circle_outline_rounded,

    /// [default activeIcon]
    this.activeIcon = Icons.check_circle_rounded,

    /// [default inActive Color]
    this.inActiveRequirementColor = Colors.black,

    /// [default active color]
    this.activeRequirementColor = Colors.black
  }) : super(key: key);

  @override
  _CustomPasswordValidatedFieldsState createState() =>
      _CustomPasswordValidatedFieldsState();
}

class _CustomPasswordValidatedFieldsState extends State<CustomPasswordValidatedFields> {
  String _pass = "";
  double passwordStrength = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(3, 8, 3, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// [Password TextFormField]
          /// Use `Form` to validate the field easily
          TextFormField(
            //key: _formKey,
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: widget.inputDecoration,
            onEditingComplete: widget.onEditComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            focusNode: widget.focusNode,
            cursorColor: widget.cursorColor,
            style: widget.textStyle,
            validator:passwordValidation,
            onChanged: (value) {
              setState(() {
                _pass = value;
                passwordValidation(value);
              });
            },
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: (widget.passwordSettings != null &&
                      widget.passwordSettings.requireDigit! ||
                      widget.passwordSettings.requireUppercase! ||
                      widget.passwordSettings.requireLowercase! ||
                      widget.passwordSettings.requireDigit! ||
                      widget.passwordSettings.requiredLength! > 0),
            child: LinearProgressIndicator(
                value: passwordStrength,
                backgroundColor: Colors.grey[300],
                minHeight: 5,
                color: passwordStrength<= 2 / 5
                    ? Colors.red
                    : passwordStrength == 3 / 5
                    ? Colors.orange
                    : passwordStrength == 4 / 5
                    ? Colors.orange : Colors.green,
              ),
          ),
          Visibility(
            visible: (widget.passwordSettings != null &&
                      widget.passwordSettings.requireDigit! ||
                      widget.passwordSettings.requireUppercase! ||
                      widget.passwordSettings.requireLowercase! ||
                      widget.passwordSettings.requireDigit! ||
                      widget.passwordSettings.requiredLength! > 0),
            child: CustomPassCheckRequirements(
              passwordStrength: passwordStrength ,
              passCheck:  true,
              requirementText: "Not enough strong",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),
          /// [default requirements]
          /// `1 Upper case` requirement
          Visibility(
            visible: (widget.passwordSettings != null &&
                      widget.passwordSettings.requireUppercase! ),
            child: CustomPassCheckRequirements(
              passwordStrength: 0.0 ,
              passCheck:  RegExp(r'[A-Z]').hasMatch(_pass),
              requirementText: "Password must have at least one uppercase [A-Z]",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),

          /// `1 lowercase` requirement
          Visibility(
           visible: (widget.passwordSettings != null &&
                     widget.passwordSettings.requireLowercase!),
            child: CustomPassCheckRequirements(
              passwordStrength: 0.0 ,
              passCheck: RegExp(r'[a-z]').hasMatch(_pass),
              requirementText: "Password must have at least one lowercase [a-z]",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),

          /// `1 numeric value` requirement
          Visibility(
            visible: (widget.passwordSettings != null &&
                      widget.passwordSettings!.requireDigit!),
            child: CustomPassCheckRequirements(
              passwordStrength: 0.0 ,
              passCheck: widget.passwordSettings != null &&
                         widget.passwordSettings!.requireDigit! &&
                         RegExp(r'[0-9]').hasMatch(_pass),
              requirementText: "Password must have at least one digit [0-9]",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),

          /// `1 special character` requirement
          Visibility(
            visible: (widget.passwordSettings != null &&
                      widget.passwordSettings!.requireNonAlphanumeric!),
            child: CustomPassCheckRequirements(
              passwordStrength: 0.0 ,
              passCheck:RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_pass),
              requirementText: "Password must have at least one special",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),

          /// `6 character length` requirement
          Visibility(
            visible: (widget.passwordSettings != null &&
                widget.passwordSettings!.requiredLength! > 0),
            child: CustomPassCheckRequirements(
              passwordStrength: 0.0 ,
              passCheck: _pass.length >= widget.passwordSettings!.requiredLength!,
              requirementText: "Password must have ${widget.passwordSettings!.requiredLength!} characters minimum",
              activeColor: widget.activeRequirementColor,
              inActiveColor: widget.inActiveRequirementColor,
              inActiveIcon: widget.inActiveIcon,
              activeIcon: widget.activeIcon,
            ),
          ),
        ],
      ),
    );
  }

  /// [password validation]
  /// 1 Uppercase
  /// 1 lowercase
  /// 1 numeric value
  /// 1 special character
  /// 6 length password

  /// In case you want to `modify` the requirements change the `RegExp` given below
  String? passwordValidation(String? value) {
    print("passwordValidation");
    bool passValid = true;
    var settings = widget.passwordSettings;
    if (value!.isEmpty) {
      setState(() {
        passwordStrength = 0.0;
      });
      return "Password cannot be emtpy!";
    }
    if(settings != null) {
      var isRequireDigits = settings.requireDigit!;
      var isRequireLowercase = settings.requireLowercase!;
      var isRequireUppercase = settings.requireUppercase!;
      var isRequireNonAlphanumeric = settings.requireNonAlphanumeric!;
      var requireLength = settings.requiredLength;
      
      bool passValid = (((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits) &&
          ((isRequireLowercase && lowerCaseRegex.hasMatch(value)) || !isRequireLowercase) &&
          ((isRequireNonAlphanumeric && nonAlphanumericRegex.hasMatch(value)) || !isRequireNonAlphanumeric) &&
          ((isRequireUppercase && upperCaseRegex.hasMatch(value)) || !isRequireUppercase) &&
          requireLength! <= value.length);
      setState(() {
        passwordStrength = ((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits)?
             1/5 :
               ((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits) && ((isRequireLowercase && lowerCaseRegex.hasMatch(value)) || !isRequireLowercase) ? 2/5
             : ((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits) && ((isRequireLowercase && lowerCaseRegex.hasMatch(value)) || !isRequireLowercase) && ((isRequireNonAlphanumeric && nonAlphanumericRegex.hasMatch(value)) || !isRequireNonAlphanumeric) ? 3/5
             : ((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits) && ((isRequireLowercase && lowerCaseRegex.hasMatch(value)) || !isRequireLowercase) && ((isRequireNonAlphanumeric && nonAlphanumericRegex.hasMatch(value)) || !isRequireNonAlphanumeric)  &&  ((isRequireUppercase && upperCaseRegex.hasMatch(value)) || !isRequireUppercase)? 4/5:
               ((isRequireDigits && digitsRegex.hasMatch(value)) || !isRequireDigits) && ((isRequireLowercase && lowerCaseRegex.hasMatch(value)) || !isRequireLowercase) && ((isRequireNonAlphanumeric && nonAlphanumericRegex.hasMatch(value)) || !isRequireNonAlphanumeric)  &&  ((isRequireUppercase && upperCaseRegex.hasMatch(value)) || !isRequireUppercase) && (requireLength! <= value.length)? 5/5:
               4/5;
      });
print(passwordStrength);
print(passValid);
      if(passValid){            // regular expression to check password valid or not
        setState(() {
          passwordStrength = 5 / 5;
        });
      }
      if (!passValid) {
        return "Requirement(s) missing!";
      }
    }
    return null;
  }

}
