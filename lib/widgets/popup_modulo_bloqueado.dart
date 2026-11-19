
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarPopupModuloBloqueado(
  BuildContext context,
  String nomeModulo,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Fechar aviso',
    barrierColor: Colors.black.withValues(alpha: 0.45),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF9FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF963DFF),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.school_outlined,
                    color: Color(0xFF512B8B),
                    size: 25,
                  ),
                ),

                const SizedBox(height: 4),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E8FC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomeModulo,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF35303C),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Esse módulo está bloqueado.\n'
                        'Finalize o anterior para '
                        'desbloquear o novo conteúdo.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          height: 1.5,
                          color: const Color(0xFF35303C),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8127E8),
                          Color(0xFFF06ACB),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Voltar aos módulos',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final entrada = CurvedAnimation(
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
          ).animate(entrada),
          child: child,
        ),
      );
    },
  );
}
