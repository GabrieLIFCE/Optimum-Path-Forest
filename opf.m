function [ans1, ans2, t_nos_tre, t_nos_podados, taxa_nos_podados] = opf(nome_base, qtde_atributos, alpha)

    tic;
    [dados, classe] = readfile(nome_base, qtde_atributos);
    qtd_classes = size(unique(classe), 1);
    dados = nomaliza_opf(dados);
    %Renomeia as classes em vetores de 0s e 1s
    dados = label_classes(dados, classe);
    %dados  = dados(randperm(size(dados,1)),:);

    %Embaralha os dados
    dados = embaralha(dados);

    %Normaliza os dados
    %dados = normalize(dados);
    %dados = normaliza(dados);
    

    %[dados_tre,dados_test,classe_tre,classe_test] = divide_dados(dados, 10, 80)
    [dados_tre,dados_aval,dados_test,classe_tre,classe_aval,classe_test] = divide_dados_avaliacao(dados, qtde_atributos, 60,20);  %n_atributos, porcentagem_treino, porcentagem_avaliacao)  
    
%%
    
    %Instanciando a classe Grafo e No
    g = grafo;
    for i=1:size(dados_tre,1)
        no_aux = no;
        no_aux.estado = dados_tre(i,:);
        no_aux.id = i;
        no_aux.classe = classe_tre(i,:);
        no_aux.pai = 0;
        no_aux.prototipo = false;
       
        g.nos_tre = [g.nos_tre no_aux];
    end
    aux_id = i + 1;
    
    for j=1:size(dados_aval,1)
        no_aux = no;
        no_aux.estado = dados_aval(j,:);
        no_aux.id = aux_id;
        %no_aux.classe = classe_aval(j,:);
        no_aux.pai = 0;
        no_aux.prototipo = false;
       
        g.nos_aval = [g.nos_aval no_aux];
        aux_id = aux_id + 1;
    end
    aux_id = i + j + 1;

    for k=1:size(dados_test,1)
        no_aux = no;
        no_aux.estado = dados_test(k,:);
        no_aux.id = aux_id;
        no_aux.pai = 0;
        no_aux.prototipo = false;
       
        g.nos_test = [g.nos_test no_aux];
        aux_id = aux_id + 1;
    end
    g.qtd_classes = qtd_classes;
    g.classe_aval = classe_aval;
    g.classe_test = classe_test;
    g.qtd_nos_tre_inicial = size(g.nos_tre,2);
    
    %Cria uma matrix de zeros de dimensao |treinamento|x|treinamento|
    g.matriz_adj = zeros(size(dados_tre,1), size(dados_tre,1));

    %Calcula a distancia Euclidiana e armazena na matriz
    for i = 1:size(dados_tre,1)
        no1 = g.nos_tre(i);
        for j = 1:size(dados_tre,1)
            no2 = g.nos_tre(j);
            if i>j
                aux = distanciaEuclidiana(no1.estado,no2.estado);
                g.matriz_adj(i,j) = aux;
                g.matriz_adj(j,i) = aux;
            end
        end
    end
    
    %Chamada de funcoes
    g = mst(g); %calcula a MST
    g = prototipo(g); %define os prototipos
    g = aprendizado(g); %fase do OPF
       
    tic;
    g = classificacao(g); %classifica amostras de teste
    t_nos_tre = toc;
    
    %acuracia nao podado
    ans1 = teste(g, classe_test, qtd_classes);
    
    g = poda(g, alpha);
   
    %classifica novamente 
    tic
    g = classificacao(g);
    t_nos_podados = toc;
    %retorna a taxa de acerto 
    
    %acuracia podado
    ans2 = teste(g, classe_test, qtd_classes);
    
    taxa_nos_podados = (1 - (size(g.nos_tre,2)/g.qtd_nos_tre_inicial))*100;

end
