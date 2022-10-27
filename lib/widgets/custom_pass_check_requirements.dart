import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPassCheckRequirements extends StatelessWidget {
  /// a `bool` value as check [required] field in case you want to `modify` the package
  final bool? passCheck;

  /// requirement text [required] field in case you want to `modify` the package
  final String? requirementText;

  /// IconData when requirement is completed
  final IconData? activeIcon;

  /// IconData when requirement is not completed/inActive
  final IconData? inActiveIcon;

  /// inActive color
  final Color? inActiveColor;

  /// Active color
  final Color? activeColor;
  final double passwordStrength;
  CustomPassCheckRequirements({
    Key? key,
    required this.passwordStrength,
    @required this.passCheck,

    /// [required parameters] in case you want to modify the package
    @required this.requirementText,

    /// [required parameters] in case you want to modify the package

    /// [default] value of in-active IconData
    this.inActiveIcon = Icons.check_circle_outline_rounded,

    /// [default] value of active IconData
    this.activeIcon = Icons.check_circle_rounded,

    /// [default] color of in-active field
    this.inActiveColor = Colors.grey,

    /// [default] color of active field
    this.activeColor = Colors.blue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          /// requirement IconData based on check!
          requirementText == "Not enough strong" ?
          (
          passwordStrength < 3/5 ?
          const Icon(CupertinoIcons.xmark, size:13,color: Colors.red):
          passwordStrength == 3/5  ||  passwordStrength == 4/5?
          const Icon(Icons.warning, color: Colors.orange,size:14):
          const Icon(Icons.done, color: Colors.green,size:14))
          :passCheck!
              ? const Icon(Icons.done, color: Colors.green,size:14):
                const Icon(CupertinoIcons.xmark, size:13,color: Colors.red),
          const SizedBox(width: 5.0),
          /// requirement text
          Flexible(
            child: Text(
              requirementText!,
              softWrap: true,
              style: TextStyle(
                color: passCheck! ? activeColor : inActiveColor,
              ).copyWith(fontWeight: requirementText == "Not enough strong" ? FontWeight.bold:
                         FontWeight.normal,
              fontSize: requirementText == "Not enough strong" ? 13 : 11 ),
            ),
          )
        ],
      ),
    );
  }
}
