
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplicacaoLogica extends StatelessWidget {
  final VoidCallback onContinuar;

  const ExplicacaoLogica({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'O que é lógica de programação?',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF512B8B),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Lógica de programação é a capacidade de '
          'organizar instruções em uma sequência '
          'para resolver um problema.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            height: 1.6,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 20),

        // Exemplo contextualizado
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFDAB5FF),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF963DFF),
                    size: 26,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Exemplo: Caixa eletrônico',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF512B8B),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                'Imagine que você precisa sacar dinheiro '
                'em um caixa eletrônico.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 12),

              ...[
                'Inserir ou aproximar o cartão.',
                'Informar a senha.',
                'Selecionar a opção de saque.',
                'Digitar o valor desejado.',
                'Confirmar a operação.',
              ].asMap().entries.map((etapa) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            const Color(0xFFECE2FA),
                        child: Text(
                          '${etapa.key + 1}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF512B8B),
                          ),
                        ),
                      ),

                      const SizedBox(width: 9),

                      Expanded(
                        child: Text(
                          etapa.value,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Percebeu? Cada etapa precisa acontecer '
          'em uma ordem lógica para que o objetivo '
          'seja alcançado.',
          style: GoogleFonts.poppins(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xFF35303C),
          ),
        ),

        const SizedBox(height: 20),

        // Botão de avanço
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
