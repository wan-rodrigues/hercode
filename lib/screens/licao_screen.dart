
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/personagem_animada.dart';
import '../widgets/balao_dialogo.dart';
import '../widgets/explicacao_logica.dart';
import '../data/questoes_modulo1.dart';
import '../logic/mecanica_licao.dart';
import '../widgets/exercicio_alternativas.dart';
import '../widgets/popup_feedback.dart';
import '../widgets/explicacao_python.dart';
import '../widgets/explicacao_erros_python.dart';
import '../widgets/explicacao_sequencia_python.dart';
import '../main.dart' show vidasProvider, progressoProvider;


  class LicaoScreen extends StatefulWidget {
    final ValueChanged<int>? onMudarAba;

    const LicaoScreen({
      super.key,
      this.onMudarAba,
    });

  @override
  State<LicaoScreen> createState() => _LicaoScreenState();

}

class _LicaoScreenState extends State<LicaoScreen> {
  bool adaFalando = false;
  bool introducaoConcluida = false;
  late final MecanicaLicao mecanica;
  bool mostrandoExercicio = false;
  bool dialogosPythonConcluidos = false;
  int etapaAtual = 0;

  final List<String> dialogos = [
    'Olá, me chamo Ada Lovelace. Eu fiquei responsável por te ensinar a primeira lição.',
    'Se não me conhece e ficou com curiosidade de saber quem eu sou, eu estou no Hall da Fama.',
    'Quando completar esse módulo você pode me conhecer melhor lá.',
    'Certo, vamos começar a aprender então.',
    'Você sabia que já domina a lógica de programação todos os dias, sem nem perceber?',
  ];

  final List<String> dialogosPython = [
  'Agora que você entendeu como organizar instruções, vamos conhecer uma linguagem de programação.',
  'Python é uma linguagem que podemos utilizar para transformar essas instruções em código.',
  'Vamos ver como isso funciona na prática?',
  ];

    @override
  void initState() {
    super.initState();

    mecanica = MecanicaLicao(
      vidasProvider: vidasProvider,
    );

    mecanica.addListener(atualizarTela);
  }

  void atualizarTela() {
    if (mounted) {
      setState(() {});
    }
  }

    @override
  void dispose() {
    mecanica.removeListener(atualizarTela);
    mecanica.dispose();
    super.dispose();
  }

  void abrirExercicio() {
  mecanica.iniciarQuestao(questaoPedidoComida);

  setState(() {
    mostrandoExercicio = true;
    etapaAtual = 2;
  });
}

  void avancarParaPython() {
  setState(() {
    etapaAtual = 3;
    mostrandoExercicio = false;
  });
}


void abrirExercicioPython() {
  mecanica.iniciarQuestao(questaoPythonPrint);

  setState(() {
    etapaAtual = 4;
    mostrandoExercicio = true;
  });
}


  void abrirExercicioErrosPython() {
    mecanica.iniciarQuestao(questaoEncontrarErro);

    setState(() {
      etapaAtual = 6;
      mostrandoExercicio = true;
    });
  }

  
  void abrirExercicioSequenciaPython() {
    mecanica.iniciarQuestao(questaoSequenciaPython);

    setState(() {
      etapaAtual = 8;
      mostrandoExercicio = true;
    });
  }
  
  
  
  
  
  Future<void> finalizarModulo() async {
    if (!mounted) return;

    
    await progressoProvider.concluirModulo(1);
    if (!mounted) return;

    setState(() {
      etapaAtual = 9;
      mostrandoExercicio = false;
    });

    String? destinoSelecionado;

    // Apresenta o pop-up de módulo concluído.
    await mostrarPopupFeedback(
      context: context,
      tipo: TipoPopup.moduloConcluido,
      onContinuar: () {},

      onVerConquistas: () {
        destinoSelecionado = 'conquistas';
      },

      onProximoModulo: () {
        destinoSelecionado = 'proximo';
      },
    );

        if (!mounted) return;

        if (destinoSelecionado == 'conquistas') {
          if (widget.onMudarAba != null) {
            Navigator.of(context).pop();
            widget.onMudarAba!(3);
          }
        } else if (destinoSelecionado == 'proximo') {
          Navigator.of(context).pop();
        }
      }


