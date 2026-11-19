
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../logic/mecanica_licao.dart';

class ExercicioAlternativas extends StatelessWidget {
  final MecanicaLicao mecanica;
  final void Function(ResultadoResposta resultado) onResposta;

  const ExercicioAlternativas({
    super.key,
    required this.mecanica,
    required this.onResposta,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: mecanica,
      builder: (context, child) {
        final questao = mecanica.questaoAtual;

        if (questao == null) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questao.enunciado,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF512B8B),
              ),
            ),
            const SizedBox(height: 16),

            ...mecanica.alternativasEmbaralhadas.map(
              (alternativa) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final resultado =
                            mecanica.responder(alternativa.id);
                        onResposta(resultado);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFDAB5FF),
                          ),
                        ),
                        child: Text(
                          alternativa.texto,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            height: 1.5,
                            color: const Color(0xFF35303C),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
