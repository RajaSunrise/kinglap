import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/data_service.dart';
import '../models/court.dart';

class CourtDetailScreen extends StatelessWidget {
  final String courtId;

  const CourtDetailScreen({super.key, required this.courtId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dataService = Provider.of<DataService>(context, listen: false);
    final Court? court = dataService.getCourtById(courtId);

    if (court == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Court not found')),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top Bar
              SafeArea(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Detail Lapangan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40), // Balance the back button
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Image
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                court.imageUrl,
                                height: 320,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 320,
                                  color: Colors.grey,
                                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
                                ),
                              ),
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _indicator(true),
                                    const SizedBox(width: 8),
                                    _indicator(false),
                                    const SizedBox(width: 8),
                                    _indicator(false),
                                    const SizedBox(width: 8),
                                    _indicator(false),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          court.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),

                      // Location
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: theme.colorScheme.primary, size: 30),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                court.location,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark ? Colors.grey[300] : Colors.grey[700],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Lihat Peta',
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Text(
                          court.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: isDark ? Colors.grey[300] : Colors.grey[800],
                          ),
                        ),
                      ),

                      const Divider(height: 32, thickness: 1),

                      // Check Schedule Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Cek Jadwal & Harga',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),

                      // Segmented Control (Mock)
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Kalender',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Daftar Waktu',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.grey[300] : Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Calendar Mock
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isDark ? null : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.chevron_left, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                                Text(
                                  'Juni 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: ['SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB', 'MIN']
                                  .map((day) => SizedBox(
                                        width: 32,
                                        child: Text(
                                          day,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isDark ? Colors.grey[400] : Colors.grey[500],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 12),
                            // Mock days grid
                             GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                              itemCount: 35,
                              itemBuilder: (context, index) {
                                final day = index - 4; // Offset to start at 1
                                if (day <= 0 || day > 30) {
                                  return Center(
                                    child: Text(
                                      day <= 0 ? '${27+index}' : '${day-30}',
                                      style: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[400]),
                                    )
                                  );
                                }
                                final isToday = day == 6;
                                return Container(
                                  decoration: isToday ? BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ) : null,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$day',
                                    style: TextStyle(
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      color: isToday
                                        ? theme.colorScheme.primary
                                        : (isDark ? Colors.white : Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100), // Space for sticky footer
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Footer
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
                border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Harga per jam',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Rp ${court.pricePerHour ~/ 1000}.000',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/booking',
                            arguments: {'courtId': court.id},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isActive ? 1.0 : 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
