load('music_listening_experiment_s01.mat')

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

rest_1 = EEG_Rest(1:1,:);

% Reordenando os dados para acessar a música pela paginação
aux = permute(EEG_Songs,[2 3 1]);

%Separando músicas no sensor 1
song1 = aux(1:1,:, 1); %song 1 nota 1
song2 =  aux(1:1,:, 2); %nota 3
song11 = aux(1:1,:, 11); %song 1 %nota 5

%song11_sensor2 = aux(2:2,:, 11);

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

