function g = prototipo(g)
    prototipos = [];
    for i=1:size(g.nos_tre,2)
        %Verifica se o no tem pai e se a classe do pai eh diferente da do
        if  ~isequal(g.nos_tre(i).pai, 0) && ~isequal(g.nos_tre(i).classe, g.nos_tre(i).pai.classe)
%             g.nos_tre(i).pai.prototipo = true;
%             g.nos_tre(i).prototipo = true;
            prototipos = [prototipos g.nos_tre(i).id];
            prototipos = [prototipos g.nos_tre(i).pai.id];
%             filho = g.nos_tre(i)
%             pai = g.nos_tre(i).pai
%             classe_filho = g.nos_tre(i).classe
%             classe_pai = g.nos_tre(i).pai.classe
        end   
    end
    for j=1:size(g.nos_tre,2)
        if ismember(g.nos_tre(j).id, prototipos(:))
            g.nos_tre(j).prototipo = true;
        end
    end

end