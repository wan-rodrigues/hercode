
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HerCodeBottomNav extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const HerCodeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<HerCodeBottomNav> createState() =>
      _HerCodeBottomNavState();
}

class _HerCodeBottomNavState extends State<HerCodeBottomNav> {
  static const Color roxo = Color(0xFF512B8B);
  static const Color circulo = Color(0xFF8374D0);
  static const Color fundo = Color(0xFFF7F1FA);

  static const List<IconData> icones = [
    Icons.home_outlined,
    Icons.edit_note_outlined,
    Symbols.star_shine,
    Icons.emoji_events_outlined,
    Icons.bar_chart_outlined,
  ];

  static const List<String> nomes = [
    'Início',
    'Exercícios',
    'Hall da Fama',
    'Conquistas',
    'Progresso',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 76,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final larguraItem = constraints.maxWidth / 5;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Fundo roxo com curva animada
                Positioned.fill(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      end: (widget.selectedIndex + 0.5) / 5,
                    ),
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeInOutCubic,
                    builder: (context, posicao, child) {
                      return CustomPaint(
                        painter: CurvaMenuPainter(
                          posicao: posicao,
                          cor: roxo,
                          corFundo: fundo,
                        ),
                      );
                    },
                  ),
                ),

                // 2. Círculo que desliza
                AnimatedPositioned(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeInOutCubic,
                  left: larguraItem * widget.selectedIndex +
                      (larguraItem - 52) / 2,
                  top: -15,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: circulo,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: fundo,
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      icones[widget.selectedIndex],
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                ),

                // 3. Botões das cinco abas
                Row(
                  children: List.generate(5, (index) {
                    final selecionado =
                        widget.selectedIndex == index;

                    return Expanded(
                      child: InkWell(
                        onTap: () => widget.onTap(index),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),

                            if (selecionado)
                              const SizedBox(height: 25)
                            else
                              Icon(
                                icones[index],
                                color: Colors.white,
                                size: 29,
                              ),

                            const SizedBox(height: 5),

                            Text(
                              selecionado
                                  ? nomes[index]
                                  : '',
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// 4. Desenha o fundo e a curva do menu
class CurvaMenuPainter extends CustomPainter {
  final double posicao;
  final Color cor;
  final Color corFundo;

  CurvaMenuPainter({
    required this.posicao,
    required this.cor,
    required this.corFundo,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = cor
      ..style = PaintingStyle.fill;

    final centro = size.width * posicao;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(centro - 42, 0)

      // Curva esquerda
      ..cubicTo(
        centro - 30, 0,
        centro - 29, 17,
        centro, 17,
      )

      // Curva direita
      ..cubicTo(
        centro + 29, 17,
        centro + 30, 0,
        centro + 42, 0,
      )

      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Fundo que aparece no recorte
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CurvaMenuPainter oldDelegate) {
    return oldDelegate.posicao != posicao ||
        oldDelegate.cor != cor ||
        oldDelegate.corFundo != corFundo;
  }
}
