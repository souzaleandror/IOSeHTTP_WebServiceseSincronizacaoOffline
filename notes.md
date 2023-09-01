#### 28/08/2023

Curso de iOS e HTTP: Web Services e sincronização offline

```
java -jar

java -jar server.jar

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

Quais tipos de informações podemos enviar no header(cabeçalho) de uma requisição http?

Podemos passar diversas informações, dentre elas: o verbo ou método da requisição e o body.
 
Alternativa correta
Podemos passar diversas informações e, dentre elas, as mais comuns são: Content-Type e Authorization (token).
 
Alternativa correta! A classe CLContext permite que o app solicite que o usuário se autentique usando a biometria/face id ou a senha numérica cadastrada no iOS.
Alternativa correta
Podemos passar diversas informações, dentre elas: o body da requisição e o endpoint.

@@03
Faça como eu fiz: Uso do Postman

O postman é uma aplicação client que nos auxilia principalmente em testes e documentação de APIs.

Para nos auxiliar na aprendizagem, você pode fazer o download através deste link do Postman.

https://www.postman.com/downloads/

@@04
O que aprendemos?

Nesta aula, aprendemos a configurar o postman para testar a API que vamos utilizar para criar nossas requisições no nosso aplicativo.


@03-Método POST

@@01
Salvando informações no servidor

[00:00] Agora que nós estudamos vários conceitos e vimos como é que a API funciona no Postman, é hora de traduzirmos tudo isso para o nosso projeto em Swift. Eu já estou com projeto aberto aqui e a primeira coisa que eu vou fazer, é criar uma nova pasta chamada “networking”. Repara que, nesse momento, nós não estamos falando sobre arquitetura. Não estamos utilizando uma arquitetura e desmembrando todas as partes do projeto. Enfim, a ideia é simplesmente trabalharmos com conceito de separação de responsabilidade. Não deixar o view controller responsável por tudo.
[00:40] A partir disso você pode utilizar, futuramente, a arquitetura que você quiser. O importante é termos esse conceito de separação de responsabilidade, independente da arquitetura que você for utilizar. Eu vou criar então uma nova pasta, clicando em "New Group", e vou chamar de “networking”, ou seja, tudo relacionado a requisições. Eu vou deixar nessa pasta aqui.

[01:05] E dentro, eu vou criar um novo arquivo que é esse “Swift file”, que eu vou chamar de “ReciboService”. Vou clicar em “Create”, então vou criar a classe class ReciboService{}. Ela será responsável por criar as requisições que nós precisamos para salvar o nosso recibo no servidor.

[01:33] Para começar, eu vou criar um novo método, vou chamar aqui de POST, em que eu vou receber um recibo, do tipo recibo, func post: (_ recibo: Recibo){} e eu vou então salvar ele na API. Então, basicamente, da mesma forma que nós fizemos aqui no Postman, onde nós configuramos o endpoint para POST, fizemos o body, tudo isso vamos ter que fazer no nosso projeto.

[02:04] Então vamos lá. Eu vou começar configurando a URL que nós temos aqui, ou seja, o endpoint. Então vou criar aqui uma constante, vou chamar de let baseURL =, e ela vai ser igual a isso aqui, ”http://localhost:8080”. Vou colar aqui e vou criar também uma constante let path = recibos que vai ser recibos, que é o que restou aqui da url. Esse é o path.

[02:49] Por que eu estou fazendo isso? Poderia colocar tudo na mesma constante e chamar de url? Poderia. Eu estou fazendo isso simplesmente para desmembrarmos esse endpoint e você entender que parte é baseURL e que parte é path.

[03:03] Depois disso, precisamos criar os parâmetros que nós vamos enviar. Nós temos no Postman um JSON com algumas informações, só que, como nós estamos recebendo o objeto por parâmetro no nosso código, já temos todos aqueles valores. Só precisamos então criar o JSON.

[03:24] Então vamos lá, vou chamar aqui de parâmetros, let parametros: vai ser um dicionário de string any [String: Any] = []. Dentro dos [] eu vou criar os parâmetros que eu vou utilizar, começando aqui com a data [“data”:].

[03:42] Nós temos a "data" no nosso objeto, só que ela está no formato de data. Vamos até conferir em "Recibo.swift". A data é do tipo Date e precisamos enviar com o tipo string. Temos uma classe no nosso projeto que vai nos ajudar, que é esse formatador de data, onde nós passamos uma data e ela retorna o formato string, então vou utilizar ela agora.

[04:13] Então "data": FormatadorDeData(), eu vou utilizar o método .getData() e vou passar a data do recibo, (recibo.data),. Importante, sempre depois que eu coloco o primeiro parâmetro, tem que colocar uma vírgula para poder continuar. Sem a vírgula, ele vai dar erro, então sempre com a vírgula.

[04:37] Próximo passo é o status, então vou pegar aqui ”status”: recibo.status. Depois nós temos a ”localizacao”:. A localização é um objeto também, então repara que eu tenho aqui a localização e dentro dela tem um objeto com a latitude e longitude. Vamos fazer igual aqui: um objeto e dentro dele um ”latitude”: recibo.latitude, “longitute”: recibo.longitude. Criamos então o objeto igual ao que nós configuramos lá no Postman.

[05:28] Agora precisamos continuar com a requisição, o que vamos fazer? Eu preciso transformar tudo isso que vai no body, em bytes do tipo data, de dados, não essa classe aqui. Precisamos converter esses parâmetros, porque, no corpo da requisição, ele não aceita esse formato de dictionary.

[05:59] Então o que eu vou fazer? Vou criar um guard let body = try? ai eu vou dar aqui um try e vou chamar a classe JSONSerialization.data(). Eu passo aqui o dicionário que eu tenho que são os parâmetros, withJSONObject: parametros, options:. Tudo isso daqui eu vou abrir e fechar os [] e, caso eu não consiga converter, else { return }, e escapo do método.

[06:36] Agora eu vou transformar, tanto o baseURL quanto o path em uma URL de verdade. Aqui estamos utilizando ela como string e precisamos disso como url, então como é que eu faço? guard let url, por que eu estou utilizando guard let url? Porque todos esses métodos retornam opcional e aqui eu já estou desembrulhando isso com segurança, ou seja, ou ele tem o valor ou ele dá um return.

[07:08] guard let url, ai eu chamo aqui a classe URL. Ele tem um inicializador onde passo uma string, URL(string:) que é o tipo que eu tenho aqui. Então eu vou passar baseURL + path) ai ele transforma tudo isso em uma URL. Caso ele não consiga eu dou aqui um else { return }.

[07:35] Com o body e com a URL, agora eu posso de fato criar a requisição, então eu vou utilizar uma classe aqui que se chama URL request, então eu vou criar aqui uma variável chamada requisição, var requisicao = URLRequest.

[07:53] Repara que estamos fazendo a requisição de forma nativa. No próximo capítulo, vamos ver como fazemos uma requisição utilizando uma biblioteca, um framework, para nos ajudar, que é o Alamofire. Porém é importante entendermos primeiro como é que fazemos de forma nativa, que é, de fato, um pouco mais trabalhosa, mas passamos por todas as etapas que estudamos para praticar, depois deixamos isso um pouco mais fácil, com o uso da biblioteca. Vamos entender primeiro como é de forma nativa.

[08:27] Quando inicializo essa classe URLRequest(), posso passar então a url: url, a URL que nós criamos aqui em cima. Então vou passar a URL aqui, url). Além disso, tem algumas configurações que nós precisamos fazer. Olha, requisição requisicao.httpMethod, repara que ele utiliza o termo método.

[08:51] Então, relembrando, quando nós precisamos salvar um recurso, criar um recurso, qual o método que utilizamos? O POST, então é isso que precisamos configurar aqui, então é requisicao.httpMethod = “POST”.

[09:08] Além disso, nós vamos utilizar aqui também a configuração do header. Como é que eu coloco o valor do header na requisição? Eu dou requisicao.setValue(), onde eu passo o "application/json", igual nós temos aqui no Postman. Vamos relembrar, o valor value desse header, é "application/json", então eu vou copiar isso aqui e vou colar aqui.

[09:39] E qual que é o campo forHTTPHeaderField:? O campo é esse Content-Type, então vou copiar ele e vou utilizar aqui.

[09:58] Por último precisamos utilizar o body, ou seja, configurar o que vamos enviar por parâmetro. Então requisicao.httpBody. Repara que o formato dele realmente é no formato data, é opcional. Nós já convertemos, então ele = body que nós temos aqui.

[10:25] Além disso, precisamos agora, criar uma sessão para essa requisição, o envio desta requisição, a execução desta requisição. Como é que fazemos isso? Vamos utilizar essa classe URLSession.shared que é um singleton e eu vou utilizar esse .dataTask.

[10:53] Eu vou utilizar esse método, mas repara que ele tenha vários inicializadores, eu vou utilizar esse aqui, onde eu tenho URLrequest, e a requisição, que eu já tenho. Então eu vou passar ela aqui, requisicao. Aqui é ela é uma closure, onde eu posso configurar algumas coisas, como, por exemplo, o retorno em formato de data, a resposta, data, resposta e o error in, caso exista, então error.

[11:35] Como é que fazemos para executar essa requisição? No final, precisamos dar um .resume(). Se você não colocar esse .resume no final, ele não vai executar a requisição. Dentro dp () podemos fazer algumas requisições para ver o que essa requisição retornou.

[11:57] Então eu vou utilizar aqui a resposta if let resposta = resposta. Eu só vou extrair o valor dela e vou dar um print da resposta, {print(resposta)}. Eu vou fazer também a mesma coisa com esse parâmetro data if let data =data. Vou desembrulhar esse valor, data { do () }, se existir alguma coisa aqui, eu vou ver o que ele está retornando do {}.

[12:25] Então let json =. Vamos ver qual é o json de retorno, try JSONSerialization.jsonObject(with: ). Eu passo aqui o dado que eu estou desembrulhando, data, options: []), e vejo o que ele me retornou, print(json). Se não der certo, ele vai cair aqui nesse catch () e vamos ver qual foi problema, print(error).

[12:59] Repara que o método ficou realmente grande. Tem várias configurações que precisamos fazer, mas relembrando que fizemos. Traduzimos tudo que fizemos aqui no Postman para o nosso aplicativo, então: utilizamos o URL, criamos o corpo da requisição, ou seja, o que vamos enviar para salvar, transformamos tudo isso em data através dessa classe JSONSerialization, criamos a URL do tipo url mesmo, porque aqui estávamos utilizando como string.

[13:36] Depois disso utilizamos essa classe URLRequest, para configurar o método da requisição, que é POST, como nós vamos criar os recursos, como vamos salvar, configuramos um header para que seja application/json, igual nós temos no Postman, e passamos tudo isso daqui no formato data para requisição, ou seja, o que vamos enviar.

[14:02] Depois disso nós utilizamos a classe urlSession e utilizamos esse método dataTask, que é o que de fato faz a requisição. Então nós passamos a requisição e ele devolve três coisas aqui: esse formato de bytes, em data, a resposta e o erro. Então estamos criando aqui alguns ifs com print, só para verificarmos o valor que está sendo devolvido na requisição, para ver se funcionou ou não.

[14:38] Feito tudo isso, viremos aqui no “HomeViewController” e tem um pequeno problema aqui. Nos cursos anteriores, nós estávamos utilizando o próprio device, o iPhone físico, para fazer alguns testes. Como estamos fazendo requisições utilizando o localhost, se tentarmos utilizar o iPhone, a requisição não vai funcionar, ele vai falhar.

[15:06] Tem algumas configurações que nós podemos fazer, que é utilizar o endereço de IP, enfim, tem algumas configurações a mais, mas não é o caso de nós utilizarmos ela aqui. Por isso, nesse curso vamos utilizar o simulador. Então temos aqui o método onde tira a foto.

[15:31] Nesse momento, nós vamos salvar o objeto no servidor. Aqui estamos salvando local, que também, a seguir, vamos fazer uma outra regra para só salvar local se caso der erro no servidor. A ideia é criarmos aqui let reciboService = ReciboService() e utilizarmos esse reciboService.post e enviar aqui (recibo). Eu vou dar um “Command + B”, para ver se tudo isso funcionou, vou buildar, vou subir aqui no simulador, e aí vamos então testar.

[16:28] A ideia é, quando clicarmos nesse botão “Registrar ponto”, abrirmos a câmera, porém, como eu disse, como não vamos utilizar o iPhone físico, vamos fazer o seguinte, eu vou passar toda essa implementação para lá, para ação daquele botão. Como não temos acesso à câmera no simulador, eu vou utilizar esse botão aqui registrar ponto. Nós não teremos a foto, mas nesse momento não tem problema. Onde tem foto passamos um foto: UIImage() vazio.

[17:07] Vou buildar o projeto de novo, vou colocar um breakpoint, só para ver se ele está caindo realmente nesse método. Cliquei em registrar, ele vai tentar fazer a requisição para o servidor, vou passar no breakpoint e, aqui, ele deu um erro, que é esse "App Transport Security Policy".

[17:35] Isso acontece porque, por segurança, o iOS não permite que realizemos requisições de forma http. Ele só permite se for https, que tem o fator de segurança a mais, mas como nós vamos utilizar apenas para testar, no próximo vídeo vamos aprender a mexer no "if.plist" para derrubar um pouco essa regra e conseguirmos testar a nossa requisição aqui no aplicativo.

@@02
Permitindo requisição http

[00:00] Nós acabamos de pegar uma mensagem de erro ao tentar salvar o recibo no servidor. A mensagem que ele nos traz aqui é que esse App security transport policy precisa de uma conexão segura. Então, como eu havia falado, quando trabalhamos com requisições com o endpoint dessa forma http, o iOS bloqueia esse tipo de requisição, por questões de segurança. O ideal seria que fosse https, que é a maioria das requisições. Você consegue fazer isso ao publicar, ao mexer no seu endpoint, no seu serviço de back-end.
[00:44] Nesse momento, como nós estamos fazendo apenas para teste, vamos incluir uma configuração no nosso “info.plist”, para que ele libere esse tipo de requisição. O ideal é que, se você for subir o projeto na Apple Store e tudo mais, você não precisa mais dessa configuração aqui no “info.plist”.

[01:06] Então vamos adicionar essa configuração para ele liberar requisições com http para conseguirmos testar então essa requisição. No “info.plist”, vamos adicionar uma nova configuração, essa configuração é do tipo transport security settings. Dessa forma que está aqui, ele, na verdade, é um dicionário. Então conseguimos adicionar aqui mais uma configuração.

[01:38] A configuração que eu vou adicionar é, justamente, essa primeira na lista da coluna esquerda do arquivo, allow arbitrary loads. Vou adicionar essa configuração e vou mudar, na coluna "Value", à direita, de no, para yes. Essa é a ideia. Com isso, teoricamente, já teríamos condição de fazer a requisição http.

[02:00] Então vou rodar o projeto mais uma vez, vou clicar aqui em “Registrar” e olha só que interessante, conseguimos printar. Deixa eu abrir aqui a classe reciboService. Conseguimos printar através desse print(json) que nós colocamos aqui, qual foi a resposta. Então ele devolveu "Status Code 200", que significa que funcionou. Ele devolve aqui o próprio objeto que salvamos.

[02:40] Com isso, significa que funcionou nossa requisição, mas para termos certeza que realmente funcionou, vou no Postman mais uma vez. Mudei no menu de opções, à esquerda do path, o verbo para GET e vou clicar em enviar. Então aqui nós temos acesso ao objeto que nós salvamos lá no nosso app.

[03:06] Vamos fazer mais um teste. Vou voltar no app e clicar de novo em “Registrar ponto”. Ele printou mais uma vez o objeto que salvamos. Agora, quando eu clicar em Send, no Postman, ele vai retornar dois objetos. então temos, na parte inferior da janela do Postman, dois objetos. Significa que a requisição que nós estamos fazendo no app está funcionando.

[03:32] Com isso, fechamos essa primeira etapa, ou seja, essa primeira requisição que nós fizemos. Ainda vamos mexer nesse retorno, mas o mais importante é que conseguimos de fato salvar isso no servidor.

@@03
Sincronização de informações

[00:00] Então nós acabamos de criar nossa primeira requisição e já certificamos de que está funcionando, através do Postman. Nós estamos testando com Postman. A ideia desse vídeo é falar um pouco sobre sincronização online, offline, quando que eu salvo no Core Data, quando que eu salvo no servidor. A ideia é eu dar algumas dicas para você e deixar até uma tarefa de casa, caso você queira fazer.
[00:32] Quando falamos de requisições http e sincronização, online e offline, o primeiro ponto é que tem diversas formas de se trabalhar com isso, a que eu vou mostrar é apenas uma delas. É legal falarmos disso, porque não tem assim uma única forma de fazer. Depende da regra de negócio do seu projeto, depende do que a sua equipe entrou em acordo. Então, como eu acabei de falar, é apenas uma sugestão.

[01:03] O que eu vou fazer? Eu vou utilizar esse recibo.salvar do contexto, ou seja, quando salvamos no Core Data, apenas quando a requisição falhar. Então, a ideia é trabalharmos com esse tipo de situação: quando falhar a requisição, eu salvo isso local. Eu vou mostrar como é que faz isso.

[01:26] Eu vou deixar uma tarefa, caso você queira fazer depois como desafio, que é, cada vez que o app inicializar, verificar se existe recibo salvo local, e você salvar isso no servidor. Então fazer uma lógica para verificar se existe registro local, se tiver você salva no servidor e exclui, para sempre ficar vazio. Então a ideia é salvar apenas quando precisar e, quando voltar a internet, no caso, você sincronizar com servidor. Seria essa ideia.

[02:05] Então o que eu vou fazer? Eu vou começar deixando isso como um atributo da classe. Vou vir aqui para cima e, logo abaixo de localização, eu vou criar um private lazy var reciboService = Reciboservice()Aqui em let, eu vou mudar para var, e utilizar somente o método post(). Fizemos esse primeiro ponto de refatoração.

[02:34] A segunda coisa importante de se falar é que precisamos, de alguma forma, saber se a requisição falhou ou não, para conseguirmos salvar esse objeto. Quando falamos disso, estamos falando de um conceito muito importante, que é fazer uma requisição, esperar a resposta, para depois executar alguma coisa. Então estamos falando de completion handle, ou bloco de completion, que nada mais é do que uma closure que nós vamos utilizar na assinatura do nosso método para conseguirmos fazer isso.

[03:14] Então eu vou voltar aqui na classe recibo service. Nós temos o método post, o que eu vou fazer aqui? Eu vou colocar uma vírgula depois de Recibo e vou utilizar um completion:.

[03:28] Eu vou utilizar depois dos <:> essa notação @escaping(), e dentro dos <()> nós podemos criar uma variável booleana para saber se foi salvo ou não. Se fosse em inglês, você poderia colocar isSave:, do tipo Bool. Como nós estamos trabalhando com escrita em português, eu sou um pouco ruim com variáveis em português, eu vou colocar salvo e fazemos um if. If salvo, fazemos alguma coisa, se for falsa significa que não foi salvo. Ao final, retornamos vazio, func post(_ recibo: Recibo, completion: @escaping(_salvo: Bool) -> Void) {.

[04:00] Então o que eu acabei de fazer aqui nada mais é do que uma closure. Nos cursos iniciais do Swift falamos um pouco disso.

[04:09] Na prática, o que que isso muda? Muda porque, quando eu volto no reciboService.post(recibo), em "HomerViewController.swift", vou até tentar dar mudar, apagando o último parênteses, mas ele vai dar falha. Se apagarmos o .post e escrevermos novamente, agora eu tenho o primeiro parâmetro, que continua igual, onde eu passo o recibo, e eu tenho segundo parâmetro que é uma closure. Então repara que eu tenho aqui uma função dentro da minha função.

[04:34] Se eu apertar o “Enter”, eu posso colocar um nome nessa variável, que eu vou chamar de salvo. Aqui eu consigo fazer uma verificação if salvo {}. Na verdade, se não for salvo, se não salvou, eu vou negar aqui. E o que eu vou fazer? Se isso não for salvo, eu vou salvar isso local, então vou utilizar aqui o recibo.salvar(self.contexto). Vamos só fazer um guard let para desembrulhar esse valor, contexto = self?.contexto else { return }. E eu passo esse contexto aqui embaixo, recibo.salvar(contexto). Deixa eu dar um “Command + B” para eu ver se vai rodar. Então se for salvo, eu salvo isso local.

[05:37] Só que tem uma configuração muito importante que nós precisamos fazer lá na classe reciboService, porque, relembrando, quando eu dou esse .post, ele vai executar a requisição, vai ficar preso nesse método, aguardando a resposta, para cair nesse bloco aqui. Então preciso disparar a resposta em algum momento dessa requisição. Eu preciso falar para ele funcionou ou não funcionou.

[06:07] Aqui nós havíamos colocado alguns ifs com print só para ver se a requisição realmente tinha funcionado. A ideia é agora verificar se ocorreu algum erro, então if error == nil, ou seja, se não tem erro, significa que salvou, então {completion()}. Esse completion, é essa variável aqui. Eu estou pegando ela da assinatura do método, então eu passo dentro do completation() como true. Significa que ele salvou. E eu dou um return.

[06:45] Se ele não entrar nesse if, eu dou um completion() e passou para ele como false. Significa que ocorreu uma falha na requisição, então eu preciso da resposta tanto se funcionou, quanto se não funcionou, senão ele vai ficar esperando eternamente a resposta daquele método. Isso é muito importante quando utilizamos uma closure, um bloco de completion handle, precisamos escapar o retorno de alguma maneira, tanto no sucesso quanto na falha.

[07:19] O que eu vou fazer? Eu vou vir aqui no Postman, só para verificar se nosso código continua funcionando. Se eu dar um “Send”, ele está retornando aqui um objeto. Eu vou apagar ele, vou pegar o id, “Command + C”, vou alterar para DELETE, vou colocar uma </> e o número do ID, e vou enviar. Agora vou apagar o ID do meu endpoint e vou mudar para GET de novo, para ver se realmente funcionou. Não está retornando nada.

[07:58] Agora eu vou voltar aqui no meu projeto no XCode, vou buildar de novo, clico em “Registrar ponto” e eu vou no Postman para ver se realmente salvou. Continua funcionando, nosso código, só que agora, com esse detalhe, só estamos utilizando nosso Core Data caso ocorra uma falha na requisição.

[08:23] Como eu disse no início do vídeo, você pode implementar como desafio, a tarefa de criar um método na inicialização do app para verificar se existe registro salvo e, se existir, você salva isso no servidor e apaga local. A ideia é deixar sempre sem nenhum registro salvo local, somente quando a requisição falhar. É uma forma de você evitar qualquer perda de informação do seu usuário, caso ele não tenha internet, ou caso ocorra algum problema.

[08:57] Lembrando é apenas um insight. É apenas uma forma de se trabalhar. Existem várias outras, mas a ideia desse vídeo foi justamente falar um pouco sobre essa sincronização.

@@04
Configuração de requisição local

Nesta aula, montamos nossa primeira requisição para salvar um registro de ponto. Por que foi necessário configurar o arquivo Info.plist?

Requisições HTTP consomem internet do aparelho do usuário, portanto, precisamos configurar o arquivo Info.plist para pedir autorização para realizar requisições.
 
Não precisamos pedir autorização do usuário para realizar requisições HTTP.
Alternativa correta
Através do arquivo Info.plist, setamos a url que será utilizada para configurar a requisição. Ou seja, na hora de consumir o serviço, utilizamos essa url.
 
Não é no arquivo Info.plist que configuramos a url que será utilizada na requisição.
Alternativa correta
Por motivos de segurança, qualquer requisição é bloqueada pelo iOS, por isso, precisamos configurar o arquivo Info.plist.
 
Não são todas requisições bloqueadas pelo iOS.
Alternativa correta
Por motivos de segurança de rede, o iOS possui um recurso que bloqueia requisições de protocolo do tipo HTTP. Porém, para testar o servidor local, precisamos desabilitar esse recurso através do arquivo Info.plist.
 
Alternativa correta! No arquivo Info.plist, desabilitamos esse recurso, setando a key Allow Arbitrary Loads para yes.

@@05
Faça como eu fiz: Requisição POST

Nesta aula, aprendemos a salvar um registro de ponto no servidor através de requisição HTTP. Configuramos o arquivo info.plist para habilitar requisições do tipo HTTP (o ideal são requisições do tipo HTTPS, pois possuem protocolo de segurança) e, em seguida, fizemos um teste por meio do Postman.
A partir disso, como podemos salvar um arquivo de ponto no servidor?

 DISCUTIR NO FORUM

 Para salvar um registro de ponto no servidor, podemos criar um método e configurar o body da requisição da seguinte maneira:
func post(_ recibo: Recibo, completion: @escaping(_ salvo: Bool) -> Void) {

        let baseURL = "http://localhost:8080/"
        let path = "recibos"

        let parametros: [String: Any] = [
            "data": FormatadorDeData().getData(recibo.data),
            "status": recibo.status,
            "localizacao": [
                "latitude": recibo.latitude,
                "longitude": recibo.longitude
            ]
        ]

        guard let body = try? JSONSerialization.data(withJSONObject: parametros, options: []) else { return }

        guard let url = URL(string: baseURL + path) else { return }

        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "POST"
        requisicao.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requisicao.httpBody = body

        URLSession.shared.dataTask(with: requisicao) { data, resposta, error in

            if error == nil {
                completion(true)

                return
            }

            completion(false)

        }.resume()
    }

@@06
O que aprendemos?

Nesta aula, aprendemos como criar uma requisição do tipo POST para salvar informações no servidor.
Também usamos o postman para certificar que as informações foram salvas.

#### 01/09/2023

@04-Método GET

@@01
Projeto da aula anterior

Se você deseja começar o curso a partir desta aula, pode fazer o download do projeto desenvolvido até o momento.

https://github.com/alura-cursos/2317-alura-ponto-sync/archive/8bf81317986e1856049c9538f106641d20e08063.zip

@@02
Recuperando informações

[00:00] Continuando. Nós fizemos a nossa primeira requisição através da classe URLRequest, então essa é a forma nativa de trabalharmos com requisições aqui no Swift. A ideia desse vídeo é nós continuarmos com as nossas requisições. Nós só temos uma (requisição), até agora, que é essa POST, onde nós estamos salvando o recibo. A ideia é continuarmos nossa implementação, só que, a partir de agora, vamos utilizar um framework para nos ajudar com as requisições. Então você verá que é uma forma bem mais simplificada de se trabalhar.
[00:41] Eu vou abrir aqui o navegador, e o framework que nós vamos utilizar é o Alamofire. Ele é famoso na comunidade, muitas empresas utilizam pela facilidade, pela manutenção, pela atualização que os desenvolvedores dão, o suporte, então é um framework bem bacana.

[01:04] Vamos utilizar ele através do swift package manager, então veremos nesta página onde é que está a seção de instalação. Aqui embaixo nós temos algumas formas de instalação: através do Cocoapods, que também é um gerenciador de dependências, o Carthage e nós vamos utilizar o swift package manager, porque é uma forma mais rápida de instalarmos essa lib e você verá que é bem tranquilo.

[01:35] Então o que que precisamos fazer? Eu vou copiar aqui essa URL, então “https://github.com/Alamofire/Alamofire.git”, e que que vamos fazer? Eu vou vir aqui no projeto, na barra superior vou clicar em “File” e eu tenho aqui essa opção “Swift Packages”. Então eu vou clicar aqui em “Add Package Dependency”, adicionar uma nova dependência.

[02:03] O que eu preciso colocar aqui? Eu preciso colocar a URL que nós acabamos de copiar. Então vou dar um “Command + V”, vou dar um next, e vou dar um next novamente. Ele vai instalar para nós o Alamofire, vou clicar em finalizar, nós já temos então o AlamoFire como dependência do nosso projeto. Se você notar aqui na parte inferior, ele mostra quais são as dependências adicionadas com o swift package manager.

[02:39] Dito isso, agora já pode utilizar, então eu vou voltar aqui na nossa classe ReciboService, e criar então um novo método. Então vamos lá, eu vou criar aqui em cima da func post(), porque como vai ser GET, eu vou chamar esse método aqui de func get(){}.

[03:00] Então, a princípio, já vamos utilizar o Alamofire. Como é que eu faço então para utilizar? Eu preciso primeiro importar, então vou importar o Alamofire e já posso utilizar. Se você ler depois, com calma, aqui na página do GitHub tem toda documentação, como é que utiliza, tem várias funcionalidades. Depois você pode explorar aqui que tem bastante conteúdo bacana.

[03:27] Para utilizarmos, então, eu vou começar chamando ele, AF.request. Aqui ele vai me dar algumas opções. Eu vou começar digitando e depois eu vou incrementando com os que eu preciso.

[03:39] Primeiro passamos aqui a URL, então nós já temos aqui a URL, eu vou copiar, vou colocar ele aqui, /recibos, (“https://localhost:8000/recibos”). Depois precisamos configurar algumas coisas, assim como nós fizemos quando nós trabalhamos com as classes nativas. O que eu preciso configurar? Primeiro o método. Como nós vamos recuperar um recurso, eu quero listar os recibos, então o método vai ser GET, , method: .get,. Como ele é um enum, eu dou um .get.

[04:17] Depois disso precisamos configurar o header:[]. Então eu vou chamar o header depois do método, abro e fecho colchetes, e dentro dos [] eu preciso passar o mesmo tipo que nós fizemos basicamente no nosso post. Só que no get eu vou colocar ”Accept”: e o tipo do valor que eu quero, que é esse ”application/json”. No post colocamos Content-Type e aqui nós estamos colocando o ["Accept": "application/json"].

[04:51] Depois disso, eu vou utilizar o tipo de resposta que eu quero. Eu quero que ele me devolva a resposta como JSON, então vou dar um response.JSON{}. O que eu preciso configurar? Eu tenho acesso à resposta, então basicamente é isso.

[05:12] Só que como nós vimos, uma requisição pode ter o caso de sucesso ou o caso de falha. Então nós precisamos, na verdade, fazer uma verificação. Se deu sucesso, fazemos o que devemos fazer. Se der falha, podemos ver o erro e pode mostrar uma tela de erro para o usuário, algo do tipo um alert controller. Então é importante diferenciar esses dois casos, e como é que eu faço isso? Através de um switch.

[05:39] Então se for o caso, na verdade, aqui precisamos ter acesso ao response.result, então o que eu vou fazer? Um switch resposta.result{}, no caso. Dentro das {} temos alguns casos, então case .sucess(let json): eu preciso ter aceso ao json, vou colocar aqui um break, só para testarmos. Vou colocar um if let antes do break. Vou colocar, por exemplo, if let listaDeRecibos = json as? e aqui eu converto para um array de dicionário de [[String: Any]]. Como ele pode vir uma lista, então precisa ser um array de dicionário.

[06:31] Se ele entrar aqui, eu tenho acesso à lista de recibos, então eu dou um print(listaDeRecibos) da lista de recibos. Agora eu não vou precisar desse break. Temos o caso, na verdade, eu vou deixar o break aqui no final do sucessp. Agora temos o caso da falha. Caso falha, temos acesso ao erro. E o que podemos fazer? Podemos verificar qual que é o erro: case .failure(let error): print(error.localizeDescription). Depois do print() eu coloco também um break.

[07:04] Feito isso podemos então chamar esse método em algum lugar para testarmos. Então eu virei na classe ReciboViewController, que é onde nós utilizamos a listagem, e eu vou criar um método chamado get. Nós já temos aqui, na verdade, um método chamado get recibos.

[07:28] O que eu vou fazer aqui? Eu vou criar uma variável, igual nós temos no HomeViewController, para termos acesso ao ReciboService(). Então vou copiar ela do "HomeViewController", vou utilizar ela no "ReciboViewController", e aqui em getRecibos(), o que eu vou fazer? Eu vou pegar esse reciboService.get(). Com isso, já podemos verificar se nós já estamos conseguindo ter acesso aos recibos.

[08:04] Eu vou abrir aqui o Postman só para verificarmos se realmente temos algum recibo salvo. Vamos ver, já estou aqui com ele no verbo GET, a URL é essa mesma, o header já está configurado com content-type JSON. Então vamos lá. Cliquei aqui e ele está me trazendo, sim, um recibo. Então, teoricamente, deveríamos ter acesso a esse mesmo recibo lá no nosso aplicativo.

[08:36] Para testarmos, eu vou colocar um breakpoint no caso de sucesso, ou seja, eu vou parar a execução do meu programa na linha 17, para vermos qual é o retorno. Se realmente é sucesso ou falha. Deixa eu fechar aqui que eu tenho dois simuladores, então vou dar quit, vou subir o simulador do iPhone 12. Vamos fazer esse teste.

[09:09] Como você pode ver, repara que a sintaxe do Alamofire é muito mais enxuta do que da forma nativa. Eu deixei aqui só para compararmos. É bem mais trabalhoso, então ele é bem mais rápido de se escrever requisições.

[09:27] Apaguei aqui o Console. Agora eu vou clicar em recibos. Aqui ele ainda está mostrando os dados recuperados do Core Data. Não tem problema, vou apagar aqui mais uma vez e vou passar para linha de baixo para verificarmos qual é a lista de recibos que temos.

[09:49] Então eu vou clicar nesse quarto botão da barra inferior. Cliquei aqui mais uma vez no mesmo botão. Então nós já estamos conseguindo recuperar os mesmos recibos que nós temos salvos no servidor. Se você comparar, é exatamente o mesmo. Vou tirar o breakpoint da linha 17, então eu clico e arrasto para fora, e vou clicar em continuar no Console, para continuar a execução do meu programa.

[10:19] Nós já estamos conseguindo recuperar os recibos. O próximo passo é refatorarmos o view controller de recibo para exibir somente os recibos que vem do servidor.

@@03
Desserialização de objeto

[00:00] De volta com o nosso projeto. Nós acabamos de conseguir ler os objetos salvos no servidor a partir do nosso app, já debugamos aqui, vimos que está sendo retornado todos os objetos que precisamos. Agora falta transformarmos esses objetos em objeto Recibo para conseguirmos utilizar na listagem de recibos. Nós estamos utilizando o Core Data, por enquanto, para listar os objetos salvos local, mas nós vamos trocar isso para que ele liste todos os objetos salvos no servidor.
[00:39] Então vamos lá, o que eu preciso fazer aqui? Eu preciso transformar o retorno que vem da API em objeto do tipo Recibo. Eu preciso guardar esses objetos em algum lugar, então para isso vou criar aqui uma lista que eu vou chamar de recibos, que é do tipo uma lista de Recibos, e eu vou inicializar ela vazia, var recibos: [Recibos] = [].

[01:05] Depois disso, nós já temos aqui dentro desse if let, acesso à lista que o servidor nos retorna, então o que precisamos fazer? Precisamos percorrer toda essa lista. Então eu vou criar depois do if let um for, que eu vou chamar de recibo. Como é um dicionário, vou colocar for reciboDict in listaDeRecibos{}, então ele vai percorrer toda essa lista.

[01:31] A ideia, então, é adicionarmos os recibos. Por exemplo, eu pego a lista que eu criei, recibos.append(newElement: Recibo), e eu vou adicionar um novo recibo. Como é que eu vou criar esse recibo? Eu vou fazer o seguinte: dentro desse for, eu vou criar um if let novoRecibo, e vou criar um método dentro da própria classe Recibo, que vai se chamar, serializa(), onde eu vou passar então esse reciboDict, que nós estamos percorrendo aqui dentro.

[02:13] E esse novo recibo eu vou adicionar aqui recibos.append(novoRecibo). Então ele vai reclamar, porque ainda não existe esse método serializa. Nós vamos criá-lo agora, então dentro da classe recibo, eu vou criar um novo método. Repara que aqui nós não estamos instanciando o recibo, nós já estamos chamando direto o método, então para utilizamos o método dessa forma, vou criar aqui uma class func, que eu vou chamar de serializa(), eu vou receber um _ json: [String: Any] e eu vou devolver um recibo opcional class func serializa(_ json: [String: Any]) -> Recibo?.

[03:01] Que é importante fazermos aqui? Vamos ter que pegar todas as chaves do JSON que a API nos retorna e transformar isso em algumas variáveis para, depois, criar o objeto Recibo. Então vou começar com a data. A data eu vou receber no formato de string, e eu preciso converter isso para formato de data, que é o que nós estamos utilizando aqui. Se você for analisar, essa variável data, é do tipo date, então nós vamos ter que vir aqui na classe que nós temos de formatador de data. Nenhuma dela nos retorna esse formato de data, os dois métodos que nós temos retorna o formato de string.

[03:51] Então vou criar aqui um novo método. Vou chamar de func getData mesmo. A diferença é que eu vou receber a data do tipo string e eu vou devolver a data do tipo date, que esse é o casting que precisamos fazer, (_ data: String) → Date {}. Eu vou precisar aqui dessas três linhas que nós já temos que vai ser quase que igual.

[04:18] E o que eu vou fazer? A diferença é que no return, eu vou mudar esse método do formatador. Então vou retornar aqui o método do formatador, só que, em vez de string ,eu vou chamar o date return formatador.date(from: ), onde eu vou passar então a data que eu estou recebendo aqui por parâmetro.

[04:40] Então eu vou passar aqui a data: String() dessa forma conseguimos converter uma string para data. Aqui ele está reclamando porque ele pode conseguir ou não, então vou deixar o retorno desse método como opcional -> Date?{}.

[04:58] Então vamos voltar agora para a classe recibo e o que vamos fazer? Vamos começar a fazer a serialização do nosso objeto. Então vou começar com a data. Vou criar aqui um guard let, vou chamar de dataString = json[], que nós temos na assinatura do nosso método, vou acessar a propriedade ”data” e eu vou converter ela para as? String. Quando pegamos o valor dessa chave, ele não tem tipagem, por isso que temos que ficar convertendo para o tipo queremos trabalhar. Se eu não conseguir, vou dar um else {return nil}, porque podemos retornar o objeto nil.

[05:45] Eu vou aproveitar aqui e já vou criar uma outra verificação, que vai ser a data. Dentro do mesmo lugar de let data, podemos ter várias verificações. Aqui eu vou chamar de data mesmo, e eu vou utilizar o = FormatadorDeData(). Eu vou dar o .getData(),, só que agora eu vou precisar dessa que retorna o formato de data, que é o que nós acabamos de criar.

[06:10] Eu vou passar aqui a dataString, nós temos aqui também a data e, por último, eu vou criar aqui o let status = json[“status”] as? Bool. Vou acessar a chave, propriedade status e vou converter isso para um booleano, que é o que nós precisamos aqui no status.

[06:40] O próximo passo, então, é nós trabalharmos com a localização. É importante falar, nesse momento, porque a localização. Como nós não estamos testando isso em device físico, nós estamos testando no simulador, a localização, tanto latitude, quanto longitude, está vindo como "0". Porque o intuito desse curso é, de fato, praticarmos e entender como é que funciona uma requisição, mas partindo do pressuposto que nós estamos trabalhando com servidor publicado na nuvem, você teria acesso ao seu iPhone. Então você poderia utilizar a localização do seu iPhone, mas nesse caso ele virá como zero.

[07:23] Então vamos pegar aqui a latitude e longitude, guard let. Só que antes eu preciso acessar a chave localização, então eu vou criar aqui uma localizacao =, vou acessar aqui o json[“localizacao”], que é um dicionário de string, as? [String: Any]. Se ele não conseguir, else { return nil }.

[07:53] Com isso já temos a acesso a latitude e longitude, então vou criar aqui let latitude =, vou pegar a localizacao que nós temos aqui em cima, vou acessar a chave [“latitude”], vou tentar converter isso para as? Double ??. Se tiver nil, ou não tiver valor, eu ponho um valor fixo que é 0.0. Mesma coisa com a let longitude = localizacao[“longitude”] as? Double ?? 0.0. Eu tento verificar o valor se não tiver valor eu seto o 0.0.

[08:32] Depois de tudo isso podemos então dar o return Recibo(), então eu vou inicializar passando os atributos que nós precisamos, que é o status: status, data: data, foto: UIImage(), latitude: latitude, longitude: longitude. Não estamos trabalhando com foto, então vou passar UIImage(). Latitude nós já temos, longitude também temos e, com isso, nós já temos então acesso ao objeto em si.

[09:03] O que eu vou fazer? Eu vou vir aqui na nossa classe ReciboService, vou dar um “Command + B”, para ver se ele está buildando, aqui é um if let. Está faltando a chave dele, então eu coloco esse recibo aqui dentro recibos.append(novoRecibo). Depois desse for, eu vou dar um print() dessa lista de recibos para ver realmente já serializamos todos os recibos. Vou rodar o projeto e vou clicar em recibo.

[09:52] Então vamos lá, vou ver aqui se temos acesso. Virei aqui pelo terminal, po print recibos. Olha só, nós temos aqui a data, foto nós estamos instanciando uma que não tem valor nenhum, temos acesso ao ID, 95013F. Vamos ver se é o mesmo que tem aqui no Postman, 254a49. Aqui temos um seguinte problema, vou voltar aqui na classe recibo. O ID, por enquanto, nós não estamos serializando. Nós estamos instanciando um e o ID, então por isso que o ID não está igual. No próximo capítulo, onde nós vamos aprender a deletar o recibo, vamos precisar do ID correto, então vamos ter que mexer lá.

[10:55] O importante é que a data está correta, 22/10/2021 06:34. Aqui está diferente o horário, por causa do formato da data, mas a data está correta. Nós já temos aqui o status que ele recuperou do servidor. O status está verdadeiro, então aqui ele está retornando como 1, no caso booleano. Nós temos acesso, então, às informações que o servidor nos devolve.

[11:36] Vou retirar aqui o breakpoint, vou soltar a execução do programa, e vou tirar esse print(). A seguir, quais serão os passos que nós temos que fazer? Precisamos retornar essa lista de objetos, para o view controller. Então vamos criar uma closure parecida com a que nós fizemos aqui, retornando a lista, e vamos ter que refatorar a view controller de recibo.

[12:02] Uma outra abordagem para trabalhar com a serialização, é utilizando o protocolo Codable, que é muito utilizado. Temos até um curso aqui em que utilizamos esse protocolo. Porque eu não utilizei nesse caso? Porque nós estamos utilizando essa classe do Core Data. Então precisamos fazer vários passos a mais para conseguirmos mapear esse protocolo aqui dentro do projeto. Para não estender tanto, fizemos a serialização da forma comum, que é acessando as chaves do JSON que o servidor nos retorna. A seguir, continuamos com a refatoração do view controller de recibo.

@@04
Refatorando a listagem

[00:00] Continuando, agora que nós já serializamos o objeto, nós precisamos retornar no "ReciboViewController". Nós temos aqui o método getRecibos e nós precisamos ter acesso aos recibos que o servidor nos retornou para utilizarmos aqui nesse view controller.
[00:22] Então o que eu vou fazer? Eu vou criar uma nova variável, que vai se chamar private var recibos: que é a lista que nós temos de recibos, [Recibo] = []. A ideia é obtermos essa lista serializada para listarmos aqui.

[00:46] Por isso, vamos ter que voltar na nossa classe ReciboService e alterar a assinatura desse método. Eu vou precisar, então, de receber de volta a lista de recibos que nós criamos aqui. Nós precisamos dessa lista lá no "ReciboViewController", e nós fazer isso, novamente, através de uma closure.

[01:09] Então eu vou criar aqui um bloco func get(completion:) handle que vai ser a lista de recibos. Na verdade, aqui é uma lista opcional de recibos, @escaping(_ recibos:[Recibo]?, . Nós também podemos ter um erro caso não consigamos obter essa lista _ error: Error?) -> Void) e aqui é o retorno void.

[01:41] Primeira coisa que temos que fazer é, depois que ele passar pelo for e adicionar todos os recibos, podemos chamar então esse completion(). Significa que temos a lista de recibos e não temos erro, recibos, nil. Por isso estou passando nil no segundo parâmetro, que é o parâmetro de erro. No caso da falha, é ao contrário. Então eu vou apagar aqui esse bloco de print() e vou chamar o bloco completion(). Aqui é ao contrário, não temos a lista de recibo, mas nós temos o erro.

[02:16] Com isso podemos voltar aqui no nosso “ReciboViewController” e eu vou chamar de novo aqui o método reciboService.get{ [weak self] resposta, error in }. Agora ele está um pouco diferente. Podemos ter aqui, na verdade, os recibos, que é no caso, a resposta do servidor, e podemos ter aqui o erro.

[02:44] Vou verificar se estamos com erro, ou seja, se a requisição falhou, se eu estou sem internet. Caso ocorra algum desses problemas, eu posso ter um erro, então vou verificar aqui. Se o erro for igual a nil, significa que eu não tenho erro if error == nil{}, e eu posso ter então acesso aos recibos. Como eu estou retornando opcional, vou criar aqui um guard let recibos = resposta else { return }. Eu desembrulho isso com segurança e dou return aqui.

[03:18] Então vou pegar aqui o self?.recibos = recibos, é igual a essa constante de recibos que eu tenho aqui. Depois que eu obter essa lista, eu posso recarregar para a TableView, então posso pegar aqui self?.reciboTableView.reloadData() e vou recarregar. Basicamente é isso.

[03:40] Agora, o que precisamos fazer, precisamos tirar a parte que nós utilizamos aqui do Core Data. Nós temos esse buscador, essas coisas não vamos mais utilizar. Vamos utilizar apenas a listagem do servidor, então vou apagar esse buscador, vou dar “Command + B”. Vou apagar aqui algumas coisas que não vamos mais utilizar, relacionado ao buscador.

[04:06] Esse método carregar local, nós não vamos mais utilizar. Agora a parte principal, porque aqui utilizávamos o buscador. A partir de agora, nós vamos utilizar essa variável que criamos aqui na linha 25, que é a variável recibos. Então eu vou pegar recibos.count o número de linhas do tableView.

[04:36] Ao invés do buscador no let recibo, nós também vamos utilizar o recibo, então let recibo = recibos[indexPath.row]. Aqui no didSelectRow, quando clicamos em um recibo para ele abrir o mapa, também vamos refatorar. Não temos o buscador, mas temos o array de recibos recibos[indexPath.row].

[05:01] E, por último, na hora de deletar um recibo, nós temos agora a nossa lista de recibos[index] na posição index, que ele retorna aqui para nós, vou dar um “Command + B”. Ele está reclamando. Na verdade, nós não temos mais uma lista opcional, então vou fazer o seguinte, vou tirar esse guard, esse else return e vou deixar assim. Vou dar um “Command + B”. Agora ele está buildando.

[05:37] Porém, ainda precisamos apagar algumas coisas, como esse protocolo que nós implementamos no buscador. Então eu vou apagar ele aqui. Deixa eu ver se sobrou mais coisa. O contexto. Deixa eu ver se eu utilizo ele em algum lugar. Eu vou apagar e vou dar um “Command + B”. Deixa eu ver, ele usa para deletar. Como no próximo capítulo vamos deletar através do servidor, então eu também vou apagar essa linha aqui e vou dar um “Command + B”. Ele já está buildando.

[06:19] Então vamos fazer esse teste. Virei aqui em Postman, no método GET, e eu vou rodar. Repara que ele está retornando apenas um objeto do tipo recibo. Agora vamos testar no nosso simulador. Vou clicar em recibos. Olha só que bacana, temos já um recibo sincronizado com servidor, com os dados que colocamos.

[06:47] Eu vou adicionar mais um. Então vou mudar aqui o verbo para POST. Vamos salvar mais um recibo. No "Body", eu vou mudar a data. Vou por “08:40”. Vou mandar rodar, virei aqui no GET e agora nós temos dois recibos. Vamos ver se está refletindo aqui no nosso aplicativo. Vou rodar de novo, clico em recibos, então nós já estamos conseguindo listar os recibos do servidor no nosso aplicativo. Como eu havia conversado anteriormente, agora precisamos ir para o último método que é um método DELETE.

@@05
Requisições com Alamofire

Conforme vimos na aula, quando apagamos o app, havíamos perdido todos os alunos. Porém, eles estavam salvos no servidor. Para recuperar os alunos, utilizamos o Alamofire para implementar uma requisição.
Sobre o Alamofire, assinale as alternativas que explicam corretamente cada parâmetro destacado na imagem abaixo:

AF.request("", method: HTTPMethod, parameters: Encodable?, headers: HTTPHeaders?)

Método ou Verbo da requisição: Métodos que utilizamos para se comunicar com o servidor (GET, PATCH, PUT, POST, DELETE).
 
Alternativa correta! Para se comunicar com o servidor, precisamos especificar qual o método da requisição.
Alternativa correta
Headers ou Cabeçalho: Através do header, mandamos os parâmetros para o servidor.
 
Alternativa correta
URL: Caminho que passamos para a requisição enviar o pedido ao servidor.
 
Alternativa correta
Parâmetros: Informações que enviamos pelo corpo da requisição para o servidor.
 
Alternativa correta! Podemos configurar informações como Authorization-Token e Content-Type por meio do header da requisição.

@@06
Faça como eu fiz: Usando o Alamofire

Na aula anterior, vimos que é trabalhoso criar uma requisição HTTP usando as classes nativas do Swift. Por isso, neste momento, abordamos uma biblioteca muito utilizada pela comunidade que é o Alamofire.
Como podemos criar uma requisição utilizando o Alamofire?

Depois de importar o Alamofire, podemos criar uma requisição, por meio do código a seguir:
func get(completion: @escaping(_ recibos: [Recibo]?, _ error: Error?) -> Void) {
        AF.request("http://localhost:8080/recibos", method: .get, headers: ["Accept": "application/json"]).responseJSON { resposta in
            switch resposta.result {
            case .success(let json):

                break
            case .failure(let error):

                break
            }
        }
    }

07
O que aprendemos?

Nesta aula, aprendemos a utilizar o Swift Package Manager para gerenciar as dependências do projeto.
Em seguida, vimos como instalar o Alamofire e como configurar uma requisição, usando o Alamofire.