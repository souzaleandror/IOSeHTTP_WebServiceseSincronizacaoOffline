#### 28/08/2023

Curso de iOS e HTTP: Web Services e sincronização offline

```
Utils: In Postman

GET http://localhost:8080/recibos

POST http://localhost:8080/recibos
(header: Content-Type: application/json)

DELETE http://localhost:8080/recibos/3f91c769-a87a-4381-9637-39cac899f33f
```

@01-Conhecendo o projeto 

@@01
Apresentação

[00:00] Olá seja bem-vindo, seja bem-vinda a Alura, eu sou o Ândriu, um dos instrutores de iOS aqui da plataforma. A ideia desse curso é falarmos sobre requisições http. Então, relembrando, nós estamos utilizando o nosso app Alura ponto como base dos nossos estudos.
[00:19] Então caso você ainda não tenha visto, alguns cursos anteriores nós iniciamos esse projeto do zero, e fomos, ao passar do tempo, desenvolvendo novas funcionalidades. Agora é hora de falarmos um pouco sobre requisições http.

[00:34] Inconscientemente nós utilizamos o tempo todo nosso telefone, seja para fazer transferência bancária, pagar conta, aplicativos de mensagens, enfim, todos esses apps utilizam internet, tanto 3G, 4G ou wi-fi para enviar informações para o servidor do mundo todo, então é um assunto que é muito importante você saber, porque é um dos pilares do desenvolvimento, a todo instante fazermos requisições para serviços externos do nosso app.

[01:02] No curso anterior nós aprendemos a persistir informações com o Core Data, e a ideia agora é continuarmos com esse projeto, mas utilizando um servidor que nós vamos rodar local no nosso Mac, que na verdade vai simular um servidor já hospedado, em algum serviço, como o AWS, o Azure, Heroku, mas a ideia aqui é rodarmos esse projeto Alura ponto API forma local no nosso app, e acessar através do localhost para simular algumas requisições.

[01:34] Então ao decorrer do curso, você vai aprender a salvar um objeto no servidor, vamos usar o Postman para ver se realmente está sendo salvo, vamos também trabalhar com a listagem desses recibos de ponto que nós teremos aqui no nosso aplicativo.

[01:49] Então vamos salvar, vamos listar, vamos deletar e, à medida que o curso for avançando vamos falar de diversos conceitos importantes, como os verbos aqui da requisição, vamos falar o que podemos passar no header da requisição, como é que configuramos o body de requisição, como que transformamos um dicionário em binário para enviarmos em uma requisição.

[02:13] Então são coisas rotineiras que um desenvolvedor, uma desenvolvedora, acaba fazendo no dia a dia, e vamos aprender aqui como é que fazemos no nosso projeto. Vamos começar trabalhando com requisições de forma nativa, utilizando as classes do swift.

[02:29] E depois vamos ver também como é que funciona utilizando uma lib que facilita essas requisições para nós, que é o Alamofire. Vamos ver então como é que trabalhamos para persistir, listar e deletar esses elementos no nosso servidor local. Esse é o conteúdo então que nós vamos ver durante esse curso e eu espero você.

@@02
Projeto inicial

Para iniciar o curso, faça o download do projeto.
Bons estudos!

https://github.com/alura-cursos/2316-alura-ponto-parte2/archive/97149295535d3a9a209cc77862873a3907abd7ba.zip

@@03
Conhecendo a API

[00:00] A partir de agora nós vamos começar a conversar sobre um assunto bem importante quando falamos de desenvolvimento móvel, que é como que o aplicativo se comunica com serviços externos. O que eu quero dizer com isso?
[00:15] Quase 100% de todos apps que você utiliza, provavelmente fazem alguma requisição para algum tipo de serviço, e te devolve a resposta simultaneamente, conforme você utiliza esse aplicativo.

[00:27] Então se pensarmos em um aplicativo de banco, quando você faz uma transferência, quando você paga um boleto, inconscientemente, você está enviando informações para algum servidor, esse servidor processa todas as informações e dados que você enviou, e ele te devolve uma resposta. A resposta pode ser sucesso, pode ser error, pode ser vários tipos de resposta.

[00:50] E o que eu quero dizer com isso? Até então, nós estamos utilizando, a persistência de dados e todas as coisas que nós fizemos no nosso app. Nós estamos fazendo de forma local, isso significa que se eu apagar o app no meu iPhone, apagar o app do simulador, nós perdemos todas as informações. Como é que solucionamos isso então?

