
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressoProvider extends ChangeNotifier {
  final Set<int> _modulosConcluidos = {};
  final Set<int> _conquistasVisualizadas = {};

  
  int _totalAcertos = 0;
  int _totalTentativas = 0;
  int _pontuacaoTotal = 0;

  int get totalAcertos => _totalAcertos;
  int get totalTentativas => _totalTentativas;
  int get pontuacaoTotal => _pontuacaoTotal;

  double get precisao {
    if (_totalTentativas == 0) return 0;

    return (_totalAcertos / _totalTentativas) * 100;
  }

  bool get possuiTentativas => _totalTentativas > 0;


  bool _carregado = false;

  bool get carregado => _carregado;

  bool moduloConcluido(int numeroModulo) {
    return _modulosConcluidos.contains(numeroModulo);
  }

  bool moduloDesbloqueado(int numeroModulo) {
    if (numeroModulo == 1) return true;

    return moduloConcluido(numeroModulo - 1);
  }

  int get totalModulosConcluidos {
    return _modulosConcluidos.length;
  }

  int get totalConquistas {
    return _modulosConcluidos.length;
  }

  double get progressoGeral {
    return (_modulosConcluidos.length / 10) * 100;
  }

  bool conquistaVisualizada(int numeroModulo) {
    return _conquistasVisualizadas.contains(numeroModulo);
  }

  // Carrega os dados que foram salvos no dispositivo.
  Future<void> carregarProgresso() async {
    final prefs = await SharedPreferences.getInstance();

    final modulosSalvos =
        prefs.getStringList('modulos_concluidos') ?? [];

    final conquistasSalvas =
        prefs.getStringList('conquistas_visualizadas') ?? [];

    _modulosConcluidos
      ..clear()
      ..addAll(
        modulosSalvos
            .map(int.tryParse)
            .whereType<int>()
            .where((numero) => numero >= 1 && numero <= 10),
      );

    _conquistasVisualizadas
      ..clear()
      ..addAll(
        conquistasSalvas
            .map(int.tryParse)
            .whereType<int>()
            .where((numero) => numero >= 1 && numero <= 10),
      );

      
  _totalAcertos = prefs.getInt('total_acertos') ?? 0;

  _totalTentativas = prefs.getInt('total_tentativas') ?? 0;

  _pontuacaoTotal = prefs.getInt('pontuacao_total') ?? 0;


    _carregado = true;
    notifyListeners();
  }

  // Registra a conclusão de um módulo.
  Future<void> concluirModulo(int numeroModulo) async {
    if (numeroModulo < 1 || numeroModulo > 10) return;

    if (_modulosConcluidos.add(numeroModulo)) {
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();

      await prefs.setStringList(
        'modulos_concluidos',
        _modulosConcluidos.map((numero) => numero.toString()).toList(),
      );
    }
  }

  // Registra que a participante já viu a recompensa.
  Future<void> marcarConquistaVisualizada(int numeroModulo) async {
    if (!_modulosConcluidos.contains(numeroModulo)) return;

    if (_conquistasVisualizadas.add(numeroModulo)) {
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();

      await prefs.setStringList(
        'conquistas_visualizadas',
        _conquistasVisualizadas
            .map((numero) => numero.toString())
            .toList(),
      );
    }
  }
  
  
  // Registra cada tentativa realizada nos exercícios.
  Future<void> registrarResposta({
    required bool correta,
  }) async {
    _totalTentativas++;

    if (correta) {
      _totalAcertos++;
      _pontuacaoTotal += 10;
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setInt('total_acertos', _totalAcertos),
      prefs.setInt('total_tentativas', _totalTentativas),
      prefs.setInt('pontuacao_total', _pontuacaoTotal),
    ]);
  }

  
  // Redefine todos os dados de aprendizagem.
  Future<void> redefinirProgresso() async {
    final prefs = await SharedPreferences.getInstance();

    // Apaga os dados salvos no dispositivo.
    await prefs.remove('modulos_concluidos');
    await prefs.remove('conquistas_visualizadas');
    await prefs.remove('total_acertos');
    await prefs.remove('total_tentativas');
    await prefs.remove('pontuacao_total');

    // Limpa os dados que estão na memória.
    _modulosConcluidos.clear();
    _conquistasVisualizadas.clear();

    _totalAcertos = 0;
    _totalTentativas = 0;
    _pontuacaoTotal = 0;

    notifyListeners();
  }



}
