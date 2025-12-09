import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Kinglap',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0d141b),
                ),
              ),
              const SizedBox(height: 32),
              // Toggle Switch
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF101922) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isLogin
                                ? (isDark ? Colors.grey[700] : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 2,
                                    )
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isLogin
                                  ? theme.colorScheme.primary
                                  : (isDark ? Colors.grey[400] : Colors.grey[500]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isLogin
                                ? (isDark ? Colors.grey[700] : Colors.white)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: !isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 2,
                                    )
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: !isLogin
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
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : const Color(0xFF0d141b),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan email atau nomor telepon',
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Kata Sandi',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : const Color(0xFF0d141b),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kata sandi',
                      filled: true,
                      fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                       border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Lupa Kata Sandi?',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Home
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
                    isLogin ? 'Masuk' : 'Daftar',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
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
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 24),
              // Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   _SocialButton(
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDeQnnxV7TsJp32d9t9gYuBc6za9SDQ5WMMT7RALF0Ckn7ALTavS5tQl9m0LD1Bmcu269qDpn3MC44rTnuuF-ASXdmk92J2fqKXW2kr-m8_ETMOz2viBZe6mb_WMMJbU0YzKvJLqhmw9topsidPWIQB8FRwQOfwxd836NYnftotyugRFq9d2JQhzPzVjdXN3p0VoSUHI_NzXbSl2qP04BQH5wJAH8d41gGOpGPazDJ5vWcyM_hcjEeAiF5hMPvXg2i_7xDCbLWVwg',
                  ),
                  const SizedBox(width: 16),
                  _SocialButton(
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCQq42urgWSbsc27MU8gdF-uAk1VjDYiY4orkEvhfcTsjD6QMjbphRiMyEYHbDTmOaQH3FbKNFHmFSM1uxtStySsgvd-XPba0mT4hn0WvPVSUciW7Jl739FOFXHTxotylasBBPv6QvuxjQntN1ocMdOOgnZhjnwK2TWZfDFva0ZD-WyRn5vnDC6dBBIbnf0wrYUYm1h49_g5yM0I_z1UPWeWRcZ5DMqGLJ-DistKHTh35VkwMQ0FTOJiI9cmy9m8w9w0yCnBDBX9w',
                  ),
                  const SizedBox(width: 16),
                  _SocialButton(
                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBo6u8XulMTMJes2HUa6dDwjAFhosqeYMGYK21pxLnEzNMr8qNxftfF-052R9IWPVLzCq8LH9MLZGCIY-uM0d2aZQHpwm3CFyRKhYiORvRfRdwITf2vVlG7C92ON9YiOwZGTLHIvszC3g9uJtGzE3gbBmPs8pgkO6dFzh8X45OYT5v-sAbteonQxzfSFtGxqpYKo8X4Q3F_CF-5J33qaTPnUU4WDMaWJkTO4v1Ji13RgVtmHtUPOzrCxYh8SZ3CrhwyM7yDI8YUgw',
                    invertInDark: true,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
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
}

class _SocialButton extends StatelessWidget {
  final String imageUrl;
  final bool invertInDark;

  const _SocialButton({required this.imageUrl, this.invertInDark = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Image.network(
        imageUrl,
        color: (isDark && invertInDark) ? Colors.white : null,
      ),
    );
  }
}
