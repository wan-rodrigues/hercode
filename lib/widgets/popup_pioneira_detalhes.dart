import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pioneira {
  final String nome;
  final String periodo;
  final String imagem;
  final String biografia;
  final int modulo;

  const Pioneira({
    required this.nome,
    required this.periodo,
    required this.imagem,
    required this.biografia,
    required this.modulo,
  });
}

Future<void> mostrarPopupPioneiraDetalhes(
  BuildContext context, {
  required Pioneira pioneira,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.92, end: 1),
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
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 650,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            children: [
                              Text(
                                pioneira.nome,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2F2F39),
                                ),
                              ),
                              Text(
                                pioneira.periodo,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        pioneira.imagem,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      pioneira.biografia,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        height: 1.6,
                        color: const Color(0xFF2F2F39),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}