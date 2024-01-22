import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

Widget customHomeButton(BuildContext context, String text, void Function()? onPressed) {
  return SizedBox(
    height: 65,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        backgroundColor: CustomColors.jewel,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              text, 
              style: TextStyle(
                color: CustomColors.mystic
              )
            )
          ),
          Icon(
            Icons.arrow_right_rounded,
            color: CustomColors.mystic,
          )
        ]
      ),
      onPressed: onPressed,
    )
  );
}

Widget backgroundImage(left, top, right, bottom, height, width, turns) {
  return Positioned(top: top, right: right, bottom: bottom, left: left,
    child: RotationTransition(
      turns: AlwaysStoppedAnimation(turns),
      child: SizedBox(height: height, width: width,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/splash.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.06), BlendMode.dstATop),
              fit: BoxFit.scaleDown,
            )
          )
        )
      )
    )
  );
}

Widget textfield(label, hint, Text suffix, TextEditingController textController) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: TextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[DecimalTextInputFormatter()],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 12,right: 12,),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade200)
        ),
        labelText: label,
        hintText: hint,
        suffix: suffix,
      ),
      validator: (value) => value!.isEmpty ? 'Value Can\'t Be Empty' : null,
      controller: textController
    ),
  );
}

Widget textfieldThousandsSeparator(label, hint, Text suffix, TextEditingController textController) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: TextFormField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[ThousandsFormatter(allowFraction: true)],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 12, right: 12),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade200)
        ),
        labelText: label,
        hintText: hint,
        suffix: suffix,
      ),
      validator: (value) => value!.isEmpty ? 'Value Can\'t Be Empty' : null,
      controller: textController
    ),
  );
}

Widget textfieldDisable(label, hint, Text suffix) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: TextFormField(
      readOnly: true,
      showCursor: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 12, right: 12,),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400)
        ),
        labelText: label,
        hintText: hint,
        suffix: suffix
      ),
    )
  );
}

Widget line = Center(
  child: SizedBox(
    height: 10.0,
    child: Center(
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 3.0, end: 3.0), 
        height: 2.0, 
        color: Colors.lightGreen[700]
      )
    )
  )
);

Widget text(text) { 
  return  Text(
    text, 
    style: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 18
    )
  ); 
}

Widget labelInfo(text) { 
  return Text(
    text, 
    style: const TextStyle(
      color: Colors.lightGreen, 
      fontStyle: FontStyle.italic, 
      fontSize: 16
    )
  ); 
}

Widget titleText(text) { 
  return Text(
    text, 
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.grey
    )
  );
}
