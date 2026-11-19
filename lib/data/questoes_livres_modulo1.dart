
import '../logic/mecanica_licao.dart';

// Banco de exercícios livres do Módulo 1.
// Questões independentes da lição principal.

final List<Questao> questoesLivresModulo1 = [
  // =====================================
  // LÓGICA DE PROGRAMAÇÃO — 4 QUESTÕES
  // =====================================

  const Questao(
    enunciado:
        'Qual é o principal objetivo da lógica de programação?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Organizar o raciocínio para resolver problemas.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Criar apenas páginas da internet.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Decorar todos os comandos de uma linguagem.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Fazer o computador funcionar sem instruções.',
      ),
    ],
    respostaCorretaId: 'a',
  ),

  const Questao(
    enunciado:
        'Antes de escrever um programa, qual atitude ajuda a encontrar uma solução?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Escolher comandos aleatórios.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Compreender o problema e planejar os passos.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Ignorar as informações disponíveis.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Executar o programa sem escrever instruções.',
      ),
    ],
    respostaCorretaId: 'b',
  ),

  const Questao(
    enunciado:
        'Uma pessoa precisa organizar os passos para preparar uma receita. Qual habilidade de programação ela está utilizando?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Edição de imagens.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Criação de redes.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Raciocínio lógico e sequenciamento.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Instalação de aplicativos.',
      ),
    ],
    respostaCorretaId: 'c',
  ),

  const Questao(
    enunciado:
        'Um programa precisa calcular a média de duas notas. Qual informação é necessária para resolver o problema?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'A cor da interface.',
      ),
      Alternativa(
        id: 'b',
        texto: 'O nome do computador.',
      ),
      Alternativa(
        id: 'c',
        texto: 'O tamanho da tela.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Os valores das duas notas.',
      ),
    ],
    respostaCorretaId: 'd',
  ),

  // =====================================
  // ALGORITMOS E INSTRUÇÕES — 3 QUESTÕES
  // =====================================

  const Questao(
    enunciado:
        'O que é um algoritmo?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Uma sequência organizada de passos para resolver um problema.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Um tipo de computador.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Um erro de programação.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Um programa que funciona sem comandos.',
      ),
    ],
    respostaCorretaId: 'a',
  ),

  const Questao(
    enunciado:
        'Para enviar uma mensagem, qual sequência de ações faz mais sentido?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Enviar → escrever → abrir conversa.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Abrir conversa → escrever → enviar.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Escrever → desligar celular → enviar.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Fechar aplicativo → enviar → escrever.',
      ),
    ],
    respostaCorretaId: 'b',
  ),

  const Questao(
    enunciado:
        'Por que a ordem das instruções pode ser importante em um algoritmo?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Porque todas as instruções são opcionais.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Porque a ordem serve apenas para deixar o código bonito.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Porque uma etapa pode depender do resultado de outra.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Porque o computador sempre reorganiza tudo sozinho.',
      ),
    ],
    respostaCorretaId: 'c',
  ),

  // =====================================
  // INTRODUÇÃO AO PYTHON — 4 QUESTÕES
  // =====================================

  const Questao(
    enunciado:
        'Qual comando Python exibe a mensagem "Bem-vinda!" na tela?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'mostrar("Bem-vinda!")',
      ),
      Alternativa(
        id: 'b',
        texto: 'escrever("Bem-vinda!")',
      ),
      Alternativa(
        id: 'c',
        texto: 'input("Bem-vinda!")',
      ),
      Alternativa(
        id: 'd',
        texto: 'print("Bem-vinda!")',
      ),
    ],
    respostaCorretaId: 'd',
  ),

  const Questao(
    enunciado:
        'O que acontece ao executar print(5 + 3) em Python?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'O programa exibe 8.',
      ),
      Alternativa(
        id: 'b',
        texto: 'O programa exibe 53.',
      ),
      Alternativa(
        id: 'c',
        texto: 'O programa não faz nada.',
      ),
      Alternativa(
        id: 'd',
        texto: 'O programa exibe 5 + 3 literalmente.',
      ),
    ],
    respostaCorretaId: 'a',
  ),

  const Questao(
    enunciado:
        'Qual alternativa representa um texto válido em Python?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Olá mundo',
      ),
      Alternativa(
        id: 'b',
        texto: '"Olá mundo"',
      ),
      Alternativa(
        id: 'c',
        texto: '<Olá mundo>',
      ),
      Alternativa(
        id: 'd',
        texto: '{Olá mundo}',
      ),
    ],
    respostaCorretaId: 'b',
  ),

  const Questao(
    enunciado:
        'Qual é a saída do código print("Her" + "Code")?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Her Code',
      ),
      Alternativa(
        id: 'b',
        texto: 'Her + Code',
      ),
      Alternativa(
        id: 'c',
        texto: 'HerCode',
      ),
      Alternativa(
        id: 'd',
        texto: 'O código sempre apresenta um erro.',
      ),
    ],
    respostaCorretaId: 'c',
  ),

  // =====================================
  // IDENTIFICAÇÃO DE ERROS — 2 QUESTÕES
  // =====================================

  const Questao(
    enunciado:
        'Uma estudante escreveu print("Olá mundo" e recebeu um erro. O que está faltando?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Um número antes do comando.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Uma segunda palavra print.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Um sinal de adição.',
      ),
      Alternativa(
        id: 'd',
        texto: 'O parêntese de fechamento.',
      ),
    ],
    respostaCorretaId: 'd',
  ),

  const Questao(
    enunciado:
        'Qual das instruções abaixo está escrita corretamente em Python?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'print("Aprendendo Python")',
      ),
      Alternativa(
        id: 'b',
        texto: 'print("Aprendendo Python"',
      ),
      Alternativa(
        id: 'c',
        texto: 'print "Aprendendo Python")',
      ),
      Alternativa(
        id: 'd',
        texto: 'print("Aprendendo Python)',
      ),
    ],
    respostaCorretaId: 'a',
  ),

  // =====================================
  // SEQUÊNCIA DE COMANDOS — 2 QUESTÕES
  // =====================================

  const Questao(
    enunciado:
        'Observe as instruções: print("A"), print("B"), print("C"). Qual será a ordem das mensagens?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'C, B, A.',
      ),
      Alternativa(
        id: 'b',
        texto: 'A, B, C.',
      ),
      Alternativa(
        id: 'c',
        texto: 'B, A, C.',
      ),
      Alternativa(
        id: 'd',
        texto: 'As mensagens aparecem em ordem aleatória.',
      ),
    ],
    respostaCorretaId: 'b',
  ),

  const Questao(
    enunciado:
        'Um programa executa print("Início"), depois print("Processando") e, por último, print("Fim"). Qual mensagem aparece por último?',
    alternativas: [
      Alternativa(
        id: 'a',
        texto: 'Início.',
      ),
      Alternativa(
        id: 'b',
        texto: 'Processando.',
      ),
      Alternativa(
        id: 'c',
        texto: 'Fim.',
      ),
      Alternativa(
        id: 'd',
        texto: 'Todas aparecem ao mesmo tempo.',
      ),
    ],
    respostaCorretaId: 'c',
  ),
];
