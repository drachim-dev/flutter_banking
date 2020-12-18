import 'package:flutter/material.dart';
import 'package:flutter_banking/common/colors.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/common/utils.dart';
import 'package:flutter_banking/view/signup_address_view.dart';
import 'package:flutter_banking/view/signup_mail_view.dart';
import 'package:flutter_banking/view/signup_law_view.dart';
import 'package:flutter_banking/view/signup_legi_view.dart';
import 'package:flutter_banking/view/signup_name_view.dart';
import 'package:flutter_banking/view/signup_phone_number_confirm_view.dart';
import 'package:flutter_banking/view/signup_security_code.dart';
import 'package:flutter_banking/view/signup_tax_view.dart';
import 'package:flutter_banking/view/transparent_app_bar.dart';
import 'package:flutter_banking/widgets/action_button.dart';

class Step {
  final Widget child;
  final bool showAppBar;

  const Step({@required this.child, this.showAppBar = true});
}

class SignUpStepperView extends StatefulWidget {
  @override
  _SignUpStepperViewState createState() => _SignUpStepperViewState();
}

class _SignUpStepperViewState extends State<SignUpStepperView>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  List<Step> _steps;
  int _index = 0;
  bool _hasStep = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _steps = [
      Step(
        child: SignUpSecurityCode(
          title: "Assign a security code",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpPhoneNumberConfirmView(
          title: "Please enter the 6-digit code",
          subtitle: "We've sent it to +49 173 1234567",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpNameView(
          title: "Who are you?",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpAddressView(
          title: "Enter your address?",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpMailView(
          title: "Your mail address",
          description: "We use it only to inform you about important changes.",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpTaxView(
          title: "Tax information",
          description:
              "In which country are you taxable? You may be subject to taxes in several countries. Please specify them all.",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpLawView(
          title: "Legal information",
          nextPage: () => _nextPage(),
        ),
      ),
      Step(
        child: SignUpLegitimationView(title: "Video ident"),
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Step step = _steps[_index];
    _hasStep = _index + 1 < _steps.length;

    return WillPopScope(
      onWillPop: () => Future.sync(_onWillPop),
      child: Scaffold(
        appBar:
            step.showAppBar ? _buildAppBar(theme, step, _steps.length) : null,
        body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: NeverScrollableScrollPhysics(),
            children: _steps.map((s) => s.child).toList()),
        floatingActionButton: _hasStep
            ? ButtomActionButtonBar(
                primary: PrimaryActionButton(
                  label: "Continue",
                  onPressed: () => _nextPage(),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  bool _onWillPop() {
    if (_index > 0) {
      _previousPage();
      return false;
    }

    return true;
  }

  void _onPageChanged(int page) {
    setState(() => _index = page);
  }

  Future<void> _previousPage() {
    return _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> _nextPage() {
    Utils.unfocus();
    return _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  PreferredSizeWidget _buildAppBar(
      final ThemeData theme, Step step, int itemCount) {
    final double progress = _index == 0 ? 0.1 : (_index / itemCount) + 0.1;

    return TransparentAppBar(
      theme: theme,
      hasElevation: false,
      title: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(Dimens.progressBarBorderRadius),
              child: Container(
                  height: Dimens.progressBarHeight,
                  child: LinearProgressIndicator(
                      backgroundColor: MyColor.transparentPrimary,
                      valueColor: AlwaysStoppedAnimation(MyColor.primary),
                      value: progress)),
            ),
          ),
          SizedBox(
            width: 52,
          ),
        ],
      ),
    );
  }
}
