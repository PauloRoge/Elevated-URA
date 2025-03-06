function musicpseudospectrum = music_URA(Y, Mx, Mz, elevation, x_grid, y_grid, d_x, d_z, lambda, snapshots)
    
    % Estima a matriz de covariância
    R = (Y * Y') / snapshots; 
    
    % Decomposição espectral (autovetores e autovalores)
    [eigenvectors, eigenvalues] = eig(R);
    estimated_sources = 1;
    
    % Seleciona subespaço de ruído
    [~, i] = sort(diag(eigenvalues), 'descend');
    eigenvectors = eigenvectors(:, i);
    Vn = eigenvectors(:, estimated_sources+1:end);
    
    % MUSIC Spectrum
    Pmusic = zeros(length(x_grid), length(y_grid));
    
    for i = 1:length(x_grid)
        for j = 1:length(y_grid)
            x_user = x_grid(i);
            y_user = y_grid(j);
            z_user = 0; % O usuário está no plano XY (z = 0)
            
            % Usa o steering vector SEM path loss para projeção
            a = steering_vector_URA(Mx, Mz, elevation, d_x, d_z, lambda, x_user, y_user, z_user);
            
            % Calcula a função MUSIC
            Pmusic(i, j) = 1 / (a' * (Vn * Vn') * a);
        end
    end
    
    % Normaliza o espectro MUSIC
    Pmusic = abs(Pmusic) / max(abs(Pmusic(:))); 
    musicpseudospectrum = Pmusic;
end
