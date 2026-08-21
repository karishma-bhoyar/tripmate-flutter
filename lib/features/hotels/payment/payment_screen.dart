import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/bookings/data/booking_store.dart';
import 'package:flutter_application_tripmate/features/bookings/models/booking_model.dart';
import 'package:flutter_application_tripmate/features/hotels/select_room/select_room_screen.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';
import 'package:intl/intl.dart' hide TextDirection;

enum PaymentMethodType { upi, card, netBanking, wallet, emi }

class PaymentMethodData {
  final PaymentMethodType type;
  final String title;
  final String subTitle;
  final Color themeColor;
  final Widget icon;

  PaymentMethodData({
    required this.title,
    required this.subTitle,
    required this.themeColor,
    required this.icon,
    required this.type,
  });
}

@RoutePage()
class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final String? hotelName;
  final String? location;
  final RoomData roomData;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guestCount;
  const PaymentScreen({
    super.key,
    required this.totalAmount,
    this.hotelName,
    this.location,
    required this.roomData,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethodType _selectedMethod = PaymentMethodType.upi;
  bool _isProcessing = false;
  final currencyFormatter = NumberFormat.currency(
    locale: "en_IN",
    symbol: '₹',
    decimalDigits: 0,
  );

  void _handlePayment() async {
    final dateFormat = DateFormat('dd MMM');
    final yearFormat = DateFormat('yyyy');
    final formattedDates =
        '${dateFormat.format(widget.checkInDate)} - '
        '${dateFormat.format(widget.checkOutDate)}'
        '${yearFormat.format(widget.checkOutDate)}';
    setState(() {
      _isProcessing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _isProcessing = false;
    });
    final booking = BookingModel(
      id: 'TM${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
      hotelName: widget.hotelName ?? 'Hotel',
      location: widget.location ?? 'Unknown Location',
      imageUrl: widget.roomData.imageUrl,
      roomName: widget.roomData.name,
      roomPrice: widget.roomData.price,
      checkInDate: widget.checkInDate,
      checkOutDate: widget.checkOutDate,
      guestCount: widget.guestCount,
      totalAmount: widget.totalAmount,
      status: BookingStatus.upcoming,
    );

    await BookingStore.addBooking(booking);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PaymentSuccessDialog(
        amount: widget.totalAmount,
        methodType: _selectedMethod,
        hotelName: widget.hotelName ?? "Hotel",
        dates: formattedDates,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedAmount = currencyFormatter.format(widget.totalAmount);
    final List<PaymentMethodData> paymentMethodData = [
      PaymentMethodData(
        title: "UPI",
        subTitle: 'Pay using any UPI app',
        themeColor: const Color(0xFFF37021).withValues(alpha: 0.1),
        icon: const UpiLogo(),
        type: PaymentMethodType.upi,
      ),
      PaymentMethodData(
        title: 'Credit / Debit Card',
        subTitle: 'Visa, MasterCard, Rupay',
        themeColor: Colors.blue.withValues(alpha: 0.1),
        icon: const Icon(
          Icons.credit_card_rounded,
          color: Colors.blue,
          size: 22,
        ),
        type: PaymentMethodType.card,
      ),
      PaymentMethodData(
        type: PaymentMethodType.netBanking,
        title: 'Net Banking',
        subTitle: 'All major banks',
        themeColor: Colors.teal.withValues(alpha: 0.1),
        icon: const Icon(
          Icons.account_balance_rounded,
          color: Colors.teal,
          size: 22,
        ),
      ),
      PaymentMethodData(
        type: PaymentMethodType.wallet,
        title: 'Wallets',
        subTitle: 'Paytm, PhonePe, etc.',
        themeColor: Colors.purple.withValues(alpha: 0.1),
        icon: const Icon(
          Icons.account_balance_wallet_rounded,
          color: Colors.purple,
          size: 22,
        ),
      ),
      PaymentMethodData(
        type: PaymentMethodType.emi,
        title: 'EMI',
        subTitle: 'Easy monthly installments',
        themeColor: Colors.orange.withValues(alpha: 0.1),
        icon: const Icon(
          Icons.receipt_long_rounded,
          color: Colors.orange,
          size: 22,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Payment',
        onBackPressed: () => context.router.pop(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.timer_outlined, color: AppColors.blackColor),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing24,
                  vertical: AppSizes.spacing16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.spacing20,
                        vertical: AppSizes.spacing20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(AppSizes.radius16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                          Text(
                            formattedAmount,
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing24),
                    Text(
                      'Select Payment Method',
                      style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacing16),
                    Column(
                      children: paymentMethodData.map((method) {
                        final isSelected = _selectedMethod == method.type;
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSizes.spacing12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMethod = method.type;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.spacing16,
                                vertical: AppSizes.spacing16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.greyColor.withValues(
                                          alpha: 0.15,
                                        ),
                                  width: isSelected ? 1.5 : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius16,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: method.themeColor,
                                      borderRadius: BorderRadius.circular(
                                        AppSizes.radius12,
                                      ),
                                    ),
                                    child: method.icon,
                                  ),
                                  const SizedBox(width: AppSizes.spacing16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          method.title,
                                          style: AppTextStyles.body.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          method.subTitle,
                                          style: AppTextStyles.caption.copyWith(
                                            color: AppColors.greyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor.withValues(
                                                alpha: 0.3,
                                              ),
                                        width: isSelected ? 6.5 : 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSizes.spacing24),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: PrimaryButton(
                  isLoading: _isProcessing,
                  text: 'Pay $formattedAmount',
                  onPressed: _handlePayment,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentSuccessDialog extends StatefulWidget {
  final double amount;
  final PaymentMethodType methodType;
  final String hotelName;
  final String dates;
  const PaymentSuccessDialog({
    super.key,
    required this.amount,
    required this.methodType,
    required this.hotelName,
    required this.dates,
  });

  @override
  State<PaymentSuccessDialog> createState() => _PaymentSuccessDialogState();
}

class _PaymentSuccessDialogState extends State<PaymentSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getMethodName() {
    switch (widget.methodType) {
      case PaymentMethodType.upi:
        return "UPI";
      case PaymentMethodType.card:
        return "Credit / Debit Card";
      case PaymentMethodType.netBanking:
        return "Net Banking";
      case PaymentMethodType.wallet:
        return "Wallet";
      case PaymentMethodType.emi:
        return "EMI";
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: "en_IN",
      symbol: '₹',
      decimalDigits: 0,
    );
    final formattedAmount = currencyFormatter.format(widget.amount);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius24),
      ),
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.greenColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.greenColor,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacing24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    "Payment successful",
                    style: AppTextStyles.title.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Text(
                    'Your booking at ${widget.hotelName} has been successfully confirmed. A receipt has been sent to your email.',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 13,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  Container(
                    padding: const EdgeInsets.all(AppSizes.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(AppSizes.radius16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'payment Method',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacing16),
                            Expanded(
                              child: Text(
                                _getMethodName(),
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount Paid',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacing16),
                            Expanded(
                              child: Text(
                                formattedAmount,
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction ID',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacing16),
                            Expanded(
                              child: Text(
                                'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                ),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing24),
                  PrimaryButton(
                    text: 'View Booking',
                    onPressed: () {
                      context.router.replaceAll([const MyBookingRoute()]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpiLogo extends StatelessWidget {
  final double width;
  final double height;
  const UpiLogo({super.key, this.width = 32, this.height = 14});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(width, height), painter: _UpiLogoPainter());
  }
}

class _UpiLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final h = size.height;
    final w = size.width;

    // Draw left arrow element (Orange)
    final path1 = Path();
    path1.moveTo(w * 0.1, h * 0.2);
    path1.lineTo(w * 0.35, h * 0.2);
    path1.lineTo(w * 0.25, h * 0.5);
    path1.lineTo(w * 0.0, h * 0.5);
    path1.close();
    paint.color = const Color(0xFFF37021);
    canvas.drawPath(path1, paint);

    // Draw right arrow element (Green)
    final path2 = Path();
    path2.moveTo(w * 0.25, h * 0.55);
    path2.lineTo(w * 0.5, h * 0.55);
    path2.lineTo(w * 0.4, h * 0.85);
    path2.lineTo(w * 0.15, h * 0.85);
    path2.close();
    paint.color = const Color(0xFF097939);
    canvas.drawPath(path2, paint);

    // Draw UPI text (Blue)
    const textStyle = TextStyle(
      color: Color(0xFF0B55A0),
      fontSize: 11,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      letterSpacing: -0.5,
    );
    final textSpan = TextSpan(text: 'UPI', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: w);
    textPainter.paint(canvas, Offset(w * 0.48, -h * 0.1));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
