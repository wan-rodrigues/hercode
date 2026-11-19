
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplicacaoPython extends StatelessWidget {
  final VoidCallback onContinuar;

  const ExplicacaoPython({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conhecendo o Python',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Python é uma linguagem de programação '
          'que permite escrever instruções para '
          'o computador executar.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Vamos começar com um exemplo simples:',
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 10),

        // Exemplo de código
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF29243A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'print("Olá, mundo!")',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              color: Color(0xFFE8CCFF),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'O comando print() é utilizado para '
          'mostrar uma mensagem na tela.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Assim como no exemplo do caixa eletrônico, '
          'um programa pode executar várias instruções '
          'em sequência.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF29243A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'print("Primeiro passo")\n'
            'print("Segundo passo")\n'
            'print("Terceiro passo")',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.8,
              color: Color(0xFFE8CCFF),
            ),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'O computador executa essas instruções '
          'na ordem em que aparecem, de cima para baixo.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinuar,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8127E8),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Continuar',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
