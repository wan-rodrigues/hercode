
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarPopupModuloConcluido(
  BuildContext context, {
  required VoidCallback onRevisar,
  required VoidCallback onRefazer,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Módulo concluído',
    barrierColor: Colors.black.withValues(alpha: 0.35),
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      void selecionarOpcao(VoidCallback acao) {
        Navigator.of(dialogContext).pop();
        acao();
      }

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 310,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F1FA),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF963DFF),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF8127E8),
                  size: 65,
                ),

                const SizedBox(height: 14),

                Text(
                  'Módulo Concluído!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8127E8),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Você já completou este módulo!\n'
                  'O que deseja fazer?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF35303C),
                  ),
                ),

                const SizedBox(height: 24),

                _BotaoOpcao(
                  icone: Icons.menu_book_rounded,
                  titulo: 'Revisar conteúdo',
                  descricao: 'Rever explicações e exemplos',
                  onTap: () => selecionarOpcao(onRevisar),
                ),

                const SizedBox(height: 12),

                _BotaoOpcao(
                  icone: Icons.refresh_rounded,
                  titulo: 'Refazer módulo',
                  descricao: 'Praticar novamente',
                  onTap: () => selecionarOpcao(onRefazer),
                ),

                const SizedBox(height: 14),

                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF77768A),
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
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.85,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
          ),
          child: child,
        ),
      );
    },
  );
}

class _BotaoOpcao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback onTap;

  const _BotaoOpcao({
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFECE2FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icone,
                color: const Color(0xFF8127E8),
                size: 27,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF512B8B),
                      ),
                    ),
                    Text(
                      descricao,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF77768A),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8127E8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
