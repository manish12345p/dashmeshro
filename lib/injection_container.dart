import 'package:core/core.dart';
import 'package:customer_directory/customer_directory.dart';
import 'package:visit_entry/visit_entry.dart';
import 'package:emi_page/emi_page.dart';
import 'package:calendar/calendar.dart';
import 'package:home_page/home_page.dart';
import 'package:history_page/history_page.dart';

Future<void> init() async {
  // Feature: Customer Directory
  sl.registerLazySingleton<ICustomerRepository>(() => CustomerRepository());

  // Feature: Service Entry
  sl.registerLazySingleton<IVisitEntryRepository>(() => VisitEntryRepository());
  sl.registerLazySingleton(() => SaveServiceUseCase(sl()));

  // Feature: EMI Page
  sl.registerLazySingleton<EmiRepositoryInterface>(() => EmiRepository());
  sl.registerLazySingleton(() => GetEmiDashboardDataUseCase(sl()));
  sl.registerLazySingleton(() => MarkEmiPaidUseCase(sl()));
  sl.registerLazySingleton(() => AddEmiPaymentUseCase(sl()));

  // Feature: Home Page
  sl.registerLazySingleton<IHomeRepository>(() => HomeRepository());
  sl.registerLazySingleton(() => GetHomeDataUseCase(sl()));
  sl.registerFactory(() => HomeBloc(getHomeDataUseCase: sl()));

  // Feature: Calendar
  sl.registerLazySingleton<ICalendarRepository>(() => CalendarRepository());
  sl.registerLazySingleton(() => GetCalendarSchedulesUseCase(sl()));
  sl.registerLazySingleton(() => DismissScheduleUseCase(sl()));
  sl.registerFactory(() => CalendarBloc(
    getCalendarSchedulesUseCase: sl(),
    dismissScheduleUseCase: sl(),
  ));

  // Feature: History Page
  sl.registerLazySingleton<IHistoryRepository>(() => HistoryRepository());
  sl.registerLazySingleton(() => GetAllServicesUseCase(sl()));
  sl.registerFactory(() => HistoryBloc(
    getAllServicesUseCase: sl(),
  ));

  // Other features...
}
