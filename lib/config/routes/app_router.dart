import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: SearchRoute.page),
    AutoRoute(page: ExploreRoute.page),
    AutoRoute(page: DestinationDetailsRoute.page),
    AutoRoute(page: HotelListRoute.page),
    AutoRoute(page: HotelDetailsRoute.page),
    AutoRoute(page: SelectRoomRoute.page),
    AutoRoute(page: BookingDetailsRoute.page),
    AutoRoute(page: PaymentRoute.page),
    AutoRoute(page: MyBookingRoute.page),
    AutoRoute(page: BookingViewDetailsRoute.page),
    AutoRoute(page: BookingSummaryRoute.page),
    AutoRoute(page: FavoriteRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: NotificationRoute.page),
  ];
}
