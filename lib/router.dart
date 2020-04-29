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
import 'package:flutter_banking/view/signup_stepper_view.dart';
import 'package:flutter_banking/view/signup_view.dart';
import 'package:flutter_banking/view/spending_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SignUpView signUpView;

  SignUpStepperView signUpStepperView;
  LoginView loginView;
  HomeView homeView;
  SpendingView spendingView;
  AccountView accountView;

  AddAccountView addAccountView;
  AtmMapView atmMapView;

  @CustomRoute(transitionsBuilder: TransitionsBuilders.fadeIn)
  PreferencesView preferencesView;

  ContactSelectionView contactSelectionView;
  AddAccountView addContactView;

  @CustomRoute(transitionsBuilder: TransitionsBuilders.fadeIn)
  AmountSelectionView amountSelectionView;

  @CustomRoute(transitionsBuilder: TransitionsBuilders.fadeIn)
  AccountView accountSelectionView;

  AddTransactionOverview addTransactionOverview;

  @CustomRoute(transitionsBuilder: TransitionsBuilders.fadeIn)
  PurposeSelectionView purposeSelectionView;
}