function [dados_normalizados] = nomaliza_opf(dados)

    for i=1:size(dados,2)

        media(i) = mean(dados(:,i));
        desvio(i) = sqrt(sum(((dados(:,i)-media(i)).^2))/size(dados,1));
        if desvio(i) == 0
            desvio(i) = 1;
        end
    %     desvio(i)

    end

    for i=1:size(dados,2)
       dados_normalizados(:,i) = (dados(:,i) - media(i))./ desvio(i);
    end

end