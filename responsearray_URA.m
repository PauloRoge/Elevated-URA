function steeringvector = responsearray_URA(Mx, Mz, elevation, d_x, d_z, lambda, expoentpathloss, x_user, y_user, z_user)
    
    % Define as posições das antenas no URA (Plano xz) com deslocamento
    x_positions = (0:Mx-1) * d_x;  % Posições das antenas no eixo x
    z_positions = (0:Mz-1) * d_z + elevation;  % Posições das antenas elevadas no eixo z

    % Inicializa o vetor de resposta
    steeringvector = zeros(Mx * Mz, 1); 

    % Calcula a distância euclidiana e aplica Path Loss
    index = 1;
    for i = 1:Mx
        for j = 1:Mz
            % Distância euclidiana entre a antena (i,j) e o usuário (x_user, y_user, z_user)
            d_ij = sqrt((x_user - x_positions(i))^2 + y_user^2 + (z_user - z_positions(j))^2);
            
            % Path loss modelado diretamente no steering vector
            path_loss = sqrt(lambda^expoentpathloss / ((4 * pi * d_ij) ^ expoentpathloss));

            % Modelo do Steering Vector com Path Loss e Defasagem
            steeringvector(index) = [exp(-1i * (2 * pi / lambda) * d_ij)] * path_loss;
            
            index = index + 1;
        end
    end
end
