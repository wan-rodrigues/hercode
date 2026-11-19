
import '../logic/mecanica_licao.dart';

// Primeiro exercício:
// Organizar as etapas de um pedido de comida.

const Questao questaoPedidoComida = Questao(
  enunciado:
      'Qual das sequências representa corretamente '
      'os passos para fazer um pedido de comida?',
  alternativas: [
    Alternativa(
      id: 'a',
      texto:
          'Escolher a comida → Fazer o pedido → '
          'Realizar o pagamento → Receber a comida',
    ),
    Alternativa(
      id: 'b',
      texto:
          'Receber a comida → Escolher a comida → '
          'Realizar o pagamento → Fazer o pedido',
    ),
    Alternativa(
      id: 'c',
      texto:
          'Realizar o pagamento → Receber a comida → '
          'Escolher a comida → Fazer o pedido',
    ),
    Alternativa(
      id: 'd',
      texto:
          'Fazer o pedido → Receber a comida → '
          'Escolher a comida → Realizar o pagamento',
    ),
  ],
  respostaCorretaId: 'a',
);


const Questao questaoPythonPrint = Questao(
  enunciado: 'Qual comando em Python exibe a mensagem '
      '"Olá, mundo!" na tela?',
  alternativas: [
    Alternativa(
      id: 'a',
      texto: 'print("Olá, mundo!")',
    ),
    Alternativa(
      id: 'b',
      texto: 'input("Olá, mundo!")',
    ),
    Alternativa(
      id: 'c',
      texto: 'mostrar("Olá, mundo!")',
    ),
    Alternativa(
      id: 'd',
      texto: 'echo("Olá, mundo!")',
    ),
  ],
  respostaCorretaId: 'a',
);


const Questao questaoEncontrarErro = Questao(
  enunciado: 'Qual das alternativas apresenta um comando '
      'Python escrito corretamente?',
  alternativas: [
    Alternativa(
      id: 'a',
      texto: 'print("Bem-vinda ao HerCode!"',
    ),
    Alternativa(
      id: 'b',
      texto: 'print("Bem-vinda ao HerCode!")',
    ),
    Alternativa(
      id: 'c',
      texto: 'print Bem-vinda ao HerCode!',
    ),
    Alternativa(
      id: 'd',
      texto: 'print("Bem-vinda ao HerCode!)',
    ),
  ],
  respostaCorretaId: 'b',
);

const Questao questaoSequenciaPython = Questao(
  enunciado: 'Queremos criar um programa que primeiro '
      'cumprimenta, depois apresenta o assunto e, '
      'por último, se despede.\n\n'
      'Qual sequência está correta?',
  alternativas: [
    Alternativa(
      id: 'a',
      texto: 'print("Até logo!")\n'
          'print("Olá!")\n'
          'print("Estou aprendendo Python!")',
    ),
    Alternativa(
      id: 'b',
      texto: 'print("Olá!")\n'
          'print("Estou aprendendo Python!")\n'
          'print("Até logo!")',
    ),
    Alternativa(
      id: 'c',
      texto: 'print("Estou aprendendo Python!")\n'
          'print("Até logo!")\n'
          'print("Olá!")',
    ),
    Alternativa(
      id: 'd',
      texto: 'print("Até logo!")\n'
          'print("Estou aprendendo Python!")\n'
          'print("Olá!")',
    ),
  ],
  respostaCorretaId: 'b',
);

