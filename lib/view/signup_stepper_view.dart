import 'package:flutter/material.dart';
import 'package:flutter_banking/common/dimens.dart';
import 'package:flutter_banking/view/signup_address_view.dart';
import 'package:flutter_banking/view/signup_contact_view.dart';
import 'package:flutter_banking/view/signup_law_view.dart';
import 'package:flutter_banking/view/signup_name_view.dart';
import 'package:flutter_banking/view/signup_tax_view.dart';
import 'package:flutter_banking/view/transparent_app_bar.dart';

class Step {
  final Widget view;
  final String title;

  const Step(this.view, this.title);
}

class SignUpStepperView extends StatefulWidget {
  @override
  _SignUpStepperViewState createState() => _SignUpStepperViewState();
}

class _SignUpStepperViewState extends State<SignUpStepperView>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<Step> steps = [
      Step(
          SignUpNameView(
            nextPage: () => _nextPage(),
          ),
          "What's your name?"),
      Step(
          SignUpAddressView(
            nextPage: () => _nextPage(),
          ),
          "And your address?"),
      Step(
          SignUpContactView(
            nextPage: () => _nextPage(),
          ),
          "Verify contact data"),
          Step(
          SignUpLawView(
            nextPage: () => _nextPage(),
          ),
          "Legal information"),
      Step(
          SignUpTaxView(
            nextPage: () => _nextPage(),
          ),
          "Tax information"),
    ];

    final Step step = steps[_index];

    return WillPopScope(
      onWillPop: () => Future.sync(_onWillPop),
      child: Scaffold(
        appBar: _buildAppBar(theme, step.title, steps.length),
        body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: NeverScrollableScrollPhysics(),
            children: steps.map((s) => s.view).toList()),
        backgroundColor: Colors.white,
        floatingActionButton: _buildFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  bool _onWillPop() {
    if (_index > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);

      return false;
    }

    return true;
  }

  void _onPageChanged(int page) {
    setState(() {
      _index = page;
    });
  }

  Future<void> _previousPage() {
    return _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  Future<void> _nextPage() {
    print('nextPage');
    return _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  PreferredSizeWidget _buildAppBar(
      final ThemeData theme, String title, int itemCount) {
    double progress = _index == 0 ? 0.1 : (_index / itemCount) + 0.1;

    return TransparentAppBar(
      hasElevation: true,
      title: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.progressBarBorderRadius),
            child: Container(
                height: Dimens.progressBarHeight,
                child: LinearProgressIndicator(value: progress)),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => Navigator.of(context).pop()),
      ],
      bottom: PreferredSize(
        child: Container(
          height: Dimens.progressAppBarHeight,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal),
          child: Align(
            alignment: Alignment.topLeft,
            child: _buildTitle(title, theme),
          ),
        ),
        preferredSize: const Size.fromHeight(Dimens.progressAppBarHeight),
      ),
    );
  }

  Text _buildTitle(final String text, final ThemeData theme) {
    final TextStyle titleStyle = theme.textTheme.headline3;
    return Text(text, style: titleStyle);
  }

  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () => _nextPage(),
      child: Icon(Icons.arrow_forward),
    );
  }
}