
import 'package:flutter/material.dart';

import '../main.dart' show ModulosScreen;
import '../widgets/hercode_bottom_nav.dart';

import 'hall_da_fama_screen.dart';
import 'conquistas_screen.dart';
import 'progresso_screen.dart';
import 'exercicios_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() =>
      _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  // Controla qual aba está selecionada.
  int abaSelecionada = 0;

  void mudarAba(int index) {
    if (index == abaSelecionada) return;

    setState(() {
      abaSelecionada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1FA),

      // Mantém as telas carregadas.
      body: IndexedStack(
        index: abaSelecionada,
        children: [
          ModulosScreen(
            onMudarAba: mudarAba,
          ),

          // 1 - Exercícios
          const ExerciciosScreen(),

          // 2 - Hall da Fama
          HallDaFamaScreen(),

          // 3 - Conquistas
        ConquistasScreen(
          onAbrirHallDaFama: () {
            mudarAba(2);
          },
        ),
        
          // 4 - Progresso
          const ProgressoScreen(),

        ],
      ),

      // Uma única barra para todas as telas.
      bottomNavigationBar: HerCodeBottomNav(
        selectedIndex: abaSelecionada,
        onTap: mudarAba,
      ),
    );
  }
}

