import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarPopupNovaPioneira(
  BuildContext context, {
  required VoidCallback onVisitarHallDaFama,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 28),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.85, end: 1),
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value.clamp(0, 1),
                child: child,
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F1FA),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 6),
                    const Icon(
                      Icons.star,
                      size: 90,
                      color: Color(0xFFF4C430),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Nova Pioneira\nDesbloqueada!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF7C3AED),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton(
                        onPressed: onVisitarHallDaFama,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF7C3AED),
                                Color(0xFFEC4899),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'Visitar Hall da Fama',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9C2FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}