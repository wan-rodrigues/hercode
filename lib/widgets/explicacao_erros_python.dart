
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplicacaoErrosPython extends StatelessWidget {
  final VoidCallback onContinuar;

  const ExplicacaoErrosPython({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Encontrando erros no código',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Quando escrevemos um programa, precisamos '
          'seguir algumas regras da linguagem de programação.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Em Python, um erro de sintaxe acontece quando '
          'escrevemos uma instrução que não segue essas regras.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Observe este exemplo:',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 12),

        // Exemplo correto
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF32966B),
              size: 21,
            ),
            const SizedBox(width: 8),
            Text(
              'Código correto',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

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
              fontSize: 14,
              color: Color(0xFFE8CCFF),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // Exemplo com erro
        Row(
          children: [
            const Icon(
              Icons.cancel,
              color: Color(0xFFE45D73),
              size: 21,
            ),
            const SizedBox(width: 8),
            Text(
              'Código com erro',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF29243A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'print("Olá, mundo!"',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Color(0xFFE8CCFF),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Percebeu a diferença? No segundo exemplo, '
          'está faltando o parêntese de fechamento ). '
          'Por isso, o Python não consegue interpretar '
          'a instrução corretamente.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Agora é sua vez de identificar qual comando '
          'está escrito corretamente!',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
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
