
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TipoPopup {
  acerto,
  erro,
  vidasZeradas,
  moduloConcluido,
}

Future<void> mostrarPopupFeedback({
  required BuildContext context,
  required TipoPopup tipo,
  required VoidCallback onContinuar,
  VoidCallback? onVerConquistas,
  VoidCallback? onProximoModulo,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Mensagem do HerCode',
    barrierColor: Colors.black.withValues(alpha: 0.35),
    transitionDuration: const Duration(milliseconds: 450),

    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      void fecharEExecutar(VoidCallback? acao) {
        Navigator.of(dialogContext).pop();
        acao?.call();
      }

      return PopScope(
        canPop: tipo == TipoPopup.moduloConcluido,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 290,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F1FA),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF963DFF),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (tipo == TipoPopup.moduloConcluido)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () => fecharEExecutar(null),
                        icon: const Icon(Icons.close),
                        color: const Color(0xFF512B8B),
                      ),
                    ),

                  _IconeAnimado(tipo: tipo),

                  const SizedBox(height: 14),

                  Text(
                    _titulo(tipo),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 27,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF963DFF),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    _mensagem(tipo),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.5,
                      color: const Color(0xFF35303C),
                    ),
                  ),

                  const SizedBox(height: 26),

                  if (tipo == TipoPopup.moduloConcluido) ...[
                    _BotaoGradiente(
                      texto: 'Ver Conquistas',
                      onTap: () =>
                          fecharEExecutar(onVerConquistas),
                    ),
                    const SizedBox(height: 14),
                    _BotaoGradiente(
                      texto: 'Próximo Módulo',
                      onTap: () =>
                          fecharEExecutar(onProximoModulo),
                    ),
                  ] else
                    _BotaoGradiente(
                      texto: _textoBotao(tipo),
                      onTap: () => fecharEExecutar(onContinuar),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },

    transitionBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final progresso = Curves.easeOutBack.transform(
        animation.value.clamp(0.0, 1.0),
      );

      final escala = 0.8 + (0.2 * progresso);

      final tremor = tipo == TipoPopup.erro
          ? math.sin(animation.value * math.pi * 8) *
              (1 - animation.value) * 8
          : 0.0;

      return FadeTransition(
        opacity: animation,
        child: Transform.translate(
          offset: Offset(tremor, 0),
          child: Transform.scale(
            scale: escala,
            child: child,
          ),
        ),
      );
    },
  );
}

String _titulo(TipoPopup tipo) {
  switch (tipo) {
    case TipoPopup.acerto:
      return 'Certa\nResposta!';
    case TipoPopup.erro:
      return 'Você Errou';
    case TipoPopup.vidasZeradas:
      return 'Suas Vidas\nAcabaram';
    case TipoPopup.moduloConcluido:
      return 'Você Finalizou\num Módulo!';
  }
}

String _mensagem(TipoPopup tipo) {
  switch (tipo) {
    case TipoPopup.acerto:
      return 'Você tá arrasando hein!';
    case TipoPopup.erro:
      return 'Errar faz parte, continua tentando!';
    case TipoPopup.vidasZeradas:
      return 'Você pode conseguir mais vidas fazendo '
          'Exercícios Livres.';
    case TipoPopup.moduloConcluido:
      return 'Parabéns, é assim que se faz.\n'
          'Você acabou de desbloquear uma '
          'conquista pelo seu esforço!';
  }
}

String _textoBotao(TipoPopup tipo) {
  switch (tipo) {
    case TipoPopup.acerto:
      return 'Continuar';
    case TipoPopup.erro:
      return 'De novo!';
    case TipoPopup.vidasZeradas:
      return 'Bora!';
    case TipoPopup.moduloConcluido:
      return 'Ver Conquistas';
  }
}

class _IconeAnimado extends StatelessWidget {
  final TipoPopup tipo;

  const _IconeAnimado({required this.tipo});

  @override
  Widget build(BuildContext context) {
    String emoji;

    switch (tipo) {
      case TipoPopup.acerto:
        emoji = '🎉';
        break;
      case TipoPopup.erro:
        emoji = '🥺';
        break;
      case TipoPopup.vidasZeradas:
        emoji = '💔';
        break;
      case TipoPopup.moduloConcluido:
        emoji = '🏆';
        break;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.7, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, escala, child) {
        return Transform.scale(
          scale: escala,
          child: child,
        );
      },
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 88),
      ),
    );
  }
}

class _BotaoGradiente extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;

  const _BotaoGradiente({
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF8127E8),
                Color(0xFFF06ACB),
              ],
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            texto,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
