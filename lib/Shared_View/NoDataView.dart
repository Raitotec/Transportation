

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sizer/sizer.dart';
import 'package:transportation/Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Constants/assets/Images_Name.dart';
import 'AnimatedButton.dart';
class NoDataView extends StatefulWidget {
  final AsyncCallback onTapped;

  NoDataView({Key? key,required this.onTapped});
  @override
  _NoDatatate createState() => _NoDatatate();
}

class _NoDatatate extends State<NoDataView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagesName.noData, height: 15.0.h,),
            SizedBox(height: 1.0.h,),
            Text(Translations.of(context)!.NoData,
                style: TextStyle(color: Style.MainTextColor,
                    fontSize: 17.0.sp,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 1.0.h,),
            AnimatedButton(text: Translations.of(context)!.ErrorDes,
              onTapped: widget.onTapped,),
          ],))
      ],
    );
  }
}