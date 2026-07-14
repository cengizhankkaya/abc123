import 'dart:math';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/parent_panel/presentation/providers/screen_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Ebeveyn Kapısı / Güvenlik Katmanı.
///
/// Çocukların yanlışlıkla Ebeveyn Paneli'ne veya ödeme alanlarına girmesini önleyen
/// matematik sorusu ve basılı tutma doğrulaması.
class ParentalGateScreen extends StatefulWidget {

  const ParentalGateScreen({
    super.key,
    this.onSuccess,
    this.isForScreenTimeExtension = false,
  });
  final VoidCallback? onSuccess;
  final bool isForScreenTimeExtension;

  @override
  State<ParentalGateScreen> createState() => _ParentalGateScreenState();
}

class _ParentalGateScreenState extends State<ParentalGateScreen>
    with SingleTickerProviderStateMixin {
  late int _num1;
  late int _num2;
  String _input = '';
  bool _hasError = false;

  late AnimationController _holdController;

  @override
  void initState() {
    super.initState();
    _generateProblem();
    _holdController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _verifyAndProceed();
        }
      });
  }

  void _generateProblem() {
    final rnd = Random();
    _num1 = 12 + rnd.nextInt(28); // 12..39
    _num2 = 11 + rnd.nextInt(29); // 11..39
    _input = '';
    _hasError = false;
  }

  void _verifyAndProceed() {
    if (widget.isForScreenTimeExtension) {
      context.read<ScreenTimeProvider>().extendTodayBy15Minutes();
    }
    if (widget.onSuccess != null) {
      widget.onSuccess!();
    } else {
      context.pushReplacement(AppRoutes.parentDashboard);
    }
  }

  void _onDigitPressed(String digit) {
    if (_input.length >= 3) return;
    setState(() {
      _hasError = false;
      _input += digit;
    });
  }

  void _onClearPressed() {
    setState(() {
      _hasError = false;
      _input = '';
    });
  }

  void _onSubmitPressed() {
    if (_input.isEmpty) return;
    final answer = int.tryParse(_input);
    if (answer == (_num1 + _num2)) {
      _verifyAndProceed();
    } else {
      setState(() {
        _hasError = true;
        _input = '';
      });
      _generateProblem();
    }
  }

  @override
  void dispose() {
    _holdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTr = Localizations.localeOf(context).languageCode == 'tr';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121218) : const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isTr ? 'Ebeveyn Doğrulaması' : 'Parental Verification',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Kilit İkonu & Başlık
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_person_rounded,
                    color: Color(0xFF6C63FF),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isTr
                      ? 'Lütfen yetişkin olduğunuzu doğrulayın'
                      : 'Please verify that you are an adult',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isTr
                      ? 'Aşağıdaki toplama işleminin sonucunu girin:'
                      : 'Enter the answer to the math problem below:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Soru Kutusu
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: _hasError ? Colors.red.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: _hasError ? Colors.redAccent : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$_num1 + $_num2 = ?',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 140,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2C2C38) : const Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _input.isEmpty ? '?' : _input,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _input.isEmpty ? Colors.grey : (isDark ? Colors.white : Colors.black87),
                          ),
                        ),
                      ),
                      if (_hasError) ...[
                        const SizedBox(height: 8),
                        Text(
                          isTr ? 'Yanlış cevap, tekrar deneyin!' : 'Incorrect answer, try again!',
                          style: const TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tuş Takımı
                SizedBox(
                  width: 260,
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      for (var i = 1; i <= 9; i++)
                        _buildKeyPadButton('$i', () => _onDigitPressed('$i'), isDark),
                      _buildKeyPadButton('C', _onClearPressed, isDark, isSpecial: true),
                      _buildKeyPadButton('0', () => _onDigitPressed('0'), isDark),
                      _buildKeyPadButton(
                        isTr ? 'GİR' : 'GO',
                        _onSubmitPressed,
                        isDark,
                        isSpecial: true,
                        specialColor: const Color(0xFF6C63FF),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Basılı Tutma Alternatifi
                Text(
                  isTr ? 'VEYA ALTERNATİF DOĞRULAMA:' : 'OR ALTERNATIVE VERIFICATION:',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTapDown: (_) => _holdController.forward(),
                  onTapUp: (_) => _holdController.reverse(),
                  onTapCancel: () => _holdController.reverse(),
                  child: AnimatedBuilder(
                    animation: _holdController,
                    builder: (context, child) {
                      return Container(
                        height: 52,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: isDark ? const Color(0xFF1E1E26) : Colors.white,
                          border: Border.all(color: const Color(0xFF6C63FF).withValues(alpha: 0.4), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              widthFactor: _holdController.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.touch_app_rounded, color: Color(0xFF6C63FF), size: 20),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        isTr ? 'Girmek için 3 Saniye Basılı Tut' : 'Hold for 3 Seconds to Enter',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? Colors.white : Colors.black87,
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyPadButton(String label, VoidCallback onTap, bool isDark, {bool isSpecial = false, Color? specialColor}) {
    return Material(
      color: specialColor ?? (isSpecial
          ? (isDark ? const Color(0xFF2C2C38) : const Color(0xFFE2E6EC))
          : (isDark ? const Color(0xFF1E1E26) : Colors.white)),
      borderRadius: BorderRadius.circular(12),
      elevation: isSpecial && specialColor == null ? 0 : 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: label.length > 2 ? 15 : 20,
              fontWeight: FontWeight.bold,
              color: specialColor != null
                  ? Colors.white
                  : (isSpecial
                      ? (isDark ? Colors.white70 : Colors.black87)
                      : (isDark ? Colors.white : Colors.black87)),
            ),
          ),
        ),
      ),
    );
  }
}
