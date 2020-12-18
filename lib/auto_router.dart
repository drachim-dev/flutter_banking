import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_banking/view/account_view.dart';
import 'package:flutter_banking/view/add_account.dart';
import 'package:flutter_banking/view/add_transaction_overview.dart';
import 'package:flutter_banking/view/amount_selection_view.dart';
import 'package:flutter_banking/view/contact_selection_view.dart';
import 'package:flutter_banking/view/home_view.dart';
import 'package:flutter_banking/view/login_view.dart';
import 'package:flutter_banking/view/map_view.dart';
import 'package:flutter_banking/view/preferences_view.dart';
import 'package:flutter_banking/view/purpose_selection_view.dart';
import 'package:flutter_banking/view/signup_mobile.dart';
import 'package:flutter_banking/view/signup_stepper_view.dart';
import 'package:flutter_banking/view/spending_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SignUpMobile, initial: true),
    CustomRoute<bool>(
        page: SignUpStepperView,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SpendingView),
    MaterialRoute(page: AddAccountView),
    MaterialRoute(page: AtmMapView),
    CustomRoute<bool>(
        page: PreferencesView, transitionsBuilder: TransitionsBuilders.fadeIn),
    MaterialRoute(page: ContactSelectionView),
    CustomRoute<bool>(
        page: AmountSelectionView,
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute<bool>(
        page: AccountView, transitionsBuilder: TransitionsBuilders.fadeIn),
    MaterialRoute(page: AddTransactionOverview),
    CustomRoute<bool>(
        page: PurposeSelectionView,
        transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
)
class $AutoRouter {}