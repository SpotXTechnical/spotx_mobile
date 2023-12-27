import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:owner/utils/flavors.dart';

String baseUrl = FlavorConfig.instance.variables[FlavorsVariables.baseUrlKey];

//Auth api
const String logIn = "/v1/owner/login";
const String registerApi = "/v1/owner/register";

const String profileApi = "/v1/owner/profile";

//Region api
const String getRegionsApi = "/v1/regions";

//SubRegion api
const String getSubRegionsApi = "/v1/sub-regions";

//OwnerRegion api
const String getOwnerRegionsApi = "/v1/owner/regions";

//Feature api
const String getFeaturesApi = "/v1/features";

//unit api
const String postUnitApi = "/v1/owner/units";

//media api
const String mediaApi = "/v1/owner/media";

//Unit api
const String getUnitsApi = "/v1/owner/units";

//payment api
const String paymentApi = "/v1/owner/payments";

//income api
const String incomeApi = "/v1/owner/incomes";

//total-income api
const String totalIncomes = "/v1/owner/total-incomes";

//reservation api
const String reservationApi = "/v1/owner/reservations";

//users api
const String usersApi = "/v1/owner/users";

//guests api
const String guestsApi = "/v1/owner/guests";

//notifications api
const String notificationsApi = "/v1/owner/notifications";

const String deviceTokenApi = "/v1/owner/device-tokens";

//getRegion by subregion id
const String getRegionBySubRegionIdApi = "/v1/main-region";

const int perPage = 20;
