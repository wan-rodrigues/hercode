
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarPopupConteudoBloqueado(
  BuildContext context, {
  required String nome,
  required String mensagem,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar aviso de conteúdo bloqueado',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 320),

    pageBuilder: (
      dialogContext,
      animation,
      secondaryAnimation,
    ) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 335,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F1FA),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFA974FA),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ÍCONE
                Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    color: Color(0xFFECE2FA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: Color(0xFF8127E8),
                    size: 48,
                  ),
                ),

                const SizedBox(height: 17),

                Text(
                  'Conteúdo Bloqueado!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8127E8),
                  ),
                ),

                const SizedBox(height: 10),

                // NOME DO CONTEÚDO
                Text(
                  nome,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF35303C),
                  ),
                ),

                const SizedBox(height: 12),

                // EXPLICAÇÃO
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.5,
                    color: const Color(0xFF77768A),
                  ),
                ),

                const SizedBox(height: 18),

                // MENSAGEM MOTIVADORA
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECE2FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Color(0xFF8127E8),
                        size: 22,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          'Continue aprendendo para desbloquear!',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF512B8B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // BOTÃO
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
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Entendi!',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
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

    // ANIMAÇÃO
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
            begin: 0.85,
            end: 1.0,
          ).animate(curva),
          child: child,
        ),
      );
    },
  );
}