[01:14] É justamente utilizando requisições http, onde nós vamos nos comunicar com o servidor, onde nós podemos salvar, podemos deletar, podemos atualizar informações que nós enviarmos a esse serviço. Então conseguimos fazer várias operações nesse servidor e, se eu deletar o app, se eu apagar, instalar de novo, basta eu fazer uma requisição para o servidor e ele vai me devolver todas as informações, porque elas não vão mais estar local no meu app, e sim hospedado em algum lugar na nuvem.

[01:51] No nosso caso aqui no curso vamos utilizar o nosso próprio Mac para fazer um servidor, mas normalmente esses serviços são hospedados na AWS, no Azure, da Microsoft, no Heroku. Então tem vários serviços de hospedagem para este tipo de aplicação, que é o que chamamos, na verdade, de projetos em back-end.

[02:15] Então, para começarmos, eu queria apresentar para você esse projeto Alura Ponto API. Trazendo isso para o nosso contexto, estamos trabalhando com o nosso aplicativo de registro de ponto, então podemos, na verdade, salvar um registro, bater o ponto e tudo mais, como nós já fizemos nos outros cursos. Ele mostra aqui nessa lista todos os recibos. Mas como eu disse, nós temos esse problema, se apagarmos o app e rodar ele de novo, perdemos todas as informações.

[02:49] Vamos utilizar então esse projeto para criar um servidor local no nosso Mac e conseguirmos, então, usar como base para estudar um pouco mais sobre requisições. O que esse projeto faz?

[03:02] Aqui temos toda a documentação, inclusive esse link que vai estar disponível para você, nessa sessão aqui do curso, então você pode clicar lá e você vai ter acesso à mesma página que eu estou te mostrando agora.

[03:14] Vamos ver passo a passo, com calma ao decorrer do curso. Agora eu queria mostrar para você esse ponto aqui, acesso ao projeto. Então você pode acessar o código fonte do projeto, ou você pode clicar aqui nesse link para baixar o jar executável, que é o que nós vamos utilizar aqui no curso.

[03:32] Então eu vou pedir para que você baixe esse arquivo. Depois disso, nós temos aqui um arquivo parecido com esse, que eu deixei dentro dessa pasta, que é esse “server.jar”. É ele que vamos utilizar. E como é que eu utilizo então esse projeto? Aqui tem toda documentação do projeto, aqui ele dá uma dica de como é que executamos, que é esse java-jar e nome do arquivo. É isso que nós vamos precisar.

[04:07] Um ponto importante para que você não tenha nenhum problema, estamos mostrando, e eu vou executar esse projeto, nessa versão 11 do Java. Então, para que você consiga acompanhar sem nenhum problema, é interessante que você esteja utilizando a mesma versão.

[04:26] Agora o que que eu vou fazer? Eu vou executar aquele arquivo que eu tenho aqui nessa pasta, então eu vou abrir o terminal e como é que executo? Eu vou digitar o comando java -jar e eu clico e arrasto para obter o caminho desse “server.jar” aqui no terminal. Então ele copia o comando, na verdade, o path, o caminho onde está o arquivo.

[04:54] Quando eu faço isso, ele vai aqui executar vários scripts, mas isso significa que eu já tenho um projeto rodando aqui no meu Mac, então a partir de agora eu já consigo utilizar esse serviço.

[05:10] Então, a princípio, esse primeiro vídeo é para contextualizar para você, como é que vamos caminhar ao decorrer desse curso, utilizando essa API, que é esse serviço externo que nós vamos rodar no nosso Mac, criando um servidor local, vamos acessar inclusive através do localhost, e ele vai servir de base para manipularmos os recibos do nosso app através de requisição http.

@@04
Para saber mais: Baixando arquivo do servidor

Neste primeiro capítulo, tivemos uma visão geral do que utilizaremos para salvar os registros de pontos em um servidor através de requisições http.
Você pode ver a documentação e fazer o download do projeto através deste link.

https://github.com/alura-cursos/alura-ponto

https://github.com/alura-cursos/alura-ponto/archive/refs/heads/dev.zip

https://github.com/alura-cursos/alura-ponto/tree/dev

https://github.com/alura-cursos/alura-ponto/releases/download/0.0.1/server.jar

@@05
Faça como eu fiz: Alura ponto API

Alura Ponto API é uma aplicação back-end para gerenciar registro de pontos. A aplicação foi desenvolvida em Kotlin, utilizando o Spring Boot e versão do Java 11.

Agora, você pode fazer o download do arquivo do servidor através deste link.
Ne seção de acesso ao projeto, baixe o jar executável.

https://github.com/alura-cursos/alura-ponto

@@06
O que aprendemos?

Nesta primeira aula, entendemos quais implementações e problemas vamos resolver ao decorrer do curso, e também aprendemos a baixar e configurar o projeto.

#### 29/08/2023

@02-Testando a API

@@01
Testando a API

[00:00] Agora que nós já colocamos o servidor para funcionar através do arquivo que nós fizemos o download, é hora de começarmos testar e ver como esse serviço funciona. Você vai perceber que, por enquanto, não vamos mexer no nosso projeto, não vamos abrir o XCode, nem rodar nada por lá, porque é importante entendermos alguns conceitos antes de começarmos a pôr a mão na massa.
[00:23] No meu caso já tenho aqui o meu terminal rodando com a nossa aplicação, eu vou utilizar um programa aqui chamado Postman. Caso você ainda não conheça, é esse aqui, que vai me auxiliar nas requisições. Então antes de fazermos as requisições no app, vamos aprender a trabalhar com Postman, que é uma forma mais intuitiva de testarmos as requisições. Então você pode utilizar o Postman, você pode fazer o download dele, e depois você vai clicar no ícone do Postman para aprendermos a trabalhar com ele.

[01:06] Basicamente o que ele faz? Ele serve para nos ajudar a testar a API. Então se eu pegar a documentação do Git aqui, onde nós instalamos o nosso projeto, onde nós fizemos download do jar, ele nos mostra aqui algumas coisas, como por exemplo, esse endpoints. vamos ouvir várias vezes essa palavra endpoint ao decorrer do curso.

[01:37] O que significa o endpoint? Se formos traduzir, ponto final, ou ponto de extremidade. Ele nada mais é do que o ponto de comunicação com servidor, então é uma URL que serve para nos comunicarmos com o servidor. Por exemplo, quando falamos assim, qual é o endpoint de recibos, então você vai ver que é localhost, porque estamos utilizando o servidor local, então “http://localhost:” número da porta que é “8080/recibos”. Parece meio estranho mas vamos ver que não é, a seguir, quando utilizarmos o Postman.

[02:16] Então vamos ler então aqui alguns pontos importantes depois vamos praticar isso. Temos aqui alguns endpoints e aqui temos alguns verbos da requisição, vamos ver mais a fundo daqui a pouco.

[02:30] Então ele fala aqui, GET devolve a lista de todos os pontos. Aqui ele dá um exemplo de uma lista de JSON com os recibos.Temos aqui um verbo, um método POST, que recebe um recibo, via o corpo da requisição, salva ou altera.

[02:50] E nós temos também o DELETE, onde podemos remover o recibo. Eu vou abrir, então, o Postman. Eu já tenho aqui uma aba criada e eu queria começar mostrando para você algumas coisas. Eu vou abrir aqui o Sublime só para anotarmos algumas coisas importantes.

[03:12] Primeiro temos que ver do que se trata o endpoint. Qual é o exemplo de endpoint que temos aqui? Nós temos esse exemplo de endpoint aqui, como eu acabei de falar, “http://localhost:8080/recibos”, então vou dar um “Command + C”, “Command + V”. Temos aqui o primeiro endpoint.

[03:36] Nesse endpoint, podemos quebrar ele para entender algumas coisas. Temos aqui, por exemplo, o baseURL, que é esse http://localhost:8080, e nós temos aqui o path:. O path é um recurso que nós vamos utilizar, que é, no caso, esse recibos.

[04:00] O que precisamos entender aqui? Primeiro, como eu acabei de falar, está localhost porque nós estamos executando na nossa própria máquina. Se você fosse publicar isso, ou quem desenvolveu fosse publicar em algum serviço, poderia ser, por exemplo, alura.com/recibos. Então acessaríamos esse mesmo serviço caso tivesse com a aplicação publicada, ou qualquer outro tipo de URL, como api.alura. Isso depende de quem vai publicar.

[04:39] O que eu quero dizer? Que esse baseURL muda se você que executar o localhost. Se você já tem ele publicado, você vai utilizar o caminho que você já tem.

[04:49] Esse /recibos, é o path, ou seja, já é o caminho que vamos utilizar para chamar esse recurso. Poderia ser outras coisas, /recibos, /localizacao. Enfim, poderia ser qualquer nome. O que importa é você saber para que ele serve. No caso, /recibos podemos fazer três operações: podemos listar, podemos salvar e podemos deletar, tudo através desse path /recibos.

[05:20] Vimos na documentação também alguns métodos, ou alguns verbos da requisição. Ele está mostrando GET, o POST, e o DELETE. Então você vai ver várias vezes essa nomenclatura, inclusive aqui no Postman, podemos escolher aqui qual é o verbo, ou qual método da requisição queremos. Ele possui vários, tem uma lista aqui. Eu vou passar para você os mais utilizados, que nós vamos até usar aqui no curso.

[05:52] Então verbos, ou métodos da requisição, quais são os que temos? Temos o GET, onde podemos obter os recursos, no caso aqui é listar, temos o POST que é utilizado para criação do recurso.

[06:26] Quando vamos salvar o recibo, por exemplo, clicamos em registrar ponto, bateu o ponto, tiramos a foto e clicamos em usar. Podemos, nesse momento, chamar esse endpoint com o verbo POST, porque é onde vamos criar, ou seja, vamos salvar esse recurso. Quando falamos recurso, é o objeto, a informação que nós estamos trabalhando, no caso, o recibo.

[06:53] Então GET utilizamos para listar, o POST utilizamos para criar, ou salvar. Nós temos também o DELETE, que removemos o recuro, e o PUT que é utilizado para atualizar determinado recurso. Também poderia ser o PATCH, mas esses aqui são os mais utilizados,. Vamos falar bastante sobre esses métodos aqui na hora que formos criar a requisição.

[07:33] Agora precisamos entender um outro ponto, o que vamos ver agora? Se virmos aqui no Postman, repara que tem várias abas. Temos aqui esse "authorization" e temos outra que é esse "header". É disso que eu quero falar agora.

[07:51] Então "header", ou cabeçalho da requisição, para que ele serve? Para enviar informações adicionais na requisição. Então poderíamos enviar o token, poderíamos utilizar para enviar alguma configuração, como aqui temos aqui, que é esse content-type. O que é esse content-type? Quando utiliza APIs Rest, geralmente trabalhamos com alguns formatos, principalmente quando falamos em mobile, o mais conhecido é o formato do JSON.

[08:34] Então poderíamos pedir para o content-type, retornar o formato JSON, que é aquele objeto Javascript que tem os colchetes e tudo mais, bem conhecido. Vamos trabalhar bastante aqui também, mas poderíamos trabalhar com o XML, com HTML. Tem vários formatos que podemos consumir no nosso app, mais comum é o JSON ou, em alguns casos, ele retorna como bytes, que é um tipo data, convertemos isso para dictionary e conseguimos utilizar da forma que quisermos.

[09:18] Então temos o header. Eu estou falando aqui de vários conceitos, já vamos praticar, e você vai ver que não é complicado, mas a primeira impressão que temos é de várias coisas, várias configurações, mas quando formos utilizar vai ficar muito mais claro.

[09:40] Dito tudo isso, viremos aqui no Postman e vamos brincar um pouco para entender como é que tudo isso funciona. Segundo o que estudamos, quando utilizamos uma requisição GET, obtemos os recursos.

[09:58] Eu tenho aqui o endpoint, então já está configurado, eu tenho o método, ou o verbo da requisição, já está configurado, eu tenho o header, que também já está configurado com esse “aplication/json”, tudo isso nos possibilita a enviar nessa requisição.

[10:24] Então se eu clicar aqui em Send, no lado direito superior da janela do nosso arquivo do Postman, vamos testar. Cliquei em "Send". Aqui na parte de baixo da janela, é onde ele traz a resposta da requisição. Repare que ele trouxe uma lista vazia. Se tem uma lista vazia, primeiro significa que funcionou, se não ele devolveria um erro, segundo que, se está vazio, podemos salvar um objeto para depois testarmos, que é o que nós vamos fazer agora.

[10:51] Segundo a nossa anotação, quando eu utilizo o Postman, conseguimos criar um recurso, ou seja, conseguimos salvar alguma coisa. Então ao invés de GET, para listar eu quero salvar, quero criar um recurso. Então vou utilizar aqui o POST.

[11:13] Quando eu clico aqui em POST, no menu de opções na parte superior esquerda da janela do arquivo, ao lado esquerdo do endpoint, eu preciso enviar, via body, ou seja, via corpo da requisição, o que eu quero salvar. Isso também é muito importante, podemos enviar objetos no body, ou seja, no corpo da requisição, porque, senão, como é que ele vai saber o que ele precisa salvar? Precisamos indicar para ele.

[11:45] Então eu vou clicar aqui em body e eu vou criar o JSON que eu quero salvar. Começo abrindo e fechando chave. O que precisamos enviar quando falamos em recibo de ponto? A data, que é muito importante. Vou dar um zoom aqui para facilitar. Então vou colocar aqui qualquer data, ”data”: “22/10/2021 03:34”, e vou colocar um horário também, coloco uma vírgula, vou para linha de baixo.

[12:25] Que eu quero salvar? O status. O status também, eu quero saber se foi salvo local. Se não foi, então eu estou enviando aqui como ”status”: false,. Apertei aqui com “Command + S”, deixa eu fechar aqui, vamos voltar.

[12:45] Além disso, que eu quero salvar? Eu quero salvar a ”localização”: {}, A localização é um objeto que possui a ”latitude”: “199” , eu vou por aqui qualquer valor, não faço ideia aonde que isso vai cair, e a ”longitude”: “2222”, Vou colocar aqui também qualquer valor. São essas informações que eu quero salvar.

[13:12] Mas como é que eu sei qual informação eu tenho que enviar em uma requisição POST? Se você trabalha em uma empresa e ela possui um nível de organização bacana, geralmente eles utilizam uma plataforma chamada Swagger, onde fica documentado todas as APIs que os desenvolvedores consumiram. Lá tem tudo que você precisa mandar, verbo da requisição, o endpoint, o que você envia no body, o que você envia na própria URL, qual é o header, o que você precisa passar. Fica tudo documentado, você não tem problema nenhum.

[13:47] Caso você esteja desenvolvendo com um amigo, ou em algum lugar um pouco menor, que ainda não tem esse processo, você precisa perguntar, de fato, para o Dev back-end o que você precisa enviar nessa requisição e ele vai te falar.

[14:02] Então nós já criamos o body da requisição. Eu vou clicar aqui em “Send”. Olha só que interessante, ele salvou. Significa que ele criou esse curso, inclusive ele está me dando aqui o ID do recibo que foi salvo.

[14:23] Então já vimos aqui como é que funciona o POST. Vamos abrir aqui nossa anotação. O próximo é o DELETE, então como é que eu deleto um recurso? Aliás, antes de deletar, vamos voltar aqui para o GET, no menu ao lado esquerdo endpoint, e vamos clicar em Send, para vermos se ele já está listando isso que acabamos de salvar.

[14:43] Cliquei em "Send" e ele não me traz mais uma lista vazia, e sim o recibo que nós salvamos aqui para testar. Então realmente o GET está funcionando. Por último, nós veremos aqui como é que funciona o DELETE. O DELETE é o seguinte: o endpoint e o path, que vai mudar um pouco. Eu vou colocar </> ID, do recibo. Qual é o ID? Ele gerou para nós. Então eu tenho na parte inferior da janela do arquivo o "id" que foi gerado. Vou clicar em “Send”.

[15:20] Como é que eu faço para ver se realmente deletou? É simples, eu posso vir aqui no link do path, apagar o ID, deixando como estava, e vir no GET, no menu à esqueda da barra do path, que é onde lista para saber se ele está aparecendo. Cliquei em "Send", ele não me retorna nada. Significa que realmente estamos salvando.

[15:39] Então vimos aqui, rapidamente, como é que criamos uma requisição no Postman para testarmos a nossa API, falamos aqui de diversos conceitos que vamos traduzir, isso daqui a pouco, para Swift, mas a ideia aqui foi mostrar para você que a API está funcionando. Vamos então utilizá-la a seguir para conseguirmos salvar, listar e deletar, tudo isso no nosso aplicativo.

@@02
Header da requisição
PRÓXIMA ATIVIDADE

Quais tipos de informações podemos enviar no header(cabeçalho) de uma requisição http?

Podemos passar diversas informações, dentre elas: o verbo ou método da requisição e o body.
 
Alternativa correta
Podemos passar diversas informações e, dentre elas, as mais comuns são: Content-Type e Authorization (token).
 
Alternativa correta! A classe CLContext permite que o app solicite que o usuário se autentique usando a biometria/face id ou a senha numérica cadastrada no iOS.
Alternativa correta
Podemos passar diversas informações, dentre elas: o body da requisição e o endpoint.

@@03
Faça como eu fiz: Uso do Postman
PRÓXIMA ATIVIDADE

O postman é uma aplicação client que nos auxilia principalmente em testes e documentação de APIs.

Para nos auxiliar na aprendizagem, você pode fazer o download através deste link do Postman.

https://www.postman.com/downloads/

@@04
O que aprendemos?
PRÓXIMA ATIVIDADE

Nesta aula, aprendemos a configurar o postman para testar a API que vamos utilizar para criar nossas requisições no nosso aplicativo.
