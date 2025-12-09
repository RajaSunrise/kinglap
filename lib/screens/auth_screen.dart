import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: const EdgeInsets.fromLTRB(24, 64, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Kinglap',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0d141b),
                ),
              ),
              const SizedBox(height: 32),

              // Auth Toggle
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF101922) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isLogin
                                ? (isDark ? Colors.grey[700] : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: _isLogin && !isDark
                                ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2)]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _isLogin
                                  ? theme.colorScheme.primary
                                  : (isDark ? Colors.grey[400] : Colors.grey[500]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !_isLogin
                                ? (isDark ? Colors.grey[700] : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: !_isLogin && !isDark
                                ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2)]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: !_isLogin
                                  ? theme.colorScheme.primary
                                  : (isDark ? Colors.grey[400] : Colors.grey[500]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email atau Nomor Telepon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : const Color(0xFF0d141b),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan email atau nomor telepon',
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kata Sandi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : const Color(0xFF0d141b),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kata sandi',
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              if (_isLogin) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa Kata Sandi?',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    _isLogin ? 'Masuk' : 'Daftar',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: Divider(color: isDark ? Colors.grey[600] : Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'atau masuk dengan',
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[500],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: isDark ? Colors.grey[600] : Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDeQnnxV7TsJp32d9t9gYuBc6za9SDQ5WMMT7RALF0Ckn7ALTavS5tQl9m0LD1Bmcu269qDpn3MC44rTnuuF-ASXdmk92J2fqKXW2kr-m8_ETMOz2viBZe6mb_WMMJbU0YzKvJLqhmw9topsidPWIQB8FRwQOfwxd836NYnftotyugRFq9d2JQhzPzVjdXN3p0VoSUHI_NzXbSl2qP04BQH5wJAH8d41gGOpGPazDJ5vWcyM_hcjEeAiF5hMPvXg2i_7xDCbLWVwg',
                    isDark
                  ),
                  const SizedBox(width: 16),
                  _socialButton(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCQq42urgWSbsc27MU8gdF-uAk1VjDYiY4orkEvhfcTsjD6QMjbphRiMyEYHbDTmOaQH3FbKNFHmFSM1uxtStySsgvd-XPba0mT4hn0WvPVSUciW7Jl739FOFXHTxotylasBBPv6QvuxjQntN1ocMdOOgnZhjnwK2TWZfDFva0ZD-WyRn5vnDC6dBBIbnf0wrYUYm1h49_g5yM0I_z1UPWeWRcZ5DMqGLJ-DistKHTh35VkwMQ0FTOJiI9cmy9m8w9w0yCnBDBX9w',
                    isDark
                  ),
                  const SizedBox(width: 16),
                  _socialButton(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBo6u8XulMTMJes2HUa6dDwjAFhosqeYMGYK21pxLnEzNMr8qNxftfF-052R9IWPVLzCq8LH9MLZGCIY-uM0d2aZQHpwm3CFyRKhYiORvRfRdwITf2vVlG7C92ON9YiOwZGTLHIvszC3g9uJtGzE3gbBmPs8pgkO6dFzh8X45OYT5v-sAbteonQxzfSFtGxqpYKo8X4Q3F_CF-5J33qaTPnUU4WDMaWJkTO4v1Ji13RgVtmHtUPOzrCxYh8SZ3CrhwyM7yDI8YUgw',
                    isDark
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? 'Belum punya akun? ' : 'Sudah punya akun? ',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin ? 'Daftar' : 'Masuk',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String iconUrl, bool isDark) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDark ? Colors.grey[600]! : Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Image.network(iconUrl),
    );
  }
}
