import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailScreen extends StatefulWidget {
  final Map<String, dynamic> booking;

  const BookingDetailScreen({
    super.key,
    required this.booking,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  bool _showCancellationPolicy = false;

  // Safe getters with fallbacks
  String get _bookingId => widget.booking['id']?.toString() ?? 
                          widget.booking['bookingId']?.toString() ?? 
                          DateTime.now().millisecondsSinceEpoch.toString();
  
  String get _serviceName => widget.booking['title']?.toString() ?? 
                            widget.booking['serviceName']?.toString() ?? 
                            'Unknown Service';
  
  String get _serviceType => widget.booking['serviceType']?.toString() ?? 
                            widget.booking['category']?.toString() ?? 
                            'general';
  
  String get _status => widget.booking['status']?.toString() ?? 'pending';
  
  String? get _imageUrl => widget.booking['imageUrl']?.toString() ?? 
                          widget.booking['serviceImage']?.toString();
  
  DateTime? get _checkInDate {
    final date = widget.booking['date'] ?? 
                widget.booking['checkIn'] ?? 
                widget.booking['bookingDate'];
    
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) {
      return DateTime.tryParse(date) ?? DateTime.tryParse('${date}T00:00:00');
    }
    return null;
  }
  
  DateTime? get _checkOutDate {
    final date = widget.booking['checkOut'] ?? 
                widget.booking['checkOutDate'];
    
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) {
      return DateTime.tryParse(date) ?? DateTime.tryParse('${date}T00:00:00');
    }
    return null;
  }
  
  int get _adults => widget.booking['adults'] as int? ?? 
                    widget.booking['adultCount'] as int? ?? 1;
  
  int get _children => widget.booking['children'] as int? ?? 
                      widget.booking['childCount'] as int? ?? 0;
  
  double get _totalPrice => (widget.booking['totalPrice'] as num?)?.toDouble() ?? 
                           (widget.booking['price'] as num?)?.toDouble() ?? 
                           (widget.booking['amount'] as num?)?.toDouble() ?? 
                           0.0;
  
  String? get _specialRequests => widget.booking['specialRequests']?.toString() ?? 
                                 widget.booking['notes']?.toString();
  
  String? get _location => widget.booking['location']?.toString();
  String? get _contactPhone => widget.booking['contactPhone']?.toString();
  String? get _contactEmail => widget.booking['contactEmail']?.toString();

  Color _getStatusColor() {
    final statusLower = _status.toLowerCase();
    if (statusLower.contains('confirm') || statusLower.contains('approved')) {
      return AppTheme.successGreen;
    } else if (statusLower.contains('pend') || statusLower.contains('waiting')) {
      return AppTheme.warningYellow;
    } else if (statusLower.contains('cancel') || statusLower.contains('rejected')) {
      return AppTheme.errorRed;
    }
    return AppTheme.gray;
  }

  IconData _getStatusIcon() {
    final statusLower = _status.toLowerCase();
    if (statusLower.contains('confirm') || statusLower.contains('approved')) {
      return Icons.check_circle;
    } else if (statusLower.contains('pend') || statusLower.contains('waiting')) {
      return Icons.schedule;
    } else if (statusLower.contains('cancel') || statusLower.contains('rejected')) {
      return Icons.cancel;
    }
    return Icons.help_outline;
  }

  bool get _canCancel {
    final statusLower = _status.toLowerCase();
    if (statusLower.contains('cancel') || statusLower.contains('rejected')) {
      return false;
    }
    
    // Check if booking is in the future
    if (_checkInDate != null) {
      return _checkInDate!.isAfter(DateTime.now());
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Booking Details'.tr()),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: _shareBooking,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'download':
                  _downloadBooking();
                  break;
                case 'help':
                  _contactSupport();
                  break;
                case 'report':
                  _reportIssue();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    const Icon(Icons.download_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text('Download Receipt'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'help',
                child: Row(
                  children: [
                    const Icon(Icons.help_outline, size: 20),
                    const SizedBox(width: 12),
                    Text('Contact Support'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    const Icon(Icons.flag_outlined, size: 20),
                    const SizedBox(width: 12),
                    Text('Report Issue'.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: _getStatusColor().withOpacity(0.1),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getStatusIcon(),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getStatusMessage(),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Service Image Card
            if (_imageUrl != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        _imageUrl!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.lightBlueGray,
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: AppTheme.gray,
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _serviceName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (_location != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      _location!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Booking Reference Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking Reference'.tr(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#$_bookingId',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _bookingId));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Booking ID copied'.tr()),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        tooltip: 'Copy'.tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Booking Details Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Information'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Check-in Date
                  if (_checkInDate != null)
                    _buildDetailRow(
                      Icons.calendar_today_outlined,
                      'Check-in'.tr(),
                      DateFormat('EEEE, MMM dd, yyyy').format(_checkInDate!),
                    ),

                  if (_checkInDate != null && _checkOutDate != null)
                    const SizedBox(height: 16),

                  // Check-out Date
                  if (_checkOutDate != null)
                    _buildDetailRow(
                      Icons.event_outlined,
                      'Check-out'.tr(),
                      DateFormat('EEEE, MMM dd, yyyy').format(_checkOutDate!),
                    ),

                  const Divider(height: 32),

                  // Guests
                  _buildDetailRow(
                    Icons.people_outline,
                    'Guests'.tr(),
                    '$_adults Adult${_adults > 1 ? 's' : ''}, $_children Child${_children != 1 ? 'ren' : ''}',
                  ),

                  if (_checkInDate != null && _checkOutDate != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      Icons.nights_stay_outlined,
                      'Duration'.tr(),
                      '${_checkOutDate!.difference(_checkInDate!).inDays} night${_checkOutDate!.difference(_checkInDate!).inDays > 1 ? 's' : ''}',
                    ),
                  ],

                  const Divider(height: 32),

                  // Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'EGP ${_totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),

                  // Special Requests
                  if (_specialRequests != null && _specialRequests!.isNotEmpty) ...[
                    const Divider(height: 32),
                    Text(
                      'Special Requests'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.lightBlueGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _specialRequests!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // QR Code Card
            if (_status.toLowerCase().contains('confirm'))
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Check-in QR Code'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.lightGray),
                      ),
                      child: QrImageView(
                        data: _bookingId,
                        version: QrVersions.auto,
                        size: 200,
                        errorStateBuilder: (context, error) {
                          return Container(
                            width: 200,
                            height: 200,
                            color: AppTheme.lightBlueGray,
                            child: const Center(
                              child: Text('QR Code Error'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Show this code at check-in'.tr(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.gray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Contact Information Card
            if (_contactPhone != null || _contactEmail != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_contactPhone != null)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.phone,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        title: Text('Phone'.tr()),
                        subtitle: Text(_contactPhone!),
                        trailing: IconButton(
                          icon: const Icon(Icons.call),
                          onPressed: () => _makeCall(_contactPhone!),
                        ),
                      ),
                    if (_contactEmail != null)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.email,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        title: Text('Email'.tr()),
                        subtitle: Text(_contactEmail!),
                        trailing: IconButton(
                          icon: const Icon(Icons.mail_outline),
                          onPressed: () => _sendEmail(_contactEmail!),
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Cancellation Policy
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.policy_outlined,
                      color: AppTheme.primaryOrange,
                    ),
                    title: Text(
                      'Cancellation Policy'.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      _showCancellationPolicy
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                    onTap: () {
                      setState(() {
                        _showCancellationPolicy = !_showCancellationPolicy;
                      });
                    },
                  ),
                  if (_showCancellationPolicy)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          _buildPolicyPoint(
                            '• Free cancellation up to 48 hours before check-in',
                          ),
                          _buildPolicyPoint(
                            '• 50% refund for cancellations 24-48 hours before',
                          ),
                          _buildPolicyPoint(
                            '• No refund for cancellations within 24 hours',
                          ),
                          _buildPolicyPoint(
                            '• Full refund for cancellations by the service provider',
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // Bottom Action Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (_canCancel)
                Expanded(
                  child: OutlinedButton(
                    onPressed: _cancelBooking,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.errorRed,
                      side: const BorderSide(color: AppTheme.errorRed),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Cancel Booking'.tr()),
                  ),
                ),
              if (_canCancel) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _contactSupport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.support_agent, size: 20),
                      const SizedBox(width: 8),
                      Text('Contact Support'.tr()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.lightBlueGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppTheme.primaryOrange),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.gray,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPolicyPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, height: 1.5),
      ),
    );
  }

  String _getStatusMessage() {
    final statusLower = _status.toLowerCase();
    if (statusLower.contains('confirm')) {
      return 'Your booking is confirmed. See you soon!';
    } else if (statusLower.contains('pend')) {
      return 'Awaiting confirmation from service provider';
    } else if (statusLower.contains('cancel')) {
      return 'This booking has been cancelled';
    }
    return 'Booking status: $_status';
  }

  void _cancelBooking() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Booking?'.tr()),
        content: Text(
          'Are you sure you want to cancel this booking? This action cannot be undone.'
              .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No, Keep It'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual cancellation logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking cancellation requested'.tr()),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
            ),
            child: Text('Yes, Cancel'.tr()),
          ),
        ],
      ),
    );
  }

  void _contactSupport() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Support'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.phone, color: AppTheme.primaryOrange),
              title: Text('Call Support'.tr()),
              subtitle: const Text('+20 123 456 7890'),
              onTap: () => _makeCall('+201234567890'),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppTheme.primaryOrange),
              title: Text('Email Support'.tr()),
              subtitle: const Text('support@siwa.com'),
              onTap: () => _sendEmail('support@siwa.com'),
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: AppTheme.primaryOrange),
              title: Text('Live Chat'.tr()),
              subtitle: Text('Available 24/7'.tr()),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Chat feature coming soon'.tr())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareBooking() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share feature coming soon'.tr())),
    );
  }

  void _downloadBooking() {
    // TODO: Implement download receipt
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading receipt...'.tr())),
    );
  }

  void _reportIssue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Issue'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What\'s the issue?'.tr()),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe the issue...'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Issue reported. We\'ll get back to you soon.'.tr()),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
            ),
            child: Text('Submit'.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _makeCall(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot make call'.tr())),
        );
      }
    }
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Booking Inquiry - $_bookingId',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot open email'.tr())),
        );
      }
    }
  }
}