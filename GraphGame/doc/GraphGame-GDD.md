# Projeto e visão geral
**Conceito geral**:
**Título do jogo**:
**Destaque**: Aplica cobertura de vértices em um jogo feito na Godot v4.4;
**Público alvo**: Jogadores casuais;
**Plataforma**: ItchIo;
**Gênero do jogo**: *Pluzze*, Casual;
# Produção
Protótipo:
Pré-alpha:
Versão Alpha:
Versão Beta:
Versão Release Candidate:
Versão Gold:
# Jogabilidade
**Objetivo**: Abrir caminho no mapa e chegar ao ponto B;
**Desafio**: Descobrir os pontos mínimos de cada grafo pra abrir caminho; 
Recompensa:
**Câmera**: Fixa no mapa
Personagem:
**Controle**: Clique com o mouse nos pontos pra quebrar os grafos;
## Regras e estrutura do jogo
**Principais habilidades exigidas no jogo**: Identificar menor número de vértices de um grafo;
Experiência que o jogo quer passar:
Motivações apresentadas ao jogador:
## Fluxo de jogo
**Mecânicas auxiliares e modificadores que garantem a variedade e ritmo do jogo**: Aumento no tamanho do mapa;
**Recompensas do jogo**: Número de estrelas baseado no desempenho do jogador (não errar os pontos mínimos, tempo menor que o determinado para a fase, menor caminho possível);
**Inimigos e desafios do jogo**: Grafos formados por adjacência de objetos do mesmo tipo (representados por *cogumelos*, *pedras*, *arbustos* e *abóboras*);
**Tipo de fluxo do jogo**: Linear com fases pré montadas;
**Sinais e seus respectivos retornos ao jogador**: Destruir um grafo e ver o caminho sendo liberado, nível de desempenho e quantidade de estrelas recebidas na fase;
# Mecânicas
**Mecânica principal**: Clicar nos vértices e destruir os grafos
Mecânicas secundárias:
**Regras do jogo**: Selecionar o menor conjunto de vértices de um grafo vai destruí-lo e abrir caminho, passar pelo caminho e chegar ao ponto final finaliza a fase;
**Parâmetros da mecânica principal**: Número de vértices de um grafo, número mínimo de vértices que cobre todo o grafo definido pelo algoritmo, número de vértices selecionados pelo jogador.
# Projeto de nível (level design)
## Tutorial e progressão
**Tipo de tutorial**: Fases simples e com aumento progressivo de tamanho do mapa;
**Frequência de tutorial**: Uma fase para introduzir o clique nos objetos e caminho até o ponto final, uma fase para introduzir tempo, uma fase com todas as mecânicas ensinadas;
## Dificuldades
Dificuldades que o jogador irá enfrentar:
Tipos de desafios: 
Comportamentos dos desafios:
## Habilidades
Habilidades que ajudarão o jogador:
Tipos de habilidades:
## Interação Jogador-Ambiente
Nível de interação com o ambiente:
# História e narrativa
Estilo de narrativa:
Resumo da história:
Personalidades:
# Arte e estética
Estilo de arte e estética: Cartunesco;
Referências visuais:
Descrição da direção de arte:
Estilo de tipografia:
**Fonte das artes**: Asset Pack "Tiny Swords", de Pixel Frog via ItchIo;
**Fonte da tipografia**: Fonte Gotfridus, por GGBotNet via ItchIo;
**Resoluções**: Tiles 64px/64px, Tela 960px/896px;
# Interface e experiência de usuário
Telas de interface de usuário:
Fluxo de funcionamento dos botões das telas:
Fluxo de funcionamento de informações da Interface Principal:
# Programação
**Motor de jogos**: Godot Game Engine v4.4;
**Linguagem de programação**: GDScript;
Plugins e recursos prontos usados:
Principais mecânicas programadas sem recursos externos:
Outras mecânicas programadas do zero:
# Música e efeitos sonoros
Estilo musical:
Referências:
Quantidade de músicas:
Quantidade de efeitos sonoros:
**Fonte das músicas**: Music Pack "SVL's RPG MUSIC PACK", de Shononoki via ItchIo;
Fonte dos efeitos sonoros:
# Testes
Principais mecânicas testadas:
Mecânicas secundárias testadas:
Pontos importantes a serem observados nos testes:
Pessoas com conhecimento em desenvolvimento de jogos que testarão:
Pessoas leigas em desenvolvimento de jogos que testarão:
Retornos leves:
Retornos médios:
Retornos críticos:
# Post Mortem
Adicionar Save/Load State;