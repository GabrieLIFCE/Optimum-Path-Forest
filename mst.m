function g = mst(g)
%Retorna S - Conjunto de prototipos

%Caminharemos na MST, ao encontrarmos nos prototipos de classes
%diferentes, os definiremos como prototipos. Eles serao as raizes
%das arvores de influencia.

%Estabelecendo as chaves como "infinito"
for i = 1:size(g.nos_tre, 2)
    g.nos_tre(i).chave = intmax;
end    

%no raiz da MST escolhido aleatoriamente
indice_rand  =  randi(size(g.nos_tre,2));
g.nos_tre(indice_rand).chave = 0;

%Cria a fila de prioridade
fila = filaPrioridade(g.nos_tre);


while(~isempty(fila.lista))
%     fila.lista
    %Retorna o objeto sem o no e tambem retorna o no retirado
   [fila, u] = fila.removeChave();
   for i = 1:size(g.nos_tre,2)
       %No adjacente com indice i 
%        contem = fila.contem(g.nos_tre(i))
       if(u.id ~= i && g.matriz_adj(u.id,i) < g.nos_tre(i).chave && fila.contem(g.nos_tre(i)))
           g.nos_tre(i).pai = u;
%            g.nos_tre(u.id).filho = g.nos_tre(i);
           g.nos_tre(i).chave = g.matriz_adj(u.id,i);
           fila = fila.atualiza_chave(i, g.matriz_adj(u.id,i)); 
       end
   end
end

end

