/*
ادخل id الشركه
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../Constants/Localization/LanguageSelector.dart';
import '../Constants/Routes/route_constants.dart';
import '../Constants/assets/Images_Name.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';

import '../Constants/Localization/ScopeModelWrapper.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_View/AnimatedActionColorButton.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/GlobalTextField.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/TextFieldView.dart';
import '../ViewModel/LoginViewModel.dart';


class startPage extends StatefulWidget {
  startPage({Key? key}) : super(key: key);

  @override
  _startPageState createState() => _startPageState();
}

class _startPageState extends State<startPage> {



  void initState() {
    super.initState();
    Provider.of<LoginViewModel>(context, listen: false).checkVersion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return LoadingOverlay(
                  child: SafeArea(child: mainBody(context),
                  ),
                  isLoading: viewModel.isLoading,
                  opacity: 0.2,
                  color: Style.MainColor,
                  progressIndicator: IconedButtonLoading());
            })
    );
  }

  Widget mainBody(BuildContext context )
  {
    return BackgroundView(dataWidget: FormUI(),);
  }

  Widget FormUI() {
    return SingleChildScrollView(
        child: AnimationLimiter(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 800),
                    childAnimationBuilder: (widget) =>
                        SlideAnimation(
                          horizontalOffset: MediaQuery
                              .of(context)
                              .size
                              .width / 2,
                          child: FadeInAnimation(child: widget),
                        ),
                    children: [
                      SizedBox(height: 15.0.h,),
                      Center(child: Image.asset(
                        ImagesName.logo, height: 15.0.h,),),
                      SizedBox(height: 10.0.h,),
                      Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return
                              Padding(
                                  padding: EdgeInsets.symmetric( horizontal: 6.0.w, vertical: 1.0.h),
                                  child: GlobalTextField(
                                    controller: viewModel.companyController,
                                    label: Translations.of(context)!.CompanyNumber,
                                    onChanged: (text) {},
                                  ));
                          }),
                      SizedBox(height: 2.0.h,),
                      Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return AnimatedActionColorButton(
                                text: Translations.of(context)!.Login_btn,
                                onTapped: viewModel.startLogin);
                          }),

                      LanguageSelector(),
                    ])
            )
        ));
  }










}

