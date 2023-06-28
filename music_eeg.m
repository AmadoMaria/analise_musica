load('music_listening_experiment_s01.mat')

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

rest_1 = EEG_Rest(1:1,:);

% Reordenando os dados para acessar a música pela paginação
aux = permute(EEG_Songs,[2 3 1]);

%Separando músicas no sensor 1
song1 = aux(2:2,:, 1); %song 1 nota 1
song2 =  aux(2:2,:, 2); %nota 3
song11 = aux(2:2,:, 11); %nota 5

%%
figure(1)
tt = (1:length(rest_1))*dt;
hold on
plot(tt, rest_1)
hold off
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
clim([0 50]) %caxis não é recomendado
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%%
%Espectograma da musica
figure(5)
[s,f,t]=spectrogram(song2,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50]) %caxis não é recomendado
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy

%%
%Espectograma da musica
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

