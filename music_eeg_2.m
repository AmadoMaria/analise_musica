load('Music-EEG-main/music_listening_experiment_s02.mat')

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

% Reordenando os dados para acessar a música pela paginação
aux = permute(EEG_Songs,[2 3 1]);
sensor_index = 8;


%% Ondas alfa
% Plotando o PSD das três músicas na mesma figura
count_1 = 0;
count_3 = 0;
count_5 = 0;

pxx_1 = zeros(129);
pxx_3 = zeros(129);
pxx_5 = zeros(129);

for i=1:30
    %usar a média dos sensores
    song = aux(sensor_index:sensor_index,:, i);
    filtered_song = eegfilt(song, sr, 8, 12);
    [pxx,f]=pwelch(filtered_song,2*sr,sr/2,[],sr);
    if song_ratings(i) == 1
        pxx_1 = pxx_1 + pxx;
        count_1 = count_1 + 1;
    elseif song_ratings(i) == 3
        pxx_3 = pxx_3 + pxx;
        count_3 = count_3 + 1;
    elseif song_ratings(i) == 5
        pxx_5 = pxx_5 + pxx;
        count_5 = count_5 + 1;
    end
end

pxx_1 = pxx_1(:, 1:1)/count_1;
pxx_3 = pxx_3(:, 1:1)/count_3;
pxx_5 = pxx_5(:, 1:1)/count_5;

figure(7)
hold on
plot(f, pxx_1)
plot(f, pxx_3)
plot(f, pxx_5)
title('Power Spectral Density (PSD)')
set(gca,'XLim',[0 30])
hold off
legend('song1','song3', 'song5')
ylabel('Potência (mV^2/Hz)')
xlabel('Frequência (Hz)')
