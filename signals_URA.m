function Y = signals_URA(Mx, Mz, elevation, snapshots, d_x, d_z, lambda, ...
    source_positions, expoentpathloss, transmittedpower, noisepowerdBm)

    % Garante que source_positions tem pelo menos 3 colunas (x, y, z)
    if size(source_positions, 2) < 3
        source_positions = [source_positions, zeros(size(source_positions, 1), 3 - size(source_positions, 2))];
    end

    % Converte a potência do ruído de dBm para Watts
    noisepower = 10^((noisepowerdBm - 30) / 10); 

    % Número total de antenas no URA
    M = Mx * Mz;

    % Inicializa matriz de canal H
    H = zeros(M, size(source_positions, 1)); % M linhas (antenas) x Nº de usuários (colunas)

    % Matriz de canal para cada usuário
    for s = 1:size(source_positions, 1)
        x_user = source_positions(s, 1);
        y_user = source_positions(s, 2);
        z_user = source_positions(s, 3);

        % Steering vector agora já contém path loss
        H(:, s) = responsearray_URA(Mx, Mz, elevation, d_x, d_z, lambda, ...
            expoentpathloss, x_user, y_user, z_user);
    end

    % Geração de sinais transmitidos e ruído
    X = sqrt(transmittedpower) * (randn(size(source_positions, 1), snapshots) + ...
        1j * randn(size(source_positions, 1), snapshots)) / sqrt(2); 

    Z = sqrt(noisepower) * (randn(M, snapshots) + 1j * randn(M, snapshots)) / sqrt(2); 

    % Matriz de sinais recebidos
    Y = H * X + Z; 

    %cálculo da SNR para verificação
    SNR = 10 * log10(sum(abs(Y).^2, 'all') / sum(abs(Z).^2, 'all'));
    disp(['SNR = ', num2str(SNR), ' dB']);
end
