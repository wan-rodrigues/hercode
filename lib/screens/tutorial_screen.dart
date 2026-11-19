
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialScreen extends StatefulWidget {
  final String nickname;
  final Future<void> Function() onConcluir;

  const TutorialScreen({
    super.key,
    required this.nickname,
    required this.onConcluir,
  });

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();

  int _paginaAtual = 0;
  bool _finalizando = false;

  static const Color roxo = Color(0xFF8127E8);
  static const Color roxoEscuro = Color(0xFF512B8B);

  late final List<_PaginaTutorial> paginas = [
    _PaginaTutorial(
      icone: Icons.waving_hand_rounded,
      titulo: 'Boas-vindas ao HerCode!',
      descricao:
          'Olá, ${widget.nickname}! '
          'Aqui você vai desenvolver suas habilidades '
          'em programação, um passo de cada vez.',
    ),
    const _PaginaTutorial(
      icone: Icons.menu_book_rounded,
      titulo: 'Aprenda e pratique',
      descricao:
          'Na aba Início, explore os módulos e aprenda '
          'novos conceitos. Depois, visite Exercícios '
          'para praticar os conteúdos que já estudou.',
    ),
    const _PaginaTutorial(
      icone: Icons.favorite_rounded,
      titulo: 'Vidas e conquistas',
      descricao:
          'As vidas são usadas nas lições. '
          'Se precisar recuperá-las, pratique nos '
          'Exercícios Livres: a cada três acertos, '
          'você recupera uma vida. '
          'Ao concluir módulos, desbloqueia conquistas!',
    ),
    const _PaginaTutorial(
      icone: Icons.emoji_events_rounded,
      titulo: 'Descubra sua evolução',
      descricao:
          'No Hall da Fama, conheça mulheres que '
          'marcaram a história da computação. '
          'Em Conquistas, acompanhe suas recompensas. '
          'Na aba Progresso, veja seus pontos e desempenho.',
    ),
  ];

  void _avancar() {
    if (_paginaAtual < paginas.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _concluirTutorial();
    }
  }

  Future<void> _concluirTutorial() async {
    if (_finalizando) return;

    setState(() {
      _finalizando = true;
    });

    try {
      await widget.onConcluir();
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não foi possível finalizar o tutorial. '
            'Tente novamente.',
          ),
        ),
      );

      setState(() {
        _finalizando = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ultimaPagina = _paginaAtual == paginas.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // CABEÇALHO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HerCode',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: roxoEscuro,
                    ),
                  ),

                  Text(
                    '${_paginaAtual + 1}/${paginas.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: roxo,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // PÁGINAS DO TUTORIAL
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: paginas.length,
                  onPageChanged: (index) {
                    setState(() {
                      _paginaAtual = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final pagina = paginas[index];

                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 145,
                              height: 145,
                              decoration: const BoxDecoration(
                                color: Color(0xFFECE2FA),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                pagina.icone,
                                size: 75,
                                color: roxo,
                              ),
                            ),

                            const SizedBox(height: 35),

                            Text(
                              pagina.titulo,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: roxoEscuro,
                              ),
                            ),

                            const SizedBox(height: 18),

                            Text(
                              pagina.descricao,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                height: 1.6,
                                color: const Color(0xFF77768A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // INDICADORES DAS PÁGINAS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  paginas.length,
                  (index) {
                    final selecionada = index == _paginaAtual;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: selecionada ? 26 : 9,
                      height: 9,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: selecionada
                            ? roxo
                            : const Color(0xFFD7C9E8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // BOTÃO PRINCIPAL
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _finalizando ? null : _avancar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: roxo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _finalizando
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          ultimaPagina
                              ? 'Começar minha jornada!'
                              : 'Continuar',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              // VOLTAR PARA A PÁGINA ANTERIOR
              SizedBox(
                height: 42,
                child: _paginaAtual > 0
                    ? TextButton(
                        onPressed: _finalizando
                            ? null
                            : () {
                                _pageController.previousPage(
                                  duration: const Duration(
                                    milliseconds: 350,
                                  ),
                                  curve: Curves.easeInOut,
                                );
                              },
                        child: Text(
                          'Voltar',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: roxoEscuro,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MODELO DOS DADOS DE CADA PÁGINA
class _PaginaTutorial {
  final IconData icone;
  final String titulo;
  final String descricao;

  const _PaginaTutorial({
    required this.icone,
    required this.titulo,
    required this.descricao,
  });
}
