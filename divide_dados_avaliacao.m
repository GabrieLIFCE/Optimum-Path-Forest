function [ dados_tre,dados_aval,dados_test,classe_trei,classe_aval,classe_test ] = divide_dados_avaliacao( dados, n_atributos, porcentagem_treino, porcentagem_avaliacao)
%ENTRADA: dados

%Dimens�o da matriz
[n_linhas, n_colunas] = size(dados);

%Tamanho do treinamento
n_trei = floor((porcentagem_treino/100) * n_linhas);
n_aval = floor((porcentagem_avaliacao/100) * n_linhas);

%Tamanho do teste
dados_tre = dados(1:n_trei,1:n_atributos);
dados_aval = dados(n_trei+1:n_trei+n_aval,1:n_atributos);
dados_test = dados(n_trei+n_aval+1:end,1:n_atributos);

classe_trei = dados(1:n_trei, n_atributos+1:n_colunas);
classe_aval = dados(n_trei+1:n_trei+n_aval, n_atributos+1:n_colunas);
classe_test = dados(n_trei+n_aval+1:end, n_atributos+1:n_colunas);

end

