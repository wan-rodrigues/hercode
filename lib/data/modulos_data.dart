
import 'package:flutter/material.dart';

class Modulo {
  final String titulo;
  final String descricao;
  final IconData icone;
  final bool desbloqueado;
  final double progresso;

  const Modulo({
    required this.titulo,
    required this.descricao,
    required this.icone,
    this.desbloqueado = false,
    this.progresso = 0,
  });
}

const List<Modulo> modulos = [
  Modulo(
    titulo: 'Introdução à Lógica',
    descricao:
        'Entenda como o computador pensa e como organizar suas ideias para criar programas.',
    icone: Icons.smart_toy_outlined,
    desbloqueado: true,
  ),
  Modulo(
    titulo: 'Algoritmos e Sequência',
    descricao:
        'Aprenda a criar receitas passo a passo para o computador executar tarefas.',
    icone: Icons.account_tree_outlined,
  ),
  Modulo(
    titulo: 'Variáveis',
    descricao:
        'Descubra como criar espaços para guardar informações dentro do seu código.',
    icone: Icons.inventory_2_outlined,
  ),
  Modulo(
    titulo: 'Tipos de Informação',
    descricao:
        'Entenda as diferenças entre textos, números e outros dados que o computador usa.',
    icone: Icons.check_box_outlined,
  ),
  Modulo(
    titulo: 'Entrada e Saída',
    descricao:
        'Aprenda como o usuário envia dados para o programa e recebe informações de volta.',
    icone: Icons.desktop_windows_outlined,
  ),
  Modulo(
    titulo: 'Operadores e Comparações',
    descricao:
        'Aprenda a fazer cálculos e comparar se um valor é maior ou igual a outro.',
    icone: Icons.calculate_outlined,
  ),
  Modulo(
    titulo: 'Estruturas Condicionais',
    descricao:
        'Ensine seu programa a tomar decisões usando regras do tipo se e senão.',
    icone: Icons.rule,
  ),
  Modulo(
    titulo: 'Repetições',
    descricao:
        'Economize tempo fazendo o programa repetir tarefas automáticas várias vezes.',
    icone: Icons.sync,
  ),
  Modulo(
    titulo: 'Combinação de Estruturas',
    descricao:
        'Misture tudo o que você aprendeu para criar programas mais completos.',
    icone: Icons.category_outlined,
  ),
  Modulo(
    titulo: 'Resolução de Problemas',
    descricao:
        'Use sua lógica para encontrar soluções para problemas desafiadores.',
    icone: Icons.warning_amber_outlined,
  ),
];
