
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplicacaoSequenciaPython extends StatelessWidget {
  final VoidCallback onContinuar;

  const ExplicacaoSequenciaPython({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organizando um programa',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Agora que você já conhece o comando print() '
          'e sabe identificar alguns erros, vamos '
          'organizar várias instruções em um programa.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'Imagine que queremos criar um programa '
          'que apresente uma mensagem de boas-vindas, '
          'explique o assunto e depois se despeça.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Veja um exemplo:',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF29243A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'print("Bom dia!")\n'
            'print("Hoje vamos estudar lógica.")\n'
            'print("Bons estudos!")',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.8,
              color: Color(0xFFE8CCFF),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'O Python executa essas instruções '
          'de cima para baixo.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 14),

        _PassoSequencia(
          numero: '1',
          titulo: 'Início',
          descricao: 'O programa cumprimenta a pessoa.',
        ),

        const SizedBox(height: 10),

        _PassoSequencia(
          numero: '2',
          titulo: 'Desenvolvimento',
          descricao: 'O programa apresenta o assunto.',
        ),

        const SizedBox(height: 10),

        _PassoSequencia(
          numero: '3',
          titulo: 'Encerramento',
          descricao: 'O programa se despede.',
        ),

        const SizedBox(height: 18),

        Text(
          'Organizar as instruções na sequência '
          'adequada ajuda a construir programas '
          'mais claros e coerentes.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Agora é sua vez! Organize um pequeno '
          'programa em Python.',
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

class _PassoSequencia extends StatelessWidget {
  final String numero;
  final String titulo;
  final String descricao;

  const _PassoSequencia({
    required this.numero,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFF8127E8),
            shape: BoxShape.circle,
          ),
          child: Text(
            numero,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF512B8B),
                ),
              ),
              Text(
                descricao,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  height: 1.5,
                  color: const Color(0xFF35303C),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
