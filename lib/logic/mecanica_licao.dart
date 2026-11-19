
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../providers/vidas_provider.dart';

// Representa uma alternativa.
class Alternativa {
  final String id;
  final String texto;

  const Alternativa({
    required this.id,
    required this.texto,
  });
}

// Representa uma questão.
class Questao {
  final String enunciado;
  final List<Alternativa> alternativas;
  final String respostaCorretaId;

  const Questao({
    required this.enunciado,
    required this.alternativas,
    required this.respostaCorretaId,
  });
}

// Resultados possíveis de uma resposta.

enum ResultadoResposta {
  correta,
  incorreta,
  semVidas,
  ultimaVidaPerdida,
  jaRespondida,
}


class MecanicaLicao extends ChangeNotifier {
  final Random _random = Random();

  // Controlador compartilhado de vidas
  final VidasProvider vidasProvider;

  MecanicaLicao({
    required this.vidasProvider,
  });

  int pontos = 0;

  // Consulta o contador global
  int get vidas => vidasProvider.vidas;

  List<Alternativa> alternativasEmbaralhadas = [];

  Questao? questaoAtual;
  bool questaoConcluida = false;

  // Inicia uma questão.
  void iniciarQuestao(Questao questao) {
    questaoAtual = questao;
    questaoConcluida = false;

    alternativasEmbaralhadas =
        List.of(questao.alternativas);

    alternativasEmbaralhadas.shuffle(_random);

    notifyListeners();
  }

  // Verifica a resposta escolhida.
  ResultadoResposta responder(String alternativaId) {

    if (!vidasProvider.temVidas) {
      return ResultadoResposta.semVidas;
    }

    if (questaoAtual == null || questaoConcluida) {
      return ResultadoResposta.jaRespondida;
    }

    if (alternativaId ==
        questaoAtual!.respostaCorretaId) {
      pontos += 10;
      questaoConcluida = true;

      notifyListeners();

      return ResultadoResposta.correta;
    }

    // Perde uma vida do contador compartilhado
    vidasProvider.perderVida();

    notifyListeners();

    if (!vidasProvider.temVidas) {
      return ResultadoResposta.ultimaVidaPerdida;
    }

    return ResultadoResposta.incorreta;
  }

  // Reorganiza as alternativas após o pop-up.
  void embaralharAlternativas() {
    if (alternativasEmbaralhadas.length < 2) {
      return;
    }

    final ordemAnterior = alternativasEmbaralhadas
        .map((alternativa) => alternativa.id)
        .toList();

    do {
      alternativasEmbaralhadas.shuffle(_random);
    } while (listEquals(
      ordemAnterior,
      alternativasEmbaralhadas
          .map((alternativa) => alternativa.id)
          .toList(),
    ));

    notifyListeners();
  }
}