  Future<void> verificarResposta(
    ResultadoResposta resultado,
  ) async {
    switch (resultado) {
      
    case ResultadoResposta.correta:
      await progressoProvider.registrarResposta(
       correta: true,
      );

     if (!mounted) return;

      await mostrarPopupFeedback(
        context: context,
        tipo: TipoPopup.acerto,
        onContinuar: () {
          
        if (etapaAtual == 2) {
          avancarParaPython();
        } else if (etapaAtual == 4) {
          setState(() {
            etapaAtual = 5;
            mostrandoExercicio = false;
          });
        } else if (etapaAtual == 6) {
          setState(() {
            etapaAtual = 7;
            mostrandoExercicio = false;
          });
        } else if (etapaAtual == 8) {
            finalizarModulo();
        }

        },
      );
      break;
      
      case ResultadoResposta.incorreta:

      await progressoProvider.registrarResposta(
        correta: false,
      );

      if (!mounted) return;

        await mostrarPopupFeedback(
          context: context,
          tipo: TipoPopup.erro,
          onContinuar: () {
            mecanica.embaralharAlternativas();
          },
        );
        break;

      
      case ResultadoResposta.ultimaVidaPerdida:
        // A última resposta errada também conta como tentativa.
        await progressoProvider.registrarResposta(
          correta: false,
        );

        if (!mounted) return;

        await mostrarPopupFeedback(
          context: context,
          tipo: TipoPopup.vidasZeradas,
          onContinuar: () {
            Navigator.of(context).pop();
          },
        );

        break;


      case ResultadoResposta.semVidas:
        await mostrarPopupFeedback(
          context: context,
          tipo: TipoPopup.vidasZeradas,
          onContinuar: () {
            Navigator.of(context).pop();
          },
        );
        break;

      case ResultadoResposta.jaRespondida:
        return;
    }

    if (mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF512B8B),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color(0xFFF44325),
                ),
                const SizedBox(width: 6),
                Text(
                  '${mecanica.vidas}/5',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF35303C),
                  ),
                ),
              ],
            ),

          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Título da lição
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8127E8),
                      Color(0xFFF06ACB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Módulo 1: Introdução à Lógica',
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Ada e balão de fala
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonagemAnimada(
                    falando: adaFalando,
                  ),

                  const SizedBox(width: 8),

                  
                  
                Expanded(
                  child: BalaoDialogo(
                    // Reinicia o balão quando entramos na etapa de Python.
                    key: ValueKey(etapaAtual >= 3 ? 'python' : 'logica'),

                    // Seleciona os diálogos da etapa atual.
                    falas: etapaAtual >= 3
                        ? dialogosPython
                        : dialogos,

                    onFalando: (falando) {
                      if (mounted) {
                        setState(() {
                          adaFalando = falando;
                        });
                      }
                    },

                    onFinalizado: () {
                      if (!mounted) return;

                      setState(() {
                        adaFalando = false;

                        if (etapaAtual < 3) {
                          introducaoConcluida = true;
                          etapaAtual = 1;
                        } else if (etapaAtual == 3) {
                          dialogosPythonConcluidos = true;
                        }
                      });
                    },
                  ),
                ),


                ],
              ),

              const SizedBox(height: 14),

              // Área de conteúdo da lição
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECE2FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  
                  
                    
                
                
      child: introducaoConcluida
          ? SingleChildScrollView(
              
    child: etapaAtual == 7
        ? ExplicacaoSequenciaPython(
            onContinuar: abrirExercicioSequenciaPython,
          )
        : etapaAtual == 8
            ? ExercicioAlternativas(
                mecanica: mecanica,
                onResposta: verificarResposta,
              )
            : etapaAtual == 5
                ? ExplicacaoErrosPython(
                    onContinuar: abrirExercicioErrosPython,
                  )
                : etapaAtual == 6 || etapaAtual == 4
                    ? ExercicioAlternativas(
                        mecanica: mecanica,
                        onResposta: verificarResposta,
                      )
                    : etapaAtual == 3
                        ? dialogosPythonConcluidos
                            ? ExplicacaoPython(
                                onContinuar: abrirExercicioPython,
                              )
                            : const SizedBox.shrink()
                        : mostrandoExercicio
                            ? ExercicioAlternativas(
                                mecanica: mecanica,
                                onResposta: verificarResposta,
                              )
                            : ExplicacaoLogica(
                                onContinuar: abrirExercicio,
                              ),

                          )
                        : null,     
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
