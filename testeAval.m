function [erro] = testeAval(g)
    
    qtd_classes = g.qtd_classes;
     % Funcao que retorna a taxa de acerto por realizacao

    e = zeros(qtd_classes, 2);
    classes = unique(g.classe_aval, 'rows');
    %Falsos positivos e negativos
    FP = zeros(qtd_classes, 1);
    FN = zeros(qtd_classes, 1);
    N = zeros(qtd_classes, 1);
    
    for k=1:qtd_classes
        for j=1:size(g.nos_aval, 2)
            if isequal(g.classe_aval(j,:), classes(k,:))
                N(k) = N(k) + 1;
            end
        end
    end
    
    for i=1:qtd_classes
        for j=1:size(g.nos_aval, 2)
            %classes i que sao iguais da j
            classes(i,:);
            g.classe_aval(j,:);
            if ~isequal(classes(i,:), g.classe_aval(j,:))
                if isequal(g.nos_aval(j).classe, classes(i,:))
                    FP(i) = FP(i) + 1;
                end
            %classes i que sao diferentes da j    
            else
                if ~isequal(g.nos_aval(j).classe, classes(i,:))
                   FN(i) = FN(i) + 1; 
                end
            end
        end

        e(i, 1) = FP(i)/(size(g.nos_aval, 2) - N(i));
        e(i, 2) = FN(i)/N(i);
        E(i) = e(i, 1) + e(i, 2);
        
    end

    acc = (1 - (sum(E)/(2*qtd_classes)));
    
    erro = 1 - acc;

end