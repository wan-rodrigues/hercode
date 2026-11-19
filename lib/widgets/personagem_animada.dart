
import 'dart:async';
import 'package:flutter/material.dart';

class PersonagemAnimada extends StatefulWidget {
  final bool falando;

  const PersonagemAnimada({
    super.key,
    required this.falando,
  });

  @override
  State<PersonagemAnimada> createState() =>
      _PersonagemAnimadaState();
}

class _PersonagemAnimadaState
    extends State<PersonagemAnimada> {
  int frameAtual = 0;
  Timer? timer;

  static const String pasta =
      'assets/personagens/';

  static const List<String> frames = [
    'Ada_falando1.png',
    'Ada_falando2.png',
    'Ada_falando3.png',
    'Ada_falando4.png',
  ];

  @override
  void initState() {
    super.initState();
    atualizarAnimacao();
  }

  @override
  void didUpdateWidget(PersonagemAnimada oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.falando != widget.falando) {
      atualizarAnimacao();
    }
  }

  void atualizarAnimacao() {
    timer?.cancel();

    if (widget.falando) {
      timer = Timer.periodic(
        const Duration(milliseconds: 160),
        (_) {
          if (!mounted) return;

          setState(() {
            frameAtual =
                (frameAtual + 1) % frames.length;
          });
        },
      );
    } else {
      setState(() {
        frameAtual = 0;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagem = widget.falando
        ? frames[frameAtual]
        : 'Ada.png';

    return SizedBox(
      width: 105,
      height: 105,
      child: ClipOval(
        child: ColoredBox(
          color: const Color(0xFFECE2FA),
          child: Image.asset(
            '$pasta$imagem',
            fit: BoxFit.contain,
            gaplessPlayback: true,
          ),
        ),
      ),
    );
  }
}
