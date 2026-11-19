
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/explicacao_logica.dart';
import '../widgets/explicacao_python.dart';
import '../widgets/explicacao_erros_python.dart';
import '../widgets/explicacao_sequencia_python.dart';

class RevisaoModulo1Screen extends StatefulWidget {
  const RevisaoModulo1Screen({super.key});

  @override
  State<RevisaoModulo1Screen> createState() =>
      _RevisaoModulo1ScreenState();
}

class _RevisaoModulo1ScreenState
    extends State<RevisaoModulo1Screen> {
  int etapaAtual = 0;

  final ScrollController scrollController = ScrollController();

  final List<String> titulos = [
    'Lógica de Programação',
    'Introdução ao Python',
    'Erros de Sintaxe',
    'Organizando um Programa',
  ];

  void avancarEtapa() {
    if (etapaAtual < 3) {
      setState(() {
        etapaAtual++;
      });

      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  void voltarEtapa() {
    if (etapaAtual > 0) {
      setState(() {
        etapaAtual--;
      });

      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget construirConteudo() {
    switch (etapaAtual) {
      case 0:
        return ExplicacaoLogica(
          onContinuar: avancarEtapa,
        );

      case 1:
        return ExplicacaoPython(
          onContinuar: avancarEtapa,
        );

      case 2:
        return ExplicacaoErrosPython(
          onContinuar: avancarEtapa,
        );

      case 3:
        return ExplicacaoSequenciaPython(
          onContinuar: avancarEtapa,
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF512B8B),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: voltarEtapa,
        ),
        title: Text(
          'Revisão do Módulo 1',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // INDICADOR DE ETAPA
              Text(
                'Conteúdo ${etapaAtual + 1} de 4',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF77768A),
                ),
              ),

              const SizedBox(height: 8),

              LinearProgressIndicator(
                value: (etapaAtual + 1) / 4,
                minHeight: 7,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: const Color(0xFFECE2FA),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF8127E8),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                titulos[etapaAtual],
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF512B8B),
                ),
              ),

              const SizedBox(height: 14),

              // EXPLICAÇÕES REAPROVEITADAS
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECE2FA),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: construirConteudo(),
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
