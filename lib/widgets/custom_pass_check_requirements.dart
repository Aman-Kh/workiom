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
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// requirement IconData based on check!
          requirementText == "Not enough strong" ?
          (
          passwordStrength < 3/5 ?
          const Icon(CupertinoIcons.xmark, size:18,color: Colors.red):
          passwordStrength == 3/5  ||  passwordStrength == 4/5?
          const Icon(Icons.warning, color: Colors.orange):
          const Icon(Icons.done, color: Colors.green))
          :passCheck!
              ? const Icon(Icons.done, color: Colors.green):
                const Icon(CupertinoIcons.xmark, size:18,color: Colors.red),
          const SizedBox(width: 2.0),
          /// requirement text
          Text(
            requirementText!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: passCheck! ? activeColor : inActiveColor,
            ).copyWith(fontWeight: requirementText == "Not enough strong" ? FontWeight.bold:
                       FontWeight.normal),
          )
        ],
      ),
    );
  }
}
