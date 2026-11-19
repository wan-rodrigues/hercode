
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/questoes_livres_modulo1.dart';
import '../logic/mecanica_licao.dart';
import '../main.dart' show progressoProvider, vidasProvider;
import '../widgets/popup_vida_recuperada.dart';

class PraticaModulo1Screen extends StatefulWidget {
  const PraticaModulo1Screen({super.key});

  @override
  State<PraticaModulo1Screen> createState() =>
      _PraticaModulo1ScreenState();
}

class _PraticaModulo1ScreenState
    extends State<PraticaModulo1Screen> {
  late final List<Questao> questoes;
  late List<Alternativa> alternativas;

  int indiceQuestao = 0;
  int acertosSessao = 0;

  String? respostaSelecionada;
  bool respondida = false;
  bool salvandoResposta = false;

  @override
  void initState() {
    super.initState();

    questoes = List<Questao>.of(questoesLivresModulo1)
      ..shuffle();

    prepararAlternativas();
  }

  Questao get questaoAtual => questoes[indiceQuestao];

  void prepararAlternativas() {
    alternativas = List<Alternativa>.of(
      questaoAtual.alternativas,
    )..shuffle();

    respostaSelecionada = null;
    respondida = false;
  }

  
  Future<void> selecionarResposta(String alternativaId) async {
    if (respondida || salvandoResposta) return;

    final correta =
        alternativaId == questaoAtual.respostaCorretaId;

    setState(() {
      salvandoResposta = true;
      respondida = true;
      respostaSelecionada = alternativaId;

      if (correta) {
        acertosSessao++;
      }
    });

    // Registra a resposta para pontuação e precisão.
    try {
      await progressoProvider.registrarResposta(
        correta: correta,
      );
    } catch (erro) {
      debugPrint('Erro ao salvar resposta: $erro');
    }

    if (!mounted) return;

    // Cada três acertos recuperam uma vida.
    if (correta) {
      final vidaRecuperada = vidasProvider.registrarAcertoLivre();

      if (vidaRecuperada) {
        await mostrarPopupVidaRecuperada(
          context,
          vidasAtuais: vidasProvider.vidas,
        );

        if (!mounted) return;
      }
    }

    setState(() {
      salvandoResposta = false;
    });
  }


  void proximaQuestao() {
    if (!respondida || salvandoResposta) return;

    if (indiceQuestao < questoes.length - 1) {
      setState(() {
        indiceQuestao++;
        prepararAlternativas();
      });
    } else {
      finalizarPratica();
    }
  }

  Future<void> finalizarPratica() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF7F1FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Prática finalizada!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF512B8B),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                size: 65,
                color: Color(0xFF8127E8),
              ),
              const SizedBox(height: 14),
              Text(
                'Você acertou $acertosSessao de '
                '${questoes.length} questões!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF35303C),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8127E8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Concluir',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Color corBorda(Alternativa alternativa) {
    if (!respondida) {
      return const Color(0xFFE4D7F1);
    }

    if (alternativa.id == questaoAtual.respostaCorretaId) {
      return const Color(0xFF29A66A);
    }

    if (alternativa.id == respostaSelecionada) {
      return const Color(0xFFE45B65);
    }

    return const Color(0xFFE4D7F1);
  }

  Color corFundo(Alternativa alternativa) {
    if (!respondida) return Colors.white;

    if (alternativa.id == questaoAtual.respostaCorretaId) {
      return const Color(0xFFE5F8EC);
    }

    if (alternativa.id == respostaSelecionada) {
      return const Color(0xFFFFE8EA);
    }

    return Colors.white;
  }

  
  Widget construirCardRecuperacao() {
    return AnimatedBuilder(
      animation: vidasProvider,
      builder: (context, _) {
        final vidasCompletas = vidasProvider.vidasCompletas;
        final acertos = vidasProvider.acertosParaVida;
        final faltantes = vidasProvider.acertosFaltantes;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFECE2FA),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFD7B8FA),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFF44325),
                    size: 27,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      vidasCompletas
                          ? 'Vidas completas!'
                          : 'Recupere uma vida',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF512B8B),
                      ),
                    ),
                  ),

                  Text(
                    vidasCompletas ? '5/5' : '$acertos/3',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8127E8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                vidasCompletas
                    ? 'Continue praticando para ganhar pontos!'
                    : 'Faltam $faltantes '
                        '${faltantes == 1 ? 'acerto' : 'acertos'} '
                        'para recuperar uma vida.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF77768A),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: List.generate(3, (index) {
                  final preenchido =
                      vidasCompletas || index < acertos;

                  return Expanded(
                    child: Container(
                      height: 9,
                      margin: EdgeInsets.only(
                        right: index < 2 ? 7 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: preenchido
                            ? const Color(0xFF8127E8)
                            : const Color(0xFFD3C0E8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final correta =
        respostaSelecionada == questaoAtual.respostaCorretaId;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF512B8B),
        foregroundColor: Colors.white,
        title: Text(
          'Prática — Módulo 1',
          style: GoogleFonts.poppins(
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questão ${indiceQuestao + 1} '
                'de ${questoes.length}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF512B8B),
                ),
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (indiceQuestao + 1) / questoes.length,
                  minHeight: 9,
                  backgroundColor: const Color(0xFFECE2FA),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF8127E8),
                  ),
                ),
              ),

              
            const SizedBox(height: 14),

            // INDICADOR DE ACERTOS PARA RECUPERAR UMA VIDA
            construirCardRecuperacao(),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          questaoAtual.enunciado,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF35303C),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      ...List.generate(
                        alternativas.length,
                        (index) {
                          final alternativa = alternativas[index];

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Material(
                              color: corFundo(alternativa),
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: respondida
                                    ? null
                                    : () => selecionarResposta(
                                          alternativa.id,
                                        ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: corBorda(alternativa),
                                      width: 1.5,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 34,
                                        height: 34,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFECE2FA),
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Text(
                                          String.fromCharCode(65 + index),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF512B8B),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: Text(
                                          alternativa.texto,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: const Color(0xFF35303C),
                                          ),
                                        ),
                                      ),

                                      if (respondida &&
                                          alternativa.id ==
                                              questaoAtual.respostaCorretaId)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF29A66A),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      if (respondida)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: correta
                                ? const Color(0xFFE5F8EC)
                                : const Color(0xFFFFE8EA),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            correta
                                ? 'Muito bem! Resposta correta!'
                                : 'Não foi dessa vez! '
                                  'A alternativa correta está destacada '
                                  'em verde.',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF35303C),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: respondida && !salvandoResposta
                      ? proximaQuestao
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8127E8),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFD7C9E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    indiceQuestao == questoes.length - 1
                        ? 'Finalizar prática'
                        : 'Próxima questão',
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
  }
}
