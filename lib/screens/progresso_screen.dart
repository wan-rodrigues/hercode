
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'configuracoes_screen.dart';

import '../main.dart' show progressoProvider;

class ProgressoScreen extends StatefulWidget {
  const ProgressoScreen({super.key});

  @override
  State<ProgressoScreen> createState() => _ProgressoScreenState();
}

class _ProgressoScreenState extends State<ProgressoScreen> {
  @override
  void initState() {
    super.initState();
    progressoProvider.addListener(atualizarTela);
  }

  void atualizarTela() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    progressoProvider.removeListener(atualizarTela);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int modulos = progressoProvider.totalModulosConcluidos;
    final int conquistas = progressoProvider.totalConquistas;
    final double progresso = progressoProvider.progressoGeral;

    final String precisao = progressoProvider.possuiTentativas
        ? '${progressoProvider.precisao.toStringAsFixed(1)}%'
        : 'Sem dados';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF512B8B),
        toolbarHeight: 70,
        title: Text(
          'Seu Progresso',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CARDS SUPERIORES
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,

              // Cards mais altos para acomodar as fontes maiores.
              childAspectRatio: 1.30,

              children: [
                _CardIndicador(
                  titulo: 'Pontuação Total',
                  valor: '${progressoProvider.pontuacaoTotal}',
                  icone: Icons.emoji_events_rounded,
                  cor: const Color(0xFFF1AE24),
                ),
                _CardIndicador(
                  titulo: 'Lições Completas',
                  valor: '$modulos',
                  icone: Icons.menu_book_rounded,
                  cor: const Color(0xFF9760E8),
                ),
                _CardIndicador(
                  titulo: 'Conquistas',
                  valor: '$conquistas/10',
                  icone: Icons.workspace_premium_rounded,
                  cor: const Color(0xFFF45C91),
                ),
                _CardIndicador(
                  titulo: 'Precisão',
                  valor: precisao,
                  icone: Icons.track_changes_rounded,
                  cor: const Color(0xFF51A2F5),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // PROGRESSO DOS MÓDULOS
            _CardProgresso(
              titulo: 'Módulos',
              subtitulo: '$modulos de 10 concluídos',
              percentual: progresso,
              icone: Icons.auto_stories_rounded,
              cor: const Color(0xFF8127E8),
            ),

            const SizedBox(height: 16),

            // PIONEIRAS DESCOBERTAS
            _CardProgresso(
              titulo: 'Pioneiras',
              subtitulo: '$conquistas de 10 descobertas',
              percentual: (conquistas / 10) * 100,
              icone: Icons.groups_rounded,
              cor: const Color(0xFF51A2F5),
            ),

            
            const SizedBox(height: 24),

            // ACESSO ÀS CONFIGURAÇÕES
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ConfiguracoesScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFECE2FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF8127E8),
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Configurações',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF35303C),
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'Preferências e dados do aplicativo',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF77768A),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF99939F),
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

// CARD DOS QUATRO INDICADORES SUPERIORES
class _CardIndicador extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;
  final Color cor;

  const _CardIndicador({
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icone,
            color: cor,
            size: 29,
          ),

          Text(
            titulo,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF77768A),
            ),
          ),

                    
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              valor,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF35303C),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

// CARD COM BARRA DE PROGRESSO
class _CardProgresso extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final double percentual;
  final IconData icone;
  final Color cor;

  const _CardProgresso({
    required this.titulo,
    required this.subtitulo,
    required this.percentual,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icone,
                color: cor,
                size: 24,
              ),

              const SizedBox(width: 10),

              Text(
                titulo,
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF35303C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            subtitulo,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: const Color(0xFF77768A),
            ),
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (percentual / 100).clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: const Color(0xFFECE2FA),
              valueColor: AlwaysStoppedAnimation<Color>(cor),
            ),
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${percentual.toStringAsFixed(0)}%',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: cor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
