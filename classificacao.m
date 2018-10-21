% function g = treinamento(g)
% 
%     %FASE DE CLASSIFICACAO
% 
%     for i=1:length(g.nos_test)
%         aux = 1;
%         mincost = max(g.nos_tre(aux).custo, distanciaEuclidiana(g.nos_tre(aux).estado,g.nos_test(i).estado));
%         g.nos_test(i).classe = g.nos_tre(aux).classe;
%         g.nos_test(i).pai = g.nos_tre(aux);
% 
%         %Nao estou usando z_linha
%         %while aux < length(z_linha) && mincost > g.nos_tre(aux+1).custo
%         while aux < length(g.nos_tre) && mincost > g.nos_tre(aux+1).custo
%            tmp = max(g.nos_tre(aux+1).custo, distanciaEuclidiana(g.nos_tre(aux+1).estado,g.nos_test(i).estado));
%            if tmp < mincost
%               mincost = tmp;
%               g.nos_test(i).classe = g.nos_tre(aux+1).classe;
%               g.nos_test(i).pai = g.nos_tre(aux+1); 
%            end
%            aux = aux + 1;
% 
%         end
%     end
% 
% end
function g = classificacao(g)

    %FASE DE CLASSIFICACAO
    for i=1:size(g.nos_test,2)
        minimo = intmax;
        classe = [];
        pai = [];
        for j=1:size(g.nos_tre,2)
            mincost = max(g.nos_tre(j).custo, distanciaEuclidiana(g.nos_tre(j).estado,g.nos_test(i).estado));
            if mincost < minimo
                minimo = mincost;
                pai = g.nos_tre(j);
                classe = g.nos_tre(j).classe;
            end
        end
        g.nos_test(i).pai = pai;
        g.nos_test(i).classe = classe;
    end

end