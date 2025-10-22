// lib/features/tourist/screens/attraction_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:video_player/video_player.dart';

class AttractionDetailScreen extends StatefulWidget {
  final Map<String, dynamic> attractionData;
  
  const AttractionDetailScreen({
    super.key,
    required this.attractionData,
  });

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentImageIndex = 0;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeVideo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  void _initializeVideo() {
    final videoUrl = widget.attractionData['videoUrl'] as String?;
    if (videoUrl != null && videoUrl.isNotEmpty) {
      _videoController = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          if (mounted) {
            setState(() => _isVideoInitialized = true);
          }
        });
    }
  }

  // Safe data extraction
  String get _name => widget.attractionData['name']?.toString() ?? 'Attraction';
  String get _description => widget.attractionData['description']?.toString() ?? 'No description available';
  String get _longDescription => widget.attractionData['longDescription']?.toString() ?? _description;
  double get _rating => (widget.attractionData['rating'] as num?)?.toDouble() ?? 0.0;
  int get _reviews => widget.attractionData['reviews'] as int? ?? 0;
  String get _location => widget.attractionData['location']?.toString() ?? 'Siwa Oasis';
  String get _category => widget.attractionData['category']?.toString() ?? 'attraction';
  String get _difficulty => widget.attractionData['difficulty']?.toString() ?? 'Easy';
  String get _duration => widget.attractionData['duration']?.toString() ?? '2-3 hours';
  String get _bestTimeToVisit => widget.attractionData['bestTimeToVisit']?.toString() ?? 'Morning';
  String get _entryFee => widget.attractionData['entryFee']?.toString() ?? 'Free';
  String get _openingHours => widget.attractionData['openingHours']?.toString() ?? '8:00 AM - 6:00 PM';
  
  List<String> get _images {
    final images = widget.attractionData['images'] as List?;
    final imageUrls = images?.cast<String>().where((url) => url.isNotEmpty).toList() ?? [];
    if (imageUrls.isEmpty) {
      final singleImage = widget.attractionData['imageUrl']?.toString();
      if (singleImage != null && singleImage.isNotEmpty) {
        imageUrls.add(singleImage);
      }
    }
    return imageUrls;
  }

  List<String> get _highlights => (widget.attractionData['highlights'] as List?)?.cast<String>() ?? [];
  List<String> get _facilities => (widget.attractionData['facilities'] as List?)?.cast<String>() ?? [];
  List<String> get _tips => (widget.attractionData['tips'] as List?)?.cast<String>() ?? [];
  
  Map<String, dynamic> get _historicalInfo => widget.attractionData['historicalInfo'] as Map<String, dynamic>? ?? {};
  List<Map<String, dynamic>> get _nearbyAttractions => (widget.attractionData['nearbyAttractions'] as List?)?.cast<Map<String, dynamic>>() ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image Carousel
          _buildSliverAppBar(),
          
          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Info
                _buildHeaderSection(),
                
                // Tab Bar
                _buildTabBar(),
                
                // Tab Content
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(),
                      _buildHistoryTab(),
                      _buildVisitorInfoTab(),
                      _buildMediaTab(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: AppTheme.white,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Share feature coming soon')),
            );
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Added to favorites')),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image Carousel
            if (_images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 1.0,
                  autoPlay: _images.length > 1,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setState(() => _currentImageIndex = index);
                  },
                ),
                items: _images.map((url) {
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stack) => Container(
                      color: AppTheme.lightBlueGray,
                      child: const Icon(Icons.image, size: 80, color: AppTheme.gray),
                    ),
                  );
                }).toList(),
              )
            else
              Container(
                color: AppTheme.lightBlueGray,
                child: const Icon(Icons.attractions, size: 80, color: AppTheme.primaryOrange),
              ),
            
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            // Image Counter
            if (_images.length > 1)
              Positioned(
                bottom: 100,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentImageIndex + 1}/${_images.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getCategoryColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _getCategoryColor()),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getCategoryIcon(), size: 16, color: _getCategoryColor()),
                const SizedBox(width: 6),
                Text(
                  _category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Title
          Text(
            _name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Rating and Location
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppTheme.primaryOrange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      _rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($_reviews)',
                      style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.location_on, size: 18, color: AppTheme.gray),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _location,
                  style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Quick Info Cards
          Row(
            children: [
              Expanded(child: _buildQuickInfoCard(Icons.access_time, 'Duration', _duration)),
              const SizedBox(width: 12),
              Expanded(child: _buildQuickInfoCard(Icons.fitness_center, 'Difficulty', _difficulty)),
              const SizedBox(width: 12),
              Expanded(child: _buildQuickInfoCard(Icons.wb_sunny, 'Best Time', _bestTimeToVisit)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.lightBlueGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryOrange, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppTheme.gray),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppTheme.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.primaryOrange,
        unselectedLabelColor: AppTheme.gray,
        indicatorColor: AppTheme.primaryOrange,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'History'),
          Tab(text: 'Visit Info'),
          Tab(text: 'Media'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'About',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            _showFullDescription ? _longDescription : _longDescription.length > 200 
                ? '${_longDescription.substring(0, 200)}...' 
                : _longDescription,
            style: const TextStyle(fontSize: 15, height: 1.6, color: AppTheme.darkGray),
          ),
          if (_longDescription.length > 200)
            TextButton(
              onPressed: () => setState(() => _showFullDescription = !_showFullDescription),
              child: Text(_showFullDescription ? 'Read Less' : 'Read More'),
            ),
          
          const SizedBox(height: 24),
          
          // Highlights
          if (_highlights.isNotEmpty) ...[
            const Text(
              'Highlights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._highlights.map((highlight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      highlight,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 24),
          ],
          
          // Facilities
          if (_facilities.isNotEmpty) ...[
            const Text(
              'Facilities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _facilities.map((facility) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.successGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, size: 16, color: AppTheme.successGreen),
                    const SizedBox(width: 6),
                    Text(
                      facility,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_historicalInfo.isNotEmpty) ...[
            // Historical Timeline
            const Text(
              'Historical Significance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            _buildTimelineItem(
              'Ancient Origins',
              _historicalInfo['origins']?.toString() ?? 'This site dates back to ancient times...',
              Icons.history_edu,
            ),
            _buildTimelineItem(
              'Historical Events',
              _historicalInfo['events']?.toString() ?? 'Significant historical events took place here...',
              Icons.event,
            ),
            _buildTimelineItem(
              'Cultural Impact',
              _historicalInfo['impact']?.toString() ?? 'This location has played a vital role in Siwan culture...',
              Icons.museum,
            ),
          ] else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: AppTheme.gray.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text(
                    'Historical information coming soon',
                    style: TextStyle(color: AppTheme.gray),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryOrange, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkGray,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Practical Information
          _buildInfoCard(Icons.schedule, 'Opening Hours', _openingHours),
          _buildInfoCard(Icons.payments, 'Entry Fee', _entryFee),
          _buildInfoCard(Icons.accessibility, 'Accessibility', 'Wheelchair accessible'),
          
          const SizedBox(height: 24),
          
          // Tips for Visitors
          if (_tips.isNotEmpty) ...[
            const Text(
              'Visitor Tips',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._tips.map((tip) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.warningYellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.warningYellow.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, color: AppTheme.warningYellow, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(tip, style: const TextStyle(fontSize: 14, height: 1.5)),
                  ),
                ],
              ),
            )),
          ],
          
          const SizedBox(height: 24),
          
          // Map
          const Text(
            'Location',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 200,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(29.1829, 25.5495),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(29.1829, 25.5495),
                        child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // Open maps
              },
              icon: const Icon(Icons.directions),
              label: const Text('Get Directions'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppTheme.primaryOrange),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lightGray),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryOrange, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: AppTheme.gray),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Section
          if (_videoController != null && _isVideoInitialized) ...[
            const Text(
              'Video Tour',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: _videoController!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_videoController!),
                    IconButton(
                      icon: Icon(
                        _videoController!.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 64,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _videoController!.value.isPlaying
                              ? _videoController!.pause()
                              : _videoController!.play();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Photo Gallery
          const Text(
            'Photo Gallery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    color: AppTheme.lightBlueGray,
                    child: const Icon(Icons.image, color: AppTheme.gray),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Entry Fee',
                    style: TextStyle(fontSize: 12, color: AppTheme.gray),
                  ),
                  Text(
                    _entryFee,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(
                  '/booking_form?type=attraction',
                  extra: {'serviceData': widget.attractionData},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.book_online),
                  SizedBox(width: 8),
                  Text(
                    'Book Visit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (_category.toLowerCase()) {
      case 'historical':
        return Colors.brown;
      case 'nature':
        return Colors.green;
      case 'adventure':
        return Colors.red;
      case 'culture':
        return Colors.purple;
      default:
        return AppTheme.primaryOrange;
    }
  }

  IconData _getCategoryIcon() {
    switch (_category.toLowerCase()) {
      case 'historical':
        return Icons.account_balance;
      case 'nature':
        return Icons.nature;
      case 'adventure':
        return Icons.terrain;
      case 'culture':
        return Icons.museum;
      default:
        return Icons.attractions;
    }
  }
}