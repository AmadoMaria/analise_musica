% Selecione o sujeito que deseja analisar
load('Music-EEG-main/music_listening_experiment_s01.mat')

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

rest_1 = EEG_Rest(7:7,:);

% Reordenando os dados para acessar a música pela paginação
aux = permute(EEG_Songs,[2 3 1]);

sensor_index = 7; %o1 = 7 e o2 = 8

%Separando músicas no sensor 1
song1 = aux(sensor_index:sensor_index,:, 1); %song 1 nota 1
song2 =  aux(sensor_index:sensor_index,:, 2); %nota 3
song11 = aux(sensor_index:sensor_index,:, 11); %nota 5

%%
figure(1)
tt_rest = (1:length(rest_1))*dt;
tt = (1:length(song1))*dt;
hold on
plot(tt_rest, rest_1)
plot(tt, song1)
plot(tt, song2)
plot(tt, song11)
hold off
legend('rest','song 1', 'song 3', 'song 5')
ylabel('DDP (mmV)')
xlabel('Time (s)')
axis xy
%%
figure (2)
[pxx1,f1]=pwelch(song1,2*sr,sr/2,[],sr);
plot(f1, pxx1)

%%
%Espectograma do descanso
figure(3)
[s,f,t]=spectrogram(rest_1,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50]) %caxis não é recomendado
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%%
%Espectograma da musica
figure(4)
[s,f,t]=spectrogram(song1,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50])
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%%
%Espectrograma da musica
figure(5)
[s,f,t]=spectrogram(song2,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50])
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%%
%Espectrograma da musica
figure(6)
[s,f,t]=spectrogram(song11,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50]) %caxis não é recomendado
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%% Ondas alfa
% Plotando o PSD das três músicas na mesma figura

%Filtrando as ondas alfa
song1_filtered = eegfilt(song1, sr, 8, 12);
song2_filtered = eegfilt(song2, sr, 8, 12);
song11_filtered = eegfilt(song11, sr, 8, 12);

figure(7)
hold on
[pxx1,f1]=pwelch(song1_filtered,2*sr,sr/2,[],sr);
[pxx2,f2]=pwelch(song2_filtered,2*sr,sr/2,[],sr);
[pxx11,f11]=pwelch(song11_filtered,2*sr,sr/2,[],sr);

plot(f1, pxx1)
plot(f2, pxx2)
plot(f11, pxx11)
title('Power Spectral Density (PSD)')
set(gca,'XLim',[0 30])
hold off
legend('song1','song2', 'song11')
ylabel('Potência (mV^2/Hz)')
xlabel('Frequência (Hz)')

