function g = aprendizado(g)
    %FASE TREINAMENTO OPF
    fila_2 = filaPrioridade([]);

    %Inicializa o 'maps' e insere os prototipos na fila de prioridade
    for i=1:size(g.nos_tre,2)
        if g.nos_tre(i).prototipo ~= true
            g.nos_tre(i).custo = intmax;
        else
            g.nos_tre(i).custo = 0;
            g.nos_tre(i).pai = 0;
            
        end
        fila_2 = fila_2.adiciona(g.nos_tre(i));
    end

    %Laço while computa um caminho otimo do conjunto de prototipos para toda
    %outra amostra em uma ordem nao decrescente de custo minimo

    %em cada iteraçao um caminho de custo minimo eh obtido em P quando
    %removemos o seu ultimo no s da fila 
    while ~isempty(fila_2.lista)
        [fila_2, u] = fila_2.removeCusto();

        for i=1:size(g.nos_tre,2)
            if g.nos_tre(i).id ~= u.id && g.nos_tre(i).custo > u.custo
                cst = max(u.custo, g.matriz_adj(g.nos_tre(i).id, u.id));
                %Avalia se um caminho que alcanca um no adjacente g.nos_tre(i)
                %atraves de u eh menos custoso do que o caminho atual com
                %termino g.nos_tre(i)
 
                if cst < g.nos_tre(i).custo
                   %Verdadeiro quando g.nos_tre(i) pertence a fila
                   g.nos_tre(i).pai = u;
                   g.nos_tre(i).classe = u.classe;
                   g.nos_tre(i).custo = cst;
                   fila_2 = fila_2.atualiza_custo(g.nos_tre(i).id, cst); 
                end
            end
        end

    end
    
    g = atribuiFilhos(g);
    %chamada para plotar a floresta de caminho otimo
    %saida2D(g)
end

% G = digraph(1,2:5);
% G = addedge(G,2,6:15);
% G = addedge(G,15,16:20)