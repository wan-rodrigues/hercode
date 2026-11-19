
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarPopupVidaRecuperada(
  BuildContext context, {
  required int vidasAtuais,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Vida recuperada',
    barrierColor: Colors.black.withValues(alpha: 0.4),
    transitionDuration: const Duration(milliseconds: 350),

    pageBuilder: (
      dialogContext,
      animation,
      secondaryAnimation,
    ) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F1FA),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFD7B8FA),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CORAÇÃO DA RECOMPENSA
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE8EA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFF44325),
                    size: 55,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Vida Recuperada!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8127E8),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Parabéns! Você conseguiu 3 acertos '
                  'e recuperou uma vida!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: const Color(0xFF35303C),
                  ),
                ),

                const SizedBox(height: 20),

                // CONTADOR DE VIDAS
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECE2FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Color(0xFFF44325),
                        size: 27,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        '$vidasAtuais de 5 vidas',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF512B8B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // BOTÃO CONTINUAR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8127E8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continuar praticando',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },

    // ANIMAÇÃO DE ENTRADA E SAÍDA
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final curva = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeIn,
      );

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(curva),
          child: child,
        ),
      );
    },
  );
}
