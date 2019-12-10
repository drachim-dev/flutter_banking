import 'package:flutter_banking/services/account_service.dart';
import 'package:flutter_banking/services/firebase_service.dart';
import 'package:flutter_banking/services/location_service.dart';
import 'package:flutter_banking/services/transaction_service.dart';
import 'package:flutter_banking/viewmodel/account_model.dart';
import 'package:flutter_banking/viewmodel/add_account_model.dart';
import 'package:flutter_banking/viewmodel/add_transaction_overview_model.dart';
import 'package:flutter_banking/viewmodel/contact_model.dart';
import 'package:flutter_banking/viewmodel/depot_model.dart';
import 'package:flutter_banking/viewmodel/login_model.dart';
import 'package:flutter_banking/services/authentication_service.dart';
import 'package:flutter_banking/services/user_service.dart';
import 'package:flutter_banking/viewmodel/map_model.dart';
import 'package:flutter_banking/viewmodel/spending_model.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => AccountService());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => LocalAuthentication());

  locator.registerFactory(() => AccountModel());
  locator.registerFactory(() => AddAccountModel());
  locator.registerFactory(() => ContactModel());
  locator.registerFactory(() => DepotModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => MapModel());
  locator.registerFactory(() => SpendingModel());
  locator.registerFactory(() => AddTransactionOverviewModel());
}