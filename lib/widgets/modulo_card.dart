
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModuloCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;
  final double progresso;
  final bool desbloqueado;
  final VoidCallback? onTap;

  const ModuloCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.icone,
    this.progresso = 0,
    this.desbloqueado = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const roxo = Color(0xFF8127E8);
    const cinza = Color(0xFF99939F);
    const cinzaEscuro = Color(0xFF77768A);

    // Cores adaptadas ao estado do módulo.
    final Color corIcone = desbloqueado ? roxo : cinza;

    final Color fundoIcone = desbloqueado
        ? const Color(0xFFECE2FA)
        : const Color(0xFFF0EDF3);

    final Color corBorda = desbloqueado
        ? const Color(0xFFD7B8FA)
        : const Color(0xFFE8E3ED);

    final Color corTitulo = desbloqueado
        ? const Color(0xFF35303C)
        : cinzaEscuro;

    final Color corDescricao = desbloqueado
        ? const Color(0xFF77768A)
        : cinza;

    final Color corProgresso = desbloqueado
        ? roxo
        : cinza;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: corBorda,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ÍCONE E TÍTULO
                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: fundoIcone,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        desbloqueado
                            ? icone
                            : Icons.lock_outline_rounded,
                        color: corIcone,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        titulo,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: corTitulo,
                        ),
                      ),
                    ),

                    if (!desbloqueado) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.lock_rounded,
                        color: cinza,
                        size: 24,
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // DESCRIÇÃO
                Text(
                  descricao,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 1.4,
                    color: corDescricao,
                  ),
                ),

                const SizedBox(height: 14),

                // INFORMAÇÕES DE PROGRESSO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progresso',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: corDescricao,
                      ),
                    ),

                    Text(
                      '${(progresso * 100).toInt()}%',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: corProgresso,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // BARRA DE PROGRESSO
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progresso.clamp(0.0, 1.0),
                    minHeight: 9,
                    backgroundColor: desbloqueado
                        ? const Color(0xFFECE2FA)
                        : const Color(0xFFE8E3ED),
                    color: corProgresso,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
