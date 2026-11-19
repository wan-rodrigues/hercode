
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VidasProvider extends ChangeNotifier {
  static const int maxVidas = 5;
  static const int acertosPorVida = 3;

  int _vidas = maxVidas;
  int _acertosParaVida = 0;

  // Informações disponíveis para as telas.
  int get vidas => _vidas;
  bool get temVidas => _vidas > 0;

  int get acertosParaVida => _acertosParaVida;

  int get acertosFaltantes =>
      acertosPorVida - _acertosParaVida;

  bool get vidasCompletas => _vidas >= maxVidas;

  // Recupera as vidas e os acertos salvos no dispositivo.
  Future<void> carregarVidas() async {
    final prefs = await SharedPreferences.getInstance();

    _vidas = (prefs.getInt('vidas_atuais') ?? maxVidas)
        .clamp(0, maxVidas);

    _acertosParaVida =
        (prefs.getInt('acertos_para_vida') ?? 0)
            .clamp(0, acertosPorVida - 1);

    if (vidasCompletas) {
      _acertosParaVida = 0;
    }

    notifyListeners();
  }

  // Salva as informações no dispositivo.
  Future<void> salvarVidas() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('vidas_atuais', _vidas);
    await prefs.setInt(
      'acertos_para_vida',
      _acertosParaVida,
    );
  }

  // Desconta uma vida nas lições.
  void perderVida() {
    if (_vidas > 0) {
      _vidas--;
      notifyListeners();
      salvarVidas();
    }
  }

  // Recupera uma vida sem ultrapassar o limite.
  void recuperarVida() {
    if (_vidas < maxVidas) {
      _vidas++;
      notifyListeners();
      salvarVidas();
    }
  }

  // Registra um acerto nos exercícios livres.
  // Retorna true quando uma vida é recuperada.
  bool registrarAcertoLivre() {
    if (vidasCompletas) {
      return false;
    }

    _acertosParaVida++;

    if (_acertosParaVida >= acertosPorVida) {
      _acertosParaVida = 0;
      _vidas++;

      notifyListeners();
      salvarVidas();

      return true;
    }

    notifyListeners();
    salvarVidas();

    return false;
  }

  // Recupera todas as vidas.
  void restaurarVidas() {
    _vidas = maxVidas;
    _acertosParaVida = 0;

    notifyListeners();
    salvarVidas();
  }

  
  // Redefine as vidas e os acertos acumulados
  // para o estado de primeiro acesso.
  Future<void> redefinirVidas() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove os valores armazenados no dispositivo.
    await prefs.remove('vidas_atuais');
    await prefs.remove('acertos_para_vida');

    // Restaura os valores iniciais na memória.
    _vidas = maxVidas;
    _acertosParaVida = 0;

    notifyListeners();
  }


}
