
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilProvider extends ChangeNotifier {
  String _nickname = '';
  bool _tutorialConcluido = false;

  // Informações disponíveis para as telas.
  String get nickname => _nickname;
  bool get tutorialConcluido => _tutorialConcluido;

  // Verifica se a participante já escolheu um nome.
  bool get possuiNickname => _nickname.trim().isNotEmpty;

  // Carrega os dados salvos no dispositivo.
  Future<void> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    _nickname = prefs.getString('hercode_nickname') ?? '';
    _tutorialConcluido =
        prefs.getBool('hercode_tutorial_concluido') ?? false;

    notifyListeners();
  }

  // Salva ou altera o nickname.
  Future<void> salvarNickname(String nome) async {
    final nicknameFormatado = nome.trim();

    if (nicknameFormatado.isEmpty) return;

    _nickname = nicknameFormatado;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'hercode_nickname',
      _nickname,
    );
  }

  // Registra que o tutorial já foi apresentado.
  Future<void> concluirTutorial() async {
    _tutorialConcluido = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(
      'hercode_tutorial_concluido',
      true,
    );
  }

  // Será utilizado futuramente na opção Redefinir aplicativo.
  Future<void> redefinirPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('hercode_nickname');
    await prefs.remove('hercode_tutorial_concluido');

    _nickname = '';
    _tutorialConcluido = false;

    notifyListeners();
  }
}
