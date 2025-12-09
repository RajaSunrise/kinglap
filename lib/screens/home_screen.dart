import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/court.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dataService = Provider.of<DataService>(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Top App Bar
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.9),
                title: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDs9p0A3LLOBv2RAO0GK-ptEk968SmuAxqi3iyrMoKT3DlJrhUhOR3mxvtAcKmmFjKwTKvlckcHuvX8tLSPiZ81zQlA7IlUNl15bCnUvgSlFw50iIcE4e21oh8hSAi6u_Y-hoF-8MkVXvpVfzdCJiIakmCxVS_cOhmOOzN9IQqMJ1Bh3foGSVMWf5iWm2Za0J6Jk9F5YVI_5FXSMplNpOCRxEI2ZBd2Fj3-nbKa6ybfSfPqWlnD0aJvOo80rys01Xuv51P5YhDdbA'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Kinglap',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF0d141b),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: Icon(Icons.notifications_outlined, color: isDark ? Colors.white : const Color(0xFF0d141b)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isDark ? null : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: isDark ? Colors.grey[400] : Colors.grey[500]),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari lapangan atau lokasi',
                              hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[500]),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(bottom: 4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Chips
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      _buildChip('Terdekat', true, theme),
                      const SizedBox(width: 12),
                      _buildChip('Rating Tertinggi', false, theme),
                      const SizedBox(width: 12),
                      _buildChip('Promo', false, theme),
                      const SizedBox(width: 12),
                      _buildChip('24 Jam', false, theme),
                    ],
                  ),
                ),
              ),

              // Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  child: Text(
                    'Populer di Dekatmu',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0d141b),
                    ),
                  ),
                ),
              ),

              // Court List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final court = dataService.courts[index];
                    return _buildCourtCard(context, court, theme);
                  },
                  childCount: dataService.courts.length,
                ),
              ),

              // Bottom padding for nav bar
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Bottom Nav Bar (Simulated custom nav to match design more closely if needed,
          // but Standard BottomNavigationBar is easier and consistent)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.9),
                border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(Icons.home, 'Beranda', 0, theme),
                  _buildNavItem(Icons.receipt_long, 'Booking Saya', 1, theme),
                  _buildNavItem(Icons.account_circle, 'Profil', 2, theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary
            : (isDark ? Colors.grey[800] : Colors.grey[200]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : (isDark ? Colors.grey[200] : const Color(0xFF0d141b)),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildCourtCard(BuildContext context, Court court, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/court_detail',
          arguments: {'courtId': court.id},
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800]?.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? null : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                court.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          court.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0d141b),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            court.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey[300] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              court.location,
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey[500],
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                                  fontSize: 14,
                                  fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                                ),
                                children: [
                                  const TextSpan(text: 'Mulai dari '),
                                  TextSpan(
                                    text: 'Rp ${court.pricePerHour ~/ 1000}.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0d141b),
                                    ),
                                  ),
                                  const TextSpan(text: ' / jam'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                           Navigator.pushNamed(
                            context,
                            '/court_detail',
                            arguments: {'courtId': court.id},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(84, 40),
                        ),
                        child: const Text('Book Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, ThemeData theme) {
    final isSelected = _selectedIndex == index;
    final color = isSelected
        ? theme.colorScheme.primary
        : (theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[500]);

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Already on Home
        } else if (index == 1) {
           // Navigate to Booking History (part of Profile in design, but let's make it work or just navigate to profile for now)
           Navigator.pushNamed(context, '/profile');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
