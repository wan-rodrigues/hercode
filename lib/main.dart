
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/modulo_card.dart';
import 'data/modulos_data.dart';
import 'screens/licao_screen.dart';
import 'providers/vidas_provider.dart';
import 'providers/progresso_provider.dart';
import 'screens/principal_screen.dart';
import 'widgets/popup_modulo_concluido.dart';
import 'screens/revisao_modulo1_screen.dart';
import 'providers/perfil_provider.dart';
import 'screens/nickname_screen.dart';
import 'screens/tutorial_screen.dart';
import 'widgets/popup_conteudo_bloqueado.dart';

final vidasProvider = VidasProvider();
final progressoProvider = ProgressoProvider();
final perfilProvider = PerfilProvider();




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await progressoProvider.carregarProgresso();
  await vidasProvider.carregarVidas();
  await perfilProvider.carregarPerfil();

  runApp(const HerCodeApp());
}




class HerCodeApp extends StatefulWidget {
  const HerCodeApp({super.key});

  @override
  State<HerCodeApp> createState() => _HerCodeAppState();
}

class _HerCodeAppState extends State<HerCodeApp> {
  @override
  void initState() {
    super.initState();
    perfilProvider.addListener(atualizarApp);
  }

  void atualizarApp() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    perfilProvider.removeListener(atualizarApp);
    super.dispose();
  }

  Future<void> salvarNickname(String nickname) async {
    await perfilProvider.salvarNickname(nickname);
  }

  Future<void> finalizarTutorial() async {
  await perfilProvider.concluirTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HerCode',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F1FA),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),

      // Define a tela inicial conforme o perfil salvo.
      
      home: !perfilProvider.possuiNickname
          ? NicknameScreen(
              onContinuar: salvarNickname,)
          : !perfilProvider.tutorialConcluido
               ? TutorialScreen(
                nickname: perfilProvider.nickname,
                onConcluir: finalizarTutorial,)
        : const PrincipalScreen(),
      );
  }
}


  class ModulosScreen extends StatefulWidget {
    final ValueChanged<int>? onMudarAba;

    const ModulosScreen({
      super.key,
      this.onMudarAba,
    });

  @override
  State<ModulosScreen> createState() => _ModulosScreenState();
}

class _ModulosScreenState extends State<ModulosScreen> {
  
  @override
  void initState() {
    super.initState();
    progressoProvider.addListener(atualizarModulos);
  }

  void atualizarModulos() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    progressoProvider.removeListener(atualizarModulos);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF512B8B),
      toolbarHeight: 70,

      title: Text(
        'HerCode',
        style: GoogleFonts.poppins(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),

      actions: [

          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),

            
            
            child: AnimatedBuilder(
              animation: vidasProvider,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFF44325),
                      size: 25,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${vidasProvider.vidas}/5',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF303030),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: modulos.length,
        itemBuilder: (context, index) {
          final modulo = modulos[index];

          
      return ModuloCard(
        titulo: modulo.titulo,
        descricao: modulo.descricao,
        icone: modulo.icone,
        desbloqueado: progressoProvider.moduloDesbloqueado(index + 1),
        progresso: progressoProvider.moduloConcluido(index + 1)
            ? 1.0
            : modulo.progresso,
        
        onTap: () {
          final int numeroModulo = index + 1;

          
          if (!progressoProvider.moduloDesbloqueado(numeroModulo)) {
            mostrarPopupConteudoBloqueado(
              context,
              nome: modulo.titulo,
              mensagem:
                  'Conclua o Módulo ${numeroModulo - 1} '
                  'para desbloquear este conteúdo '
                  'e continuar sua jornada no HerCode!',
            );
            return;
          }


          if (progressoProvider.moduloConcluido(numeroModulo)) {
            mostrarPopupModuloConcluido(
              context,
              
            onRevisar: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const RevisaoModulo1Screen(),
                ),
              );
            },

              onRefazer: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LicaoScreen(
                      onMudarAba: widget.onMudarAba,
                    ),
                  ),
                );
              },
            );
            return;
          }

          // Primeira realização do módulo.
          if (numeroModulo == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LicaoScreen(
                  onMudarAba: widget.onMudarAba,
                ),
              ),
            );
          } else {
            // Os demais módulos ainda não têm lições implementadas.
            ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'A lição deste módulo será implementada em breve.',
        ),
      ),
    );
  }
},

          );
        },
      ),
    );
  }
}