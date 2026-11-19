
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart'
    show perfilProvider, progressoProvider, vidasProvider;

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  static const Color roxo = Color(0xFF8127E8);
  static const Color roxoEscuro = Color(0xFF512B8B);

  void mostrarEmBreve(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Essa funcionalidade será implementada em breve.',
        ),
      ),
    );
  }

  
  Future<void> alterarNickname(BuildContext context) async {
    final controller = TextEditingController(
      text: perfilProvider.nickname,
    );

    bool salvando = false;

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, setStateDialogo) {
              Future<void> salvar() async {
                if (salvando) return;

                final nome = controller.text.trim();

                if (nome.length < 3 || nome.length > 16) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'O nickname deve ter entre 3 e 16 caracteres.',
                      ),
                    ),
                  );
                  return;
                }

                if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(nome)) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Use apenas letras, números e _.',
                      ),
                    ),
                  );
                  return;
                }

                setStateDialogo(() {
                  salvando = true;
                });

                try {
                  await perfilProvider.salvarNickname(nome);

                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop();
                  }
                } catch (erro) {
                  if (dialogContext.mounted) {
                    setStateDialogo(() {
                      salvando = false;
                    });

                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Não foi possível salvar o nickname.',
                        ),
                      ),
                    );
                  }
                }
              }

              return AlertDialog(
                backgroundColor: const Color(0xFFF7F1FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                title: Text(
                  'Alterar nickname',
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: roxoEscuro,
                  ),
                ),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                  maxLength: 16,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => salvar(),
                  decoration: InputDecoration(
                    labelText: 'Novo nickname',
                    hintText: 'Ex.: CodeExplorer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: roxo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: salvando
                        ? null
                        : () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      'Cancelar',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF77768A),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: salvando ? null : salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: roxo,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      salvando ? 'Salvando...' : 'Salvar',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    } finally {
      // Aguarda o fechamento da animação do diálogo antes
      // de liberar o controlador de texto.
      await Future<void>.delayed(
        const Duration(milliseconds: 300),
      );
      controller.dispose();
    }
  }

  
Future<void> redefinirAplicativo(BuildContext context) async {
  // Solicita confirmação antes de apagar os dados.
  final bool? confirmou = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: const Color(0xFFF7F1FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFE45B65),
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Redefinir HerCode?',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: roxoEscuro,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Todos os dados salvos neste dispositivo '
          'serão apagados.\n\n'
          'Isso inclui nickname, módulos concluídos, '
          'conquistas, pontuação, vidas e preferências.\n\n'
          'O aplicativo voltará ao primeiro acesso. '
          'Essa ação não poderá ser desfeita.',
          style: GoogleFonts.poppins(
            fontSize: 15,
            height: 1.5,
            color: const Color(0xFF35303C),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false);
            },
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF77768A),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE45B65),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Redefinir',
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

  // Se cancelar ou fechar o diálogo, não faz nada.
  if (confirmou != true || !context.mounted) return;

  // Exibe o indicador enquanto os dados são apagados.
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF8127E8),
        ),
      );
    },
  );

  try {
    // 1. Apaga progresso, conquistas e pontuação.
    await progressoProvider.redefinirProgresso();

    // 2. Restaura as vidas e o contador de acertos.
    await vidasProvider.redefinirVidas();

    if (!context.mounted) return;

    // Fecha o indicador de carregamento.
    Navigator.of(context).pop();

    // Volta à rota principal, fechando Configurações.
    Navigator.of(context).popUntil(
      (route) => route.isFirst,
    );

    // 3. Apaga nickname e tutorial.
    // O HerCodeApp detectará a alteração e abrirá
    // automaticamente a tela de primeiro acesso.
    await perfilProvider.redefinirPerfil();
  } catch (erro) {
    debugPrint('Erro ao redefinir HerCode: $erro');

    if (!context.mounted) return;

    // Fecha o indicador caso ainda esteja aberto.
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Não foi possível concluir a redefinição.',
        ),
      ),
    );
  }
}



  void mostrarSobre(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF7F1FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Sobre o HerCode',
            style: GoogleFonts.poppins(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: roxoEscuro,
            ),
          ),
          content: Text(
            'HerCode é um aplicativo educacional gamificado '
            'para apoiar a aprendizagem de lógica de programação '
            'e valorizar as contribuições de mulheres '
            'para a história da computação.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              height: 1.5,
              color: const Color(0xFF35303C),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Fechar',
                style: GoogleFonts.poppins(
                  color: roxo,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),
      appBar: AppBar(
        backgroundColor: roxoEscuro,
        foregroundColor: Colors.white,
        toolbarHeight: 70,
        title: Text(
          'Configurações',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // PERFIL
          const _TituloSecao(titulo: 'PERFIL'),

          const SizedBox(height: 10),

          AnimatedBuilder(
            animation: perfilProvider,
            builder: (context, _) {
              return _OpcaoConfiguracao(
                icone: Icons.person_outline_rounded,
                titulo: 'Nome de usuário',
                subtitulo: perfilProvider.nickname,
                corIcone: roxo,
                onTap: () => alterarNickname(context),
              );
            },
          ),

          const SizedBox(height: 25),

          // DADOS DO APLICATIVO
          const _TituloSecao(
            titulo: 'DADOS DO APLICATIVO',
          ),

          const SizedBox(height: 10),

          _OpcaoConfiguracao(
            icone: Icons.restart_alt_rounded,
            titulo: 'Redefinir aplicativo',
            subtitulo: 'Recomeçar como no primeiro acesso',
            corIcone: const Color(0xFFE45B65),
            onTap: () => redefinirAplicativo(context),
          ),

          const SizedBox(height: 25),

          // SOBRE
          const _TituloSecao(titulo: 'SOBRE'),

          const SizedBox(height: 10),

          _OpcaoConfiguracao(
            icone: Icons.info_outline_rounded,
            titulo: 'Sobre o HerCode',
            subtitulo: 'Informações sobre o aplicativo',
            corIcone: roxo,
            onTap: () => mostrarSobre(context),
          ),
        ],
      ),
    );
  }
}

class _TituloSecao extends StatelessWidget {
  final String titulo;

  const _TituloSecao({
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF77768A),
      ),
    );
  }
}

class _OpcaoConfiguracao extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;
  final Color corIcone;
  final VoidCallback onTap;

  const _OpcaoConfiguracao({
    required this.icone,
    required this.titulo,
    required this.subtitulo,
    required this.corIcone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: corIcone.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icone,
                  color: corIcone,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF35303C),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitulo,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF77768A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF99939F),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
