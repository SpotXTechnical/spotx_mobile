import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:spotx/utils/flavors.dart';

BuildVariant selectedBuildVariant = BuildVariant.develop;


String baseUrl = FlavorConfig.instance.variables[FlavorsVariables.baseUrlKey];

//Auth api
const String logIn = "/v1/user/login";
const String registerApi = "/v1/user/register";

// CompanyCode api
const companyCodeApi = '/v1/user/profile/company';

//Region api
const String getRegionsApi = "/v1/regions";

//SubRegion api
const String getSubRegionsApi = "/v1/sub-regions";

const String regionsSearchApi = "/v1/regions-search";

//Unit api
const String getUnitsApi = "/v1/user/units";
const String getUnitsFilterConfigApi = "/v1/units-filter-config";

//City api
const String getCitiesApi = "/v1/cities";

const String settings = "/v1/system/settings";
const String checkDomainExistence = "/v1/client/domain/check";
const String getProfileApi = "/v1/user/profile";
const String forgetPassword = "/v1/client/forgot-password";
const String updateLocaleEndpoint = "/v1/client/profile/locale";
const String logOut = "/v1/client/profile/logout";
const String orders = "/v1/client/driver/orders";

//reservation api
const String reservationApi = "/v1/user/reservations";

//summaryApi api
const String summaryApi = "/v1/user/reservations/summary";

//favourite api
const String favouriteApi = "/v1/user/favourites";

//room details api
const String roomDetailsApi = "/v1/user/rooms";

//offers api
const String offersApi = "/v1/user/offers";

const String ratingApi = "/v1/user/reviews";

//device-tokens api
const String deviceTokenApi = "/v1/user/device-tokens";

const String ownerApi = "/v1/user/owners";

//getRegion by subregion id
const String getMainRegionApi = "/v1/main-region";

const String mostPopularRegion = "/v1/most-popular/regions";

const int perPage = 20;