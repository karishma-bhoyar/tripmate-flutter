// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:flutter_application_tripmate/features/bookings/booking_summary/booking_summary_screen.dart'
    as _i2;
import 'package:flutter_application_tripmate/features/bookings/booking_view_details/booking_view_details_screen.dart'
    as _i3;
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart'
    as _i20;
import 'package:flutter_application_tripmate/features/bookings/my_booking/my_booking_screen.dart'
    as _i11;
import 'package:flutter_application_tripmate/features/destination/data/models/destination_model.dart'
    as _i21;
import 'package:flutter_application_tripmate/features/explore/destination_details/destination_details_screen.dart'
    as _i4;
import 'package:flutter_application_tripmate/features/explore/explore_screen.dart'
    as _i5;
import 'package:flutter_application_tripmate/features/favorites/favorite_screen.dart'
    as _i6;
import 'package:flutter_application_tripmate/features/home/view/home_screen.dart'
    as _i7;
import 'package:flutter_application_tripmate/features/home/widgets/hotel_card.dart'
    as _i22;
import 'package:flutter_application_tripmate/features/hotels/booking_details/booking_details_screen.dart'
    as _i1;
import 'package:flutter_application_tripmate/features/hotels/hotel_details/hotel_details_screen.dart'
    as _i8;
import 'package:flutter_application_tripmate/features/hotels/hotel_list/hotel_list_screen.dart'
    as _i9;
import 'package:flutter_application_tripmate/features/hotels/payment/payment_screen.dart'
    as _i13;
import 'package:flutter_application_tripmate/features/hotels/select_room/select_room_screen.dart'
    as _i15;
import 'package:flutter_application_tripmate/features/search/presentation/search_screen.dart'
    as _i14;
import 'package:flutter_application_tripmate/view/auth/login_screen.dart'
    as _i10;
import 'package:flutter_application_tripmate/view/auth/sign_up_screen.dart'
    as _i16;
import 'package:flutter_application_tripmate/view/onboarding/onboarding_screen.dart'
    as _i12;
import 'package:flutter_application_tripmate/view/splash/splash_screen.dart'
    as _i17;

/// generated route for
/// [_i1.BookingDetailsScreen]
class BookingDetailsRoute extends _i18.PageRouteInfo<BookingDetailsRouteArgs> {
  BookingDetailsRoute({
    required _i15.RoomData roomData,
    String? hotelName,
    String? location,
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BookingDetailsRoute.name,
         args: BookingDetailsRouteArgs(
           roomData: roomData,
           hotelName: hotelName,
           location: location,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'BookingDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingDetailsRouteArgs>();
      return _i1.BookingDetailsScreen(
        roomData: args.roomData,
        hotelName: args.hotelName,
        location: args.location,
        key: args.key,
      );
    },
  );
}

class BookingDetailsRouteArgs {
  const BookingDetailsRouteArgs({
    required this.roomData,
    this.hotelName,
    this.location,
    this.key,
  });

  final _i15.RoomData roomData;

  final String? hotelName;

  final String? location;

  final _i19.Key? key;

  @override
  String toString() {
    return 'BookingDetailsRouteArgs{roomData: $roomData, hotelName: $hotelName, location: $location, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingDetailsRouteArgs) return false;
    return roomData == other.roomData &&
        hotelName == other.hotelName &&
        location == other.location &&
        key == other.key;
  }

  @override
  int get hashCode =>
      roomData.hashCode ^ hotelName.hashCode ^ location.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.BookingSummaryScreen]
class BookingSummaryRoute extends _i18.PageRouteInfo<BookingSummaryRouteArgs> {
  BookingSummaryRoute({
    _i19.Key? key,
    required _i20.BookingModel booking,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BookingSummaryRoute.name,
         args: BookingSummaryRouteArgs(key: key, booking: booking),
         initialChildren: children,
       );

  static const String name = 'BookingSummaryRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingSummaryRouteArgs>();
      return _i2.BookingSummaryScreen(key: args.key, booking: args.booking);
    },
  );
}

class BookingSummaryRouteArgs {
  const BookingSummaryRouteArgs({this.key, required this.booking});

  final _i19.Key? key;

  final _i20.BookingModel booking;

  @override
  String toString() {
    return 'BookingSummaryRouteArgs{key: $key, booking: $booking}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingSummaryRouteArgs) return false;
    return key == other.key && booking == other.booking;
  }

  @override
  int get hashCode => key.hashCode ^ booking.hashCode;
}

/// generated route for
/// [_i3.BookingViewDetailsScreen]
class BookingViewDetailsRoute
    extends _i18.PageRouteInfo<BookingViewDetailsRouteArgs> {
  BookingViewDetailsRoute({
    _i19.Key? key,
    required _i20.BookingModel booking,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BookingViewDetailsRoute.name,
         args: BookingViewDetailsRouteArgs(key: key, booking: booking),
         initialChildren: children,
       );

  static const String name = 'BookingViewDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingViewDetailsRouteArgs>();
      return _i3.BookingViewDetailsScreen(key: args.key, booking: args.booking);
    },
  );
}

class BookingViewDetailsRouteArgs {
  const BookingViewDetailsRouteArgs({this.key, required this.booking});

  final _i19.Key? key;

  final _i20.BookingModel booking;

  @override
  String toString() {
    return 'BookingViewDetailsRouteArgs{key: $key, booking: $booking}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingViewDetailsRouteArgs) return false;
    return key == other.key && booking == other.booking;
  }

  @override
  int get hashCode => key.hashCode ^ booking.hashCode;
}

/// generated route for
/// [_i4.DestinationDetailsScreen]
class DestinationDetailsRoute
    extends _i18.PageRouteInfo<DestinationDetailsRouteArgs> {
  DestinationDetailsRoute({
    _i19.Key? key,
    _i21.DestinationModel? destination,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         DestinationDetailsRoute.name,
         args: DestinationDetailsRouteArgs(key: key, destination: destination),
         initialChildren: children,
       );

  static const String name = 'DestinationDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DestinationDetailsRouteArgs>(
        orElse: () => const DestinationDetailsRouteArgs(),
      );
      return _i4.DestinationDetailsScreen(
        key: args.key,
        destination: args.destination,
      );
    },
  );
}

class DestinationDetailsRouteArgs {
  const DestinationDetailsRouteArgs({this.key, this.destination});

  final _i19.Key? key;

  final _i21.DestinationModel? destination;

  @override
  String toString() {
    return 'DestinationDetailsRouteArgs{key: $key, destination: $destination}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DestinationDetailsRouteArgs) return false;
    return key == other.key && destination == other.destination;
  }

  @override
  int get hashCode => key.hashCode ^ destination.hashCode;
}

/// generated route for
/// [_i5.ExploreScreen]
class ExploreRoute extends _i18.PageRouteInfo<void> {
  const ExploreRoute({List<_i18.PageRouteInfo>? children})
    : super(ExploreRoute.name, initialChildren: children);

  static const String name = 'ExploreRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.ExploreScreen();
    },
  );
}

/// generated route for
/// [_i6.FavoriteScreen]
class FavoriteRoute extends _i18.PageRouteInfo<void> {
  const FavoriteRoute({List<_i18.PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.FavoriteScreen();
    },
  );
}

/// generated route for
/// [_i7.HomeScreen]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomeScreen();
    },
  );
}

/// generated route for
/// [_i8.HotelDetailsScreen]
class HotelDetailsRoute extends _i18.PageRouteInfo<HotelDetailsRouteArgs> {
  HotelDetailsRoute({
    _i19.Key? key,
    _i22.HotelData? hotelData,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         HotelDetailsRoute.name,
         args: HotelDetailsRouteArgs(key: key, hotelData: hotelData),
         initialChildren: children,
       );

  static const String name = 'HotelDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HotelDetailsRouteArgs>(
        orElse: () => const HotelDetailsRouteArgs(),
      );
      return _i8.HotelDetailsScreen(key: args.key, hotelData: args.hotelData);
    },
  );
}

class HotelDetailsRouteArgs {
  const HotelDetailsRouteArgs({this.key, this.hotelData});

  final _i19.Key? key;

  final _i22.HotelData? hotelData;

  @override
  String toString() {
    return 'HotelDetailsRouteArgs{key: $key, hotelData: $hotelData}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HotelDetailsRouteArgs) return false;
    return key == other.key && hotelData == other.hotelData;
  }

  @override
  int get hashCode => key.hashCode ^ hotelData.hashCode;
}

/// generated route for
/// [_i9.HotelListScreen]
class HotelListRoute extends _i18.PageRouteInfo<HotelListRouteArgs> {
  HotelListRoute({
    _i19.Key? key,
    required _i21.DestinationModel destination,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         HotelListRoute.name,
         args: HotelListRouteArgs(key: key, destination: destination),
         initialChildren: children,
       );

  static const String name = 'HotelListRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HotelListRouteArgs>();
      return _i9.HotelListScreen(key: args.key, destination: args.destination);
    },
  );
}

class HotelListRouteArgs {
  const HotelListRouteArgs({this.key, required this.destination});

  final _i19.Key? key;

  final _i21.DestinationModel destination;

  @override
  String toString() {
    return 'HotelListRouteArgs{key: $key, destination: $destination}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HotelListRouteArgs) return false;
    return key == other.key && destination == other.destination;
  }

  @override
  int get hashCode => key.hashCode ^ destination.hashCode;
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.LoginScreen();
    },
  );
}

/// generated route for
/// [_i11.MyBookingScreen]
class MyBookingRoute extends _i18.PageRouteInfo<void> {
  const MyBookingRoute({List<_i18.PageRouteInfo>? children})
    : super(MyBookingRoute.name, initialChildren: children);

  static const String name = 'MyBookingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i11.MyBookingScreen();
    },
  );
}

/// generated route for
/// [_i12.OnboardingScreen]
class OnboardingRoute extends _i18.PageRouteInfo<void> {
  const OnboardingRoute({List<_i18.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i13.PaymentScreen]
class PaymentRoute extends _i18.PageRouteInfo<PaymentRouteArgs> {
  PaymentRoute({
    _i19.Key? key,
    required double totalAmount,
    String? hotelName,
    String? location,
    required _i15.RoomData roomData,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int guestCount,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         PaymentRoute.name,
         args: PaymentRouteArgs(
           key: key,
           totalAmount: totalAmount,
           hotelName: hotelName,
           location: location,
           roomData: roomData,
           checkInDate: checkInDate,
           checkOutDate: checkOutDate,
           guestCount: guestCount,
         ),
         initialChildren: children,
       );

  static const String name = 'PaymentRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentRouteArgs>();
      return _i13.PaymentScreen(
        key: args.key,
        totalAmount: args.totalAmount,
        hotelName: args.hotelName,
        location: args.location,
        roomData: args.roomData,
        checkInDate: args.checkInDate,
        checkOutDate: args.checkOutDate,
        guestCount: args.guestCount,
      );
    },
  );
}

class PaymentRouteArgs {
  const PaymentRouteArgs({
    this.key,
    required this.totalAmount,
    this.hotelName,
    this.location,
    required this.roomData,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
  });

  final _i19.Key? key;

  final double totalAmount;

  final String? hotelName;

  final String? location;

  final _i15.RoomData roomData;

  final DateTime checkInDate;

  final DateTime checkOutDate;

  final int guestCount;

  @override
  String toString() {
    return 'PaymentRouteArgs{key: $key, totalAmount: $totalAmount, hotelName: $hotelName, location: $location, roomData: $roomData, checkInDate: $checkInDate, checkOutDate: $checkOutDate, guestCount: $guestCount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentRouteArgs) return false;
    return key == other.key &&
        totalAmount == other.totalAmount &&
        hotelName == other.hotelName &&
        location == other.location &&
        roomData == other.roomData &&
        checkInDate == other.checkInDate &&
        checkOutDate == other.checkOutDate &&
        guestCount == other.guestCount;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      totalAmount.hashCode ^
      hotelName.hashCode ^
      location.hashCode ^
      roomData.hashCode ^
      checkInDate.hashCode ^
      checkOutDate.hashCode ^
      guestCount.hashCode;
}

/// generated route for
/// [_i14.SearchScreen]
class SearchRoute extends _i18.PageRouteInfo<void> {
  const SearchRoute({List<_i18.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.SearchScreen();
    },
  );
}

/// generated route for
/// [_i15.SelectRoomScreen]
class SelectRoomRoute extends _i18.PageRouteInfo<SelectRoomRouteArgs> {
  SelectRoomRoute({
    _i19.Key? key,
    String? hotelName,
    String? location,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         SelectRoomRoute.name,
         args: SelectRoomRouteArgs(
           key: key,
           hotelName: hotelName,
           location: location,
         ),
         initialChildren: children,
       );

  static const String name = 'SelectRoomRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectRoomRouteArgs>(
        orElse: () => const SelectRoomRouteArgs(),
      );
      return _i15.SelectRoomScreen(
        key: args.key,
        hotelName: args.hotelName,
        location: args.location,
      );
    },
  );
}

class SelectRoomRouteArgs {
  const SelectRoomRouteArgs({this.key, this.hotelName, this.location});

  final _i19.Key? key;

  final String? hotelName;

  final String? location;

  @override
  String toString() {
    return 'SelectRoomRouteArgs{key: $key, hotelName: $hotelName, location: $location}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectRoomRouteArgs) return false;
    return key == other.key &&
        hotelName == other.hotelName &&
        location == other.location;
  }

  @override
  int get hashCode => key.hashCode ^ hotelName.hashCode ^ location.hashCode;
}

/// generated route for
/// [_i16.SignUpScreen]
class SignUpRoute extends _i18.PageRouteInfo<void> {
  const SignUpRoute({List<_i18.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i17.SplashScreen]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.SplashScreen();
    },
  );
}
