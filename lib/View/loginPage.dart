
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../Constants/Routes/route_constants.dart';
import '../Constants/assets/Images_Name.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sizer/sizer.dart';
import '../Constants/Localization/ScopeModelWrapper.dart';
import '../Constants/Localization/Translations.dart';
import '../Constants/Style.dart';
import '../Shared_Data/CompanyData.dart';
import '../Shared_View/AnimatedActionColorButton.dart';
import '../Shared_View/BackgroundView.dart';
import '../Shared_View/GlobalTextField.dart';
import '../Shared_View/ProgressIndicatorButton.dart';
import '../Shared_View/TextFieldView.dart';
import '../ViewModel/LoginViewModel.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
    child: Scaffold(
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
    ));
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
                      (CompanyData.companyData!=null && CompanyData.companyData!.logo!=null)?
                      Image.network(
                        CompanyData.companyData!.logo!,
                        width: double.infinity,
                        height: 15.0.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return   Center(child:  Image.asset(ImagesName.login, height: 15.0.h,));
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ):Center(child:  Image.asset(ImagesName.login, height: 15.0.h,)),
                      SizedBox(height: 10.0.h,),
                      Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return  Padding(
                                padding: EdgeInsets.symmetric( horizontal: 6.0.w, vertical: 1.0.h),
                                child: GlobalTextField(
                                  controller: viewModel.emailController,
                                  label: Translations.of(context)!.Email,
                                  onChanged: (text) {},
                                ));

                          }),
                      Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return  Padding(
                                padding: EdgeInsets.symmetric( horizontal: 6.0.w, vertical: 1.0.h),
                                child: GlobalTextField(
                                  password: true,
                                  controller: viewModel.passwordController,
                                  label: Translations.of(context)!.Password,
                                  onChanged: (text) {},
                                ));

                          }),
                      SizedBox(height: 2.0.h,),
                      Consumer<LoginViewModel>(
                          builder: (context, viewModel, child) {
                            return AnimatedActionColorButton(
                                text: Translations.of(context)!.Login_btn,
                                onTapped: viewModel.Login);
                          }),
                    ])
            )
        ));
  }
}

