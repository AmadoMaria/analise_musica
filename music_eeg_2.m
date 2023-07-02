load('Music-EEG-main/music_listening_experiment_s20.mat')

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

% Reordenando os dados para acessar a música pela paginação
aux = permute(EEG_Songs,[2 3 1]);
sensor_index = 7;


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
    song_o1 = aux(7:7,:, i);
    song_o2 = aux(8:8,:, i);
    filtered_song_o1 = eegfilt(song_o1, sr, 8, 12);
    filtered_song_o2 = eegfilt(song_o2, sr, 8, 12);
    [pxx_o1,f]=pwelch(filtered_song_o1,2*sr,sr/2,[],sr);
    [pxx_o2,f_o2]=pwelch(filtered_song_o2,2*sr,sr/2,[],sr);
    pxx = (pxx_o1 + pxx_o2)/2; % média dos sensores
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

rest_o1 = EEG_Rest(7:7,:);
rest_o2 = EEG_Rest(8:8,:);
filtered_rest_o1 = eegfilt(rest_o1, sr, 8, 12);
filtered_rest_o2 = eegfilt(rest_o2, sr, 8, 12);
[pxx_rest_o1,f_rest]=pwelch(filtered_rest_o1,2*sr,sr/2,[],sr);
[pxx_rest_o2,f_rest2]=pwelch(filtered_rest_o2,2*sr,sr/2,[],sr);
pxx_rest = (pxx_rest_o1 + pxx_rest_o2)/2;


figure(7)
hold on
plot(f_rest, pxx_rest)
plot(f, pxx_1)
plot(f, pxx_3)
plot(f, pxx_5)
title('Power Spectral Density (PSD)')
set(gca,'XLim',[0 30])
hold off
legend('rest', 'songs1','songs3', 'songs5')
ylabel('Potência (mV^2/Hz)')
xlabel('Frequência (Hz)')
