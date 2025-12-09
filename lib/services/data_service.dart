import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/court.dart';
import '../models/booking.dart';
import '../models/user.dart';

class DataService extends ChangeNotifier {
  List<Court> _courts = [];
  List<Booking> _bookings = [];
  List<User> _users = []; // All registered users
  User? _currentUser;

  List<Court> get courts => _courts;
  List<Booking> get bookings => _bookings;
  User? get currentUser => _currentUser;

  DataService() {
    _initializeData();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _courtsFile async {
    final path = await _localPath;
    return File('$path/courts.json');
  }

  Future<File> get _bookingsFile async {
    final path = await _localPath;
    return File('$path/bookings.json');
  }

  Future<File> get _usersFile async {
    final path = await _localPath;
    return File('$path/users.json');
  }

  Future<void> _initializeData() async {
    await _loadUsers();
    await _loadCourts();
    await _loadBookings();

    // Create default admin if not exists
    if (!_users.any((u) => u.email == 'admin@gmail.com')) {
      final admin = User(
        id: 'admin',
        name: 'Admin Kinglap',
        email: 'admin@gmail.com',
        password: 'admin123', // Default password
        role: 'admin',
        profilePictureUrl: 'https://cdn-icons-png.flaticon.com/512/9703/9703596.png',
      );
      _users.add(admin);
      await _saveUsers();
    }

    // Create mock courts if empty (first run)
    if (_courts.isEmpty) {
      _courts = [
        Court(
          id: '1',
          name: 'Cilandak Futsal',
          location: 'Cilandak, Jakarta Selatan',
          rating: 4.8,
          pricePerHour: 120000,
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA7I47nj0tUZ_Sw71O9JGe3-Z9CXLsYstyemtWlCkP2L8zq7ziX9Pj6wP02TcIi6dpEJp8iRNw_5_jt7II7_LPlMdRMN3yPBKEWpSdDpuQTAgIlwDRgTBFhVrrX0hDdyUJ3Z1DCmoPPjikq6ewvNiaVU3UVIeGuwQwCmm_FCVDhq5e-G2Ic6dVhnn7A4b7rF-NEH0lNacjp0mDhSD30UPXr1xSkE70TU3tLLwWUi2wwvf0G30tqhGeLmYXj26gLjx_Skvjx_c21Pg',
          description: 'Lapangan futsal terbaik di Jakarta Selatan dengan fasilitas lengkap.',
          features: ['Indoor', 'Sintetis', 'Parkir Luas', 'Kantin'],
        ),
        Court(
          id: '2',
          name: 'Galaxy Futsal Ancol',
          location: 'Ancol, Jakarta Utara',
          rating: 4.9,
          pricePerHour: 150000,
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCGCBtSeSHtQ1r-ekzANAZM7Ii8osV7zteOhyQwCHRnan9T7TAFsQOFerVAY1Nw5a1gqh6yIp7SFT8-XuVcJZvHcNvD_oB6SVO9yOOTAtiBu6xJOG74fB3ysvc6GyPEgF4IGpcInhMsr2GEwi3_cxJD7yUK6UHeg2QJYjqZFzLfnRIyyCat_R5PRcid--vt810nXkJlyEAycGtKc9AmLeByURHZeQSU5yrOYA55OSHaax1cePoCnpmX4Kp8_a5-2m7lnWLynWnZ9w',
          description: 'Bermain futsal dengan suasana pantai yang menyegarkan.',
          features: ['Outdoor', 'Vinyl', 'Lampu Terang', 'Shower'],
        ),
         Court(
          id: '3',
          name: 'My Futsal Kebayoran',
          location: 'Kebayoran, Jakarta Selatan',
          rating: 4.7,
          pricePerHour: 100000,
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCTZ3riKbdPa0B1Xr50Ob2rud7xdKs0oBHx-O9WktDZ6ZlmAB3GsXLnkvEEa3FR6lzgbQQo_c3vh5IexCUQM757yxcp9Zr3F-av7Rb9WGoWnKg4UOpB8Ax--4-CzpqVGH6u8qR4NUOJJraghZWlDjktocmU5YH3xFDJBLuCzRvYGQGb8RLNbK4-W12Mg5ypSrTy7bJNofO6G_gDTzI-M2uG5w-auQ8KD321ORfxtEVa6fYC_XwzlYscGk4sa9bsCs4xAH_uzcFp9g',
          description: 'Lapangan futsal ekonomis dengan kualitas rumput yang tetap terjaga.',
          features: ['Indoor', 'Sintetis', 'Murah'],
        ),
         Court(
          id: '4',
          name: 'Lapangan Sintetis A',
          location: 'Jl. Sudirman No. 123, Jakarta',
          rating: 4.9,
          pricePerHour: 150000,
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBRAmVvsn3P6oViJum2KHARTZVERE-njzYaZjboZQrHaH-dQpThUV2gVvfYQ17-prPDPGxiir2aOeM_T5QrDtAOGaRmlJlrqANZjon_KIA8a6Mw63BueP4fz0HcjYmJs6L9gnSTSeF_qoA8iPfHSEXmh_OIatZILWxhSsacHRPeRlCZWgFUjdYtEcCeaGXNjkSJ4w4o4ECImKCGHkaCziWN5C2gL10JBTfPQhSHhvzM7tDQbR7gd3hHHKvVK5-nwk89TbCFcQPjkg',
          description: 'Lapangan futsal indoor dengan rumput sintetis standar internasional, cocok untuk latihan maupun pertandingan. Dilengkapi dengan fasilitas pendukung yang lengkap.',
          features: ['Indoor', 'Sintetis', 'Standar Internasional', 'Tribun'],
        ),
      ];
      await _saveCourts();
    }

    notifyListeners();
  }

  // --- Auth Methods ---

  Future<bool> login(String email, String password) async {
    try {
      final user = _users.firstWhere((u) => u.email == email && u.password == password);
      _currentUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    if (_users.any((u) => u.email == email)) {
      return false; // Email already exists
    }
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      password: password,
      role: 'user',
      profilePictureUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCJZM5fffIewO8PVfSJp-8lGUst6VrNrRG7703Jap_eFTf_gh9_J5hIUNonsn79SomX1r8aeusQbwvq7ThpwrRH-xYZhEoBsmHa_ponDihAlzd6SrFjcEFOqZzkJFGV3JV6yWYhxXjoymsb43AoypPUuP8k3LAYuf1S83_Aan2A466AmEalPaVAXIvrTtJummQVbQHTB6z4ii6T8EE2JCd01ogPi64pRxX3OGIHsHglcjoZvqFZM1D30WgYC26Bv9Cv6or3d-gWEA',
    );
    _users.add(newUser);
    _currentUser = newUser;
    await _saveUsers();
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // --- Court CRUD Methods (Admin) ---

  Future<void> addCourt(Court court) async {
    _courts.add(court);
    await _saveCourts();
    notifyListeners();
  }

  Future<void> updateCourt(Court updatedCourt) async {
    final index = _courts.indexWhere((c) => c.id == updatedCourt.id);
    if (index != -1) {
      _courts[index] = updatedCourt;
      await _saveCourts();
      notifyListeners();
    }
  }

  Future<void> deleteCourt(String courtId) async {
    _courts.removeWhere((c) => c.id == courtId);
    await _saveCourts();
    notifyListeners();
  }


  // --- Booking Methods ---

  Future<void> addBooking(Booking booking) async {
    _bookings.add(booking);
    await _saveBookings();
    notifyListeners();
  }

  Future<void> deleteBooking(String bookingId) async {
    _bookings.removeWhere((element) => element.id == bookingId);
    await _saveBookings();
    notifyListeners();
  }

  // --- File I/O Helpers ---

  Future<void> _loadUsers() async {
    try {
      final file = await _usersFile;
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _users = jsonList.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading users: $e');
    }
  }

  Future<void> _saveUsers() async {
    try {
      final file = await _usersFile;
      final String content = jsonEncode(_users.map((u) => u.toJson()).toList());
      await file.writeAsString(content);
    } catch (e) {
      print('Error saving users: $e');
    }
  }

  Future<void> _loadCourts() async {
    try {
      final file = await _courtsFile;
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _courts = jsonList.map((json) => Court.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading courts: $e');
    }
  }

  Future<void> _saveCourts() async {
    try {
      final file = await _courtsFile;
      final String content = jsonEncode(_courts.map((c) => c.toJson()).toList());
      await file.writeAsString(content);
    } catch (e) {
      print('Error saving courts: $e');
    }
  }

  Future<void> _loadBookings() async {
    try {
      final file = await _bookingsFile;
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(content);
        _bookings = jsonList.map((json) => Booking.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading bookings: $e');
    }
  }

  Future<void> _saveBookings() async {
    try {
      final file = await _bookingsFile;
      final String content = jsonEncode(_bookings.map((b) => b.toJson()).toList());
      await file.writeAsString(content);
    } catch (e) {
      print('Error saving bookings: $e');
    }
  }

  // --- Getters ---

  Court? getCourtById(String id) {
    try {
      return _courts.firstWhere((court) => court.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Booking> getBookingsForUser(String userId) {
    return _bookings.where((b) => b.userId == userId).toList();
  }
}
