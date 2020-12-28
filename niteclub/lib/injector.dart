import 'package:get_it/get_it.dart';

import 'package:niteclub/core/utils/clouddb.dart';
import 'package:niteclub/core/utils/location_util.dart';
import 'package:niteclub/core/services/place_service.dart';

GetIt locator = GetIt.instance;

void setipInyection() async {
  await locator.registerSingleton(LocationUtils());
  //setup.registerLazySingleton(() => API('places'));
  await locator.registerSingleton(PlaceService());
}