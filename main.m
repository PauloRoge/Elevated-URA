close all; clear; clc;

% arquitetura URA
Mx = 8; % numero de antenas na horizontal (eixo x)
Mz = 8; % numero de antenas na vertical (eixo z)
M = Mx * Mz; % numero total de antenas

elevations = [0, 20, 100]; % Diferentes elevações para análise

% parametros
freq = 15 * 10^9;              % 15 GHz
lambda = (3 * 10^8) / freq;    % comprimento de onda
d_x = lambda / 2;             % espaçamento entre antenas no eixo x
d_z = lambda / 2;             % espaçamento entre antenas no eixo z
snapshots = 1;                % numero de amostras temporais
power = 0.1;                  % potencia transmitida (W)
noisepowerdBm = -90;          % potencia de ruído (dBm)
alpha = 2;                    % expoente do path loss (free-space)

source_positions = [30, 30, 0];  % Usuário 1 (x, y, z)
source = size(source_positions, 1); % Número de fontes

% Definição da Grade de Busca para MUSIC
x_grid = -100:1:100; % Varredura da posição x
y_grid = 10:1:110;   % Varredura da posição y

figure;
for i = 1:length(elevations)
    elevation = elevations(i);
    
    % Geração da Matriz de Sinais Recebidos no URA
    Y = signals_URA(Mx, Mz, elevation, snapshots, d_x, d_z, lambda, ...
        source_positions, alpha, power, noisepowerdBm);
    
    % Computação do Pseudo-Espectro MUSIC
    Pmusic = music_URA(Y, Mx, Mz, elevation, x_grid, y_grid, d_x, d_z, lambda, snapshots);
    
    % Plot do Pseudo-Espectro MUSIC
    subplot(1, 3, i);
    imagesc(x_grid, y_grid, 10 * log10(Pmusic.'));
    axis square; % Garante que a figura seja quadriculada
    colorbar;
    xlabel('Posição X (m)');
    ylabel('Posição Y (m)');
    grid on;
end
