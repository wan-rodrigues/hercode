
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/popup_pioneira_detalhes.dart';
import '../main.dart' show progressoProvider;
import '../widgets/popup_conteudo_bloqueado.dart';

class HallDaFamaScreen extends StatefulWidget {
  const HallDaFamaScreen({super.key});

  @override
  State<HallDaFamaScreen> createState() => _HallDaFamaScreenState();
}

class _HallDaFamaScreenState extends State<HallDaFamaScreen> {
  // Lista das pioneiras do HerCode.
  final List<Pioneira> pioneiras = const [
    Pioneira(
      nome: 'Ada Lovelace',
      periodo: '1815 - 1852',
      imagem: 'assets/hall_da_fama/AdaLovelace.png',
      modulo: 1,
      biografia: '''
Olá! Eu sou a Ada Lovelace.

Alguns me chamam de matemática, outros de escritora, mas você pode me chamar de a primeira programadora do mundo!

Há muito tempo, quando os computadores nem existiam de verdade, eu já imaginava como eles poderiam mudar o universo.

Enquanto a maioria das pessoas achava que as máquinas serviriam apenas para fazer contas matemáticas, eu vi que elas poderiam criar música, arte e processar qualquer tipo de informação!

Eu trabalhei lado a lado com meu amigo Charles Babbage em um projeto chamado Máquina Analítica. Foi lá que eu escrevi o que hoje conhecemos como o primeiro algoritmo da história: uma sequência de instruções que permitiria à máquina calcular números complexos sozinha.

Eu consegui provar que a tecnologia e a criatividade andam juntas.
''',
    ),
    Pioneira(
      nome: 'Katherine Johnson',
      periodo: '1918 - 2020',
      imagem: 'assets/hall_da_fama/KatherineJohnson.png',
      modulo: 2,
      biografia: '',
    ),
    Pioneira(
      nome: 'Grace Hopper',
      periodo: '1906 - 1992',
      imagem: 'assets/hall_da_fama/GraceHopper.png',
      modulo: 3,
      biografia: '',
    ),
    Pioneira(
      nome: 'Jean Sammet',
      periodo: '1928 - 2017',
      imagem: 'assets/hall_da_fama/JeanSammet.png',
      modulo: 4,
      biografia: '',
    ),
    Pioneira(
      nome: 'Radia Perlman',
      periodo: '1951 - Presente',
      imagem: 'assets/hall_da_fama/RadiaPerlman.png',
      modulo: 5,
      biografia: '',
    ),
    Pioneira(
      nome: 'Evelyn Boyd Granville',
      periodo: '1924 - 2023',
      imagem: 'assets/hall_da_fama/EvelynBoyd.png',
      modulo: 6,
      biografia: '',
    ),
    Pioneira(
      nome: 'Margaret Hamilton',
      periodo: '1936 - Presente',
      imagem: 'assets/hall_da_fama/MargaretHamilton.png',
      modulo: 7,
      biografia: '',
    ),
    Pioneira(
      nome: 'Mary Allen Wilkes',
      periodo: '1937 - Presente',
      imagem: 'assets/hall_da_fama/MaryAllen.png',
      modulo: 8,
      biografia: '',
    ),
    Pioneira(
      nome: 'Frances E. Allen',
      periodo: '1932 - 2020',
      imagem: 'assets/hall_da_fama/FrancesAllen.png',
      modulo: 9,
      biografia: '',
    ),
    Pioneira(
      nome: 'Carol Shaw',
      periodo: '1955 - Presente',
      imagem: 'assets/hall_da_fama/CarolShaw.png',
      modulo: 10,
      biografia: '',
    ),
  ];

  // Cores dos cards bloqueados.
  final List<Color> coresBloqueadas = const [
    Color(0xFFE0CDF9),
    Color(0xFFFFD1C4),
    Color(0xFFFFF0BE),
    Color(0xFFB0DEFF),
    Color(0xFFE5FFDD),
  ];

  @override
  void initState() {
    super.initState();
    progressoProvider.addListener(atualizarHall);
  }

  void atualizarHall() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    progressoProvider.removeListener(atualizarHall);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int totalDesbloqueadas =
        progressoProvider.totalModulosConcluidos;

    final int progresso = (totalDesbloqueadas * 100) ~/ 10;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      // CABEÇALHO
      appBar: AppBar(
        backgroundColor: const Color(0xFF512B8B),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        titleSpacing: 16,
        title: Text(
          'Hall da Fama',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        children: [
          // INDICADORES SUPERIORES
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: _IndicadorHall(
                    titulo: 'Pioneiras Desbloqueadas',
                    icone: Icons.person_outline,
                    valor: '$totalDesbloqueadas/10',
                    cor: const Color(0xFF38B6FF),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _IndicadorHall(
                    titulo: 'Progresso',
                    icone: Icons.auto_awesome,
                    valor: '$progresso%',
                    cor: const Color(0xFF8127E8),
                  ),
                ),
              ],
            ),
          ),

          // GRADE COM AS 10 PIONEIRAS
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
              itemCount: pioneiras.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 210,
              ),

              itemBuilder: (context, index) {
                final Pioneira pioneira = pioneiras[index];

                final bool desbloqueada =
                    progressoProvider.moduloConcluido(index + 1);

                final Color corBloqueada = coresBloqueadas[
                    index % coresBloqueadas.length];

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    if (desbloqueada) {
                      mostrarPopupPioneiraDetalhes(
                        context,
                        pioneira: pioneira,
                      );
                    
                    } else {
                      mostrarPopupConteudoBloqueado(
                        context,
                        nome: pioneira.nome,
                        mensagem:
                            'Esta pioneira ainda está bloqueada. '
                            'Conclua o Módulo ${pioneira.modulo} '
                            'para conhecer sua história no Hall da Fama!',
                      );
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FOTO OU CADEADO
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: desbloqueada
                                ? Image.asset(
                                    pioneira.imagem,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {
                                      return const Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: corBloqueada,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.lock_outline,
                                      size: 34,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // NOME DA PIONEIRA
                        Text(
                          pioneira.nome,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: const Color(0xFF454453),
                          ),
                        ),

                        const SizedBox(height: 5),

                        // PERÍODO DE VIDA
                        Text(
                          pioneira.periodo,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF9998AB),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// COMPONENTE DOS INDICADORES SUPERIORES
class _IndicadorHall extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final String valor;
  final Color cor;

  const _IndicadorHall({
    required this.titulo,
    required this.icone,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TÍTULO DO INDICADOR
          Text(
            titulo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.25,
              color: const Color(0xFF77768A),
            ),
          ),

          const SizedBox(height: 8),

          // ÍCONE E VALOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                color: cor,
                size: 26,
              ),

              const SizedBox(width: 8),

              Text(
                valor,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF8127E8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
