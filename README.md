# HerCode

Aplicativo Android gamificado para ajudar calouras de Engenharia de Software a praticar lógica de programação e conhecer as contribuições de mulheres para a história da computação.

**v0.1.0 · Flutter · Dart · Android**

## O que funciona nesta versão

- **Módulo 1 — Introdução à Lógica:** lição guiada pela Ada Lovelace, com diálogos animados, exemplos em Python e quatro exercícios com feedback imediato. Após concluir o módulo, é possível revisar as explicações ou refazer a lição.
- **Prática livre:** 15 questões com alternativas embaralhadas. A cada três acertos, a usuária recupera uma vida, até o limite de cinco.
- **Conquistas e Hall da Fama:** concluir o primeiro módulo desbloqueia a conquista “Mente de Programadora” e a biografia da Ada Lovelace.
- **Perfil e progresso:** nickname, tutorial de primeiro acesso, pontuação e taxa de acertos. Os dados ficam salvos no dispositivo, sem necessidade de conta.

O Módulo 1 está completo. Os outros nove módulos fazem parte do conteúdo planejado.

## Como foi desenvolvido

Transformei o protótipo do Figma em um app Flutter com componentes reutilizáveis para cards, diálogos e feedback. Usei `ChangeNotifier` para compartilhar o estado de vidas e progresso entre as telas e `shared_preferences` para persistir esses dados. Validei manualmente no emulador Android o fluxo do primeiro acesso até o desbloqueio da conquista e a revisão do módulo.

## Como executar

Com o Flutter SDK configurado e um emulador ou dispositivo Android conectado, execute na raiz do projeto:

```bash
flutter pub get
flutter run
```

Para gerar o APK de teste:

```bash
flutter build apk --release
```

O arquivo é gerado em `build/app/outputs/flutter-apk/app-release.apk`.
