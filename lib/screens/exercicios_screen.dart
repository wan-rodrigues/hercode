
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart' show progressoProvider, vidasProvider;
import '../data/modulos_data.dart';
import 'pratica_modulo1_screen.dart';
import '../widgets/popup_conteudo_bloqueado.dart';

class ExerciciosScreen extends StatefulWidget {
  const ExerciciosScreen({super.key});

  @override
  State<ExerciciosScreen> createState() => _ExerciciosScreenState();
}

class _ExerciciosScreenState extends State<ExerciciosScreen> {
  @override
  void initState() {
    super.initState();
    progressoProvider.addListener(atualizarTela);
    vidasProvider.addListener(atualizarTela);
  }

  void atualizarTela() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    progressoProvider.removeListener(atualizarTela);
    vidasProvider.removeListener(atualizarTela);
    super.dispose();
  }

  void abrirExercicios(int numeroModulo) {
  if (!progressoProvider.moduloConcluido(numeroModulo)) {
    mostrarPopupConteudoBloqueado(
      context,
      nome: 'Exercícios do Módulo $numeroModulo',
      mensagem:
          'Conclua a lição do Módulo $numeroModulo '
          'na aba Início para liberar os exercícios '
          'livres deste conteúdo.',
    );
    return;
  }


    
      if (numeroModulo == 1) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const PraticaModulo1Screen(),
          ),
        );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Os exercícios deste módulo ainda não estão disponíveis.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF512B8B),
        toolbarHeight: 70,
        title: Text(
          'Exercícios',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          // CONTADOR DE VIDAS
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color(0xFFF44325),
                  size: 29,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    'Vidas: ${vidasProvider.vidas}/5',
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF35303C),
                    ),
                  ),
                ),

                Text(
                  'Prática livre',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF8127E8),
                  ),
                ),
              ],
            ),
          ),

          // DESCRIÇÃO DA TELA
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),
            child: Text(
              'Escolha um módulo para praticar os conteúdos que você já aprendeu.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF77768A),
              ),
            ),
          ),

          // LISTA DE MÓDULOS
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
              itemCount: modulos.length,
              itemBuilder: (context, index) {
                final modulo = modulos[index];
                final numeroModulo = index + 1;

                final desbloqueado =
                    progressoProvider.moduloConcluido(numeroModulo);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => abrirExercicios(numeroModulo),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: desbloqueado
                                ? const Color(0xFFD7B8FA)
                                : const Color(0xFFE8E3ED),
                          ),
                        ),
                        child: Row(
                          children: [
                            // ÍCONE DO MÓDULO
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: desbloqueado
                                    ? const Color(0xFFECE2FA)
                                    : const Color(0xFFF0EDF3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                desbloqueado
                                    ? Icons.menu_book_rounded
                                    : Icons.lock_outline_rounded,
                                color: desbloqueado
                                    ? const Color(0xFF8127E8)
                                    : const Color(0xFF99939F),
                                size: 30,
                              ),
                            ),

                            const SizedBox(width: 14),

                            // INFORMAÇÕES DO MÓDULO
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Módulo $numeroModulo',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF77768A),
                                    ),
                                  ),

                                  const SizedBox(height: 3),

                                  Text(
                                    modulo.titulo,
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF35303C),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    desbloqueado
                                        ? 'Disponível para praticar'
                                        : 'Conclua a lição para desbloquear',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: desbloqueado
                                          ? const Color(0xFF8127E8)
                                          : const Color(0xFF99939F),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 6),

                            // SETA OU CADEADO
                            Icon(
                              desbloqueado
                                  ? Icons.chevron_right_rounded
                                  : Icons.lock_rounded,
                              color: desbloqueado
                                  ? const Color(0xFF8127E8)
                                  : const Color(0xFF99939F),
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
