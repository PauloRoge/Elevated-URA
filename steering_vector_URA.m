function steeringvector = steering_vector_URA(Mx, Mz, elevation, d_x, d_z, lambda, x_user, y_user, z_user)

    % Define as posições das antenas no URA (Plano xz) com deslocamento
    x_positions = (0:Mx-1) * d_x;  % Posições das antenas no eixo x
    z_positions = (0:Mz-1) * d_z + elevation;  % Posições das antenas elevadas no eixo z

    % Inicializa o vetor de resposta
    steeringvector = zeros(Mx * Mz, 1); 

    % Calcula a distância euclidiana e aplica somente os atrasos de fase
    index = 1;
    for i = 1:Mx
        for j = 1:Mz
            % Distância euclidiana entre a antena (i,j) e o usuário
            d_ij = sqrt((x_user - x_positions(i))^2 + y_user^2 + (z_user - z_positions(j))^2);
            
            % Apenas o termo de fase, sem path loss, o fator da freq talvez
            % nao seja necessario. (lambda/4 * pi) 
            steeringvector(index) = exp(-1i * (2 * pi / lambda) * d_ij);
            index = index + 1;
        end
    end
end
