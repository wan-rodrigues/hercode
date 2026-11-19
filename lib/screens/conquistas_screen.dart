
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart' show progressoProvider;
import '../widgets/popup_nova_pioneira.dart';
import '../widgets/popup_conteudo_bloqueado.dart';

class ConquistasScreen extends StatefulWidget {
  final VoidCallback? onAbrirHallDaFama;

  const ConquistasScreen({
    super.key,
    this.onAbrirHallDaFama,
  });

  @override
  State<ConquistasScreen> createState() =>
      _ConquistasScreenState();
}

class _ConquistasScreenState extends State<ConquistasScreen> {
  // LISTA DAS CONQUISTAS
  final List<Map<String, String>> conquistas = [
    {
      'titulo': 'Mente de Programadora',
      'pioneira': 'Ada',
    },
    {
      'titulo': 'Mestra do Passo a Passo',
      'pioneira': 'Katherine',
    },
    {
      'titulo': 'Inventário Desbloqueado',
      'pioneira': 'Grace',
    },
    {
      'titulo': 'Detetive de Dados',
      'pioneira': 'Jean',
    },
    {
      'titulo': 'Olá, Mundo',
      'pioneira': 'Radia',
    },
    {
      'titulo': 'Pensadora Lógica',
      'pioneira': 'Evelyn',
    },
    {
      'titulo': 'Escolha Seu Caminho',
      'pioneira': 'Margaret',
    },
    {
      'titulo': 'Farmando XP',
      'pioneira': 'Mary',
    },
    {
      'titulo': 'Combo de Sucesso',
      'pioneira': 'Frances',
    },
    {
      'titulo': 'Chefe Final Derrotado',
      'pioneira': 'Carol',
    },
  ];

  @override
  void initState() {
    super.initState();
    progressoProvider.addListener(atualizarConquistas);
  }

  void atualizarConquistas() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    progressoProvider.removeListener(atualizarConquistas);
    super.dispose();
  }

  // ABRIR UMA CONQUISTA
  Future<void> abrirConquista(int index) async {
    final bool desbloqueada =
        progressoProvider.moduloConcluido(index + 1);

    // CONQUISTA BLOQUEADA
    if (!desbloqueada) {
      await mostrarPopupConteudoBloqueado(
        context,
        nome: conquistas[index]['titulo']!,
        mensagem:
            'Esta conquista ainda está bloqueada. '
            'Complete o Módulo ${index + 1} '
            'para desbloqueá-la e descobrir '
            'uma nova pioneira da computação!',
      );
      return;
    }

    // CONQUISTA DESBLOQUEADA
    bool visitarHall = false;

    await mostrarPopupNovaPioneira(
      context,
      onVisitarHallDaFama: () {
        visitarHall = true;

        // Fecha o pop-up da conquista.
        Navigator.of(context).pop();
      },
    );

    if (!mounted) return;

    // Se a participante escolher visitar o Hall,
    // muda para a aba correspondente.
    if (visitarHall) {
      widget.onAbrirHallDaFama?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalDesbloqueadas =
        progressoProvider.totalConquistas;

    final int progresso =
        progressoProvider.progressoGeral.toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      // CABEÇALHO
      appBar: AppBar(
        backgroundColor: const Color(0xFF512B8B),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        titleSpacing: 16,
        title: Text(
          'Conquistas',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          // INDICADORES SUPERIORES
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _IndicadorConquista(
                    titulo: 'Conquistas Desbloqueadas',
                    icone: Icons.emoji_events_outlined,
                    valor: '$totalDesbloqueadas/10',
                    cor: const Color(0xFFF5AC21),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _IndicadorConquista(
                    titulo: 'Progresso',
                    icone: Icons.auto_awesome,
                    valor: '$progresso%',
                    cor: const Color(0xFF8127E8),
                  ),
                ),
              ],
            ),
          ),

          // GRADE DAS 10 CONQUISTAS
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                15,
                6,
                15,
                20,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 190,
              ),
              itemCount: conquistas.length,

              itemBuilder: (context, index) {
                final conquista = conquistas[index];

                final bool desbloqueada =
                    progressoProvider.moduloConcluido(index + 1);

                final String pioneira =
                    conquista['pioneira']!;

                // IMAGEM COLORIDA OU SILHUETA
                final String imagem = desbloqueada
                    ? 'assets/conquistas/desbloqueadas/'
                        '${pioneira}_Conquista.png'
                    : 'assets/conquistas/bloqueadas/'
                        '${pioneira}_block.png';

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    abrirConquista(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        // FIGURINHA
                        SizedBox(
                          height: 98,
                          width: double.infinity,
                          child: Image.asset(
                            imagem,
                            fit: BoxFit.contain,
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return const Icon(
                                Icons.image_not_supported_outlined,
                                color: Color(0xFFB8A0E5),
                                size: 40,
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // NOME DA CONQUISTA
                        Text(
                          conquista['titulo']!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: const Color(0xFF454453),
                          ),
                        ),

                        const Spacer(),

                        // MÓDULO CORRESPONDENTE
                        Text(
                          'Complete o Módulo ${index + 1}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF9998AB),
                          ),
                        ),
                      ],
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

// COMPONENTE DOS INDICADORES SUPERIORES
class _IndicadorConquista extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final String valor;
  final Color cor;

  const _IndicadorConquista({
    required this.titulo,
    required this.icone,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TÍTULO DO INDICADOR
          Text(
            titulo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: const Color(0xFF77768A),
            ),
          ),

          const SizedBox(height: 8),

          // ÍCONE E VALOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                color: cor,
                size: 26,
              ),

              const SizedBox(width: 8),

              Text(
                valor,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF8127E8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
