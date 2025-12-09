import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/data_service.dart';
import '../models/booking.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dataService = Provider.of<DataService>(context);
    final currentUser = dataService.currentUser;
    final bookings = currentUser != null
        ? dataService.getBookingsForUser(currentUser.id)
        : <Booking>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              color: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: currentUser != null
                        ? NetworkImage(currentUser.profilePictureUrl)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentUser?.name ?? 'Guest',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currentUser?.email ?? '',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      foregroundColor: theme.colorScheme.primary,
                      elevation: 0,
                    ),
                    child: const Text('Edit Profil'),
                  ),
                ],
              ),
            ),

            Divider(thickness: 4, color: isDark ? Colors.black26 : Colors.grey[100]),

            // Booking History
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Riwayat Pemesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Toggle Buttons (Visual only for now)
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Akan Datang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('Selesai', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (bookings.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.sports_soccer, size: 100, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          const Text('Belum Ada Pemesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Anda belum memiliki riwayat pemesanan.', style: TextStyle(color: Colors.grey[500])),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Booking Lapangan Sekarang'),
                          ),
                        ],
                      ),
                    )
                  else
                    ...bookings.map((booking) {
                       final court = dataService.getCourtById(booking.courtId);
                       return Card(
                         margin: const EdgeInsets.only(bottom: 16),
                         color: isDark ? const Color(0xFF1E293B) : Colors.white,
                         elevation: 2,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                         child: Padding(
                           padding: const EdgeInsets.all(16),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(court?.name ?? 'Unknown Court', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                   Text('Rp ${booking.totalPrice}', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                                 ],
                               ),
                               const SizedBox(height: 8),
                               Row(
                                 children: [
                                   const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                   const SizedBox(width: 8),
                                   Text(DateFormat('d MMM yyyy').format(booking.date)),
                                   const SizedBox(width: 16),
                                   const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                   const SizedBox(width: 8),
                                   Text('${booking.startTime} (${booking.duration} Jam)'),
                                 ],
                               ),
                               const SizedBox(height: 12),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   OutlinedButton(
                                     onPressed: () {
                                       dataService.deleteBooking(booking.id);
                                     },
                                     style: OutlinedButton.styleFrom(
                                       foregroundColor: Colors.red,
                                       side: const BorderSide(color: Colors.red),
                                     ),
                                     child: const Text('Batalkan'),
                                   )
                                 ],
                               )
                             ],
                           ),
                         ),
                       );
                    }),
                ],
              ),
            ),

             Divider(thickness: 4, color: isDark ? Colors.black26 : Colors.grey[100]),

             // Settings Section
             Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text('Pengaturan & Bantuan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 16),
                   _buildSettingItem(context, Icons.settings, 'Pengaturan Aplikasi'),
                   _buildSettingItem(context, Icons.help_outline, 'Pusat Bantuan'),
                   _buildSettingItem(context, Icons.info_outline, 'Tentang Kinglap'),
                   const SizedBox(height: 24),
                   SizedBox(
                     width: double.infinity,
                     height: 50,
                     child: TextButton.icon(
                       onPressed: () {
                         Navigator.pushReplacementNamed(context, '/');
                       },
                       icon: const Icon(Icons.logout),
                       label: const Text('Keluar'),
                       style: TextButton.styleFrom(
                         backgroundColor: Colors.red.withOpacity(0.1),
                         foregroundColor: Colors.red,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       ),
                     ),
                   )
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
    );
  }
}
