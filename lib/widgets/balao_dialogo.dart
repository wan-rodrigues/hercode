
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalaoDialogo extends StatefulWidget {
  final List<String> falas;
  final ValueChanged<bool> onFalando;
  final VoidCallback onFinalizado;

  const BalaoDialogo({
    super.key,
    required this.falas,
    required this.onFalando,
    required this.onFinalizado,
  });

  @override
  State<BalaoDialogo> createState() =>
      _BalaoDialogoState();
}

class _BalaoDialogoState extends State<BalaoDialogo> {
  int falaAtual = 0;
  int caracteresVisiveis = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) iniciarDigitacao();
    });
  }

  void iniciarDigitacao() {
    timer?.cancel();
    caracteresVisiveis = 0;
    widget.onFalando(true);

    timer = Timer.periodic(
      const Duration(milliseconds: 35),
      (_) {
        if (!mounted) return;

        final texto = widget.falas[falaAtual];

        if (caracteresVisiveis < texto.length) {
          setState(() {
            caracteresVisiveis++;
          });
        } else {
          timer?.cancel();
          widget.onFalando(false);
        }
      },
    );
  }

  void avancar() {
    final texto = widget.falas[falaAtual];

    // Primeiro toque: completa a frase.
    if (caracteresVisiveis < texto.length) {
      timer?.cancel();

      setState(() {
        caracteresVisiveis = texto.length;
      });

      widget.onFalando(false);
      return;
    }

    // Próximo toque: avança para a próxima fala.
    if (falaAtual < widget.falas.length - 1) {
      setState(() {
        falaAtual++;
        caracteresVisiveis = 0;
      });

      iniciarDigitacao();
    } else {
      widget.onFinalizado();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texto = widget.falas[falaAtual];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(falaAtual),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFECE2FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                texto.substring(0, caracteresVisiveis),
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1.5,
                  color: const Color(0xFF35303C),
                ),
              ),
            ),

            const SizedBox(height: 8),

            GestureDetector(
              onTap: avancar,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8127E8),
                      Color(0xFFF06ACB),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
