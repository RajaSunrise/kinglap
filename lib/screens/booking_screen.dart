import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/data_service.dart';
import '../models/court.dart';
import '../models/booking.dart';

class BookingScreen extends StatefulWidget {
  final String courtId;

  const BookingScreen({super.key, required this.courtId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  int _duration = 2;

  final List<String> _times = [
    '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dataService = Provider.of<DataService>(context);
    final court = dataService.getCourtById(widget.courtId);

    if (court == null) return const Scaffold(body: Center(child: Text("Error")));

    final totalPrice = court.pricePerHour * _duration;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Lapangan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Date Selection
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pilih Tanggal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
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
                                IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_left)),
                                Text(DateFormat('MMMM yyyy').format(_selectedDate), style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_right)),
                              ],
                            ),
                            // Simple horizontal date picker mock
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  final date = DateTime.now().add(Duration(days: index));
                                  final isSelected = date.day == _selectedDate.day;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedDate = date;
                                      });
                                    },
                                    child: Container(
                                      width: 45,
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('E').format(date).substring(0, 1),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected ? Colors.white : Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            date.day.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                               color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Time Selection
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pilih Waktu & Durasi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _times.map((time) {
                          final isSelected = _selectedTime == time;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedTime = time;
                              });
                            },
                            child: Container(
                              width: 80,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                  ? theme.colorScheme.primary.withOpacity(0.2)
                                  : (isDark ? Colors.grey[800] : Colors.white),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected ? theme.colorScheme.primary : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                time,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? theme.colorScheme.primary : (isDark ? Colors.white : Colors.black87),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Durasi Bermain', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _duration > 1 ? () => setState(() => _duration--) : null,
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('$_duration Jam', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              IconButton(
                                onPressed: () => setState(() => _duration++),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Summary
           Container(
             padding: const EdgeInsets.all(24),
             decoration: BoxDecoration(
               color: isDark ? const Color(0xFF1E293B) : Colors.white,
               borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   blurRadius: 10,
                   offset: const Offset(0, -5),
                 )
               ]
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 const Text('Ringkasan Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                 const SizedBox(height: 16),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Tanggal', style: TextStyle(color: Colors.grey[500])),
                     Text(DateFormat('d MMMM yyyy').format(_selectedDate), style: const TextStyle(fontWeight: FontWeight.w600)),
                   ],
                 ),
                 const SizedBox(height: 8),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Waktu', style: TextStyle(color: Colors.grey[500])),
                     Text(_selectedTime != null ? '$_selectedTime - ${_calculateEndTime(_selectedTime!, _duration)}' : '-', style: const TextStyle(fontWeight: FontWeight.w600)),
                   ],
                 ),
                  const SizedBox(height: 8),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Total Harga', style: TextStyle(color: Colors.grey[500])),
                     Text('Rp $totalPrice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.primary)),
                   ],
                 ),
                 const SizedBox(height: 24),
                 ElevatedButton(
                   onPressed: _selectedTime == null ? null : () {
                     final booking = Booking(
                       id: DateTime.now().millisecondsSinceEpoch.toString(),
                       courtId: court.id,
                       userId: dataService.currentUser?.id ?? 'guest',
                       date: _selectedDate,
                       startTime: _selectedTime!,
                       duration: _duration,
                       totalPrice: totalPrice,
                     );

                     dataService.addBooking(booking);

                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Pemesanan Berhasil!')),
                     );

                     // Navigate to Profile or Home
                     Navigator.of(context).popUntil((route) => route.isFirst);
                     Navigator.pushNamed(context, '/profile');
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: theme.colorScheme.primary,
                     foregroundColor: Colors.white,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                   ),
                   child: const Text('Konfirmasi Pemesanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                 ),
               ],
             ),
           )
        ],
      ),
    );
  }

  String _calculateEndTime(String startTime, int duration) {
    int startHour = int.parse(startTime.split(':')[0]);
    int endHour = startHour + duration;
    return '${endHour.toString().padLeft(2, '0')}:00';
  }
}
