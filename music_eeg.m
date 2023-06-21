load('music_listening_experiment_s01.mat')
%qual a hipótese?

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

%comparar a atividade cerebral para um sensor
%plot com o descanso e com uma música

rest_1 = EEG_Rest(1:1,:);
song1_sensor1 = EEG_Songs(1:1,:);
song2_sensor1 = EEG_Songs(2:2, :);
%%
figure(1)
tt = (1:length(rest_1))*dt;
hold on
plot(tt, rest_1)
hold off
%%
figure (2)
[pxx1,f1]=pwelch(song2_sensor1,2*sr,sr/2,[],sr);

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
[s,f,t]=spectrogram(song1_sensor1,2*sr,sr/2,[],sr);
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
[s,f,t]=spectrogram(song2_sensor1,2*sr,sr/2,[],sr);
imagesc(t,f,abs(s))
colorbar
clim([0 50]) %caxis não é recomendado
ylim([0 50])
ylabel('Frequencia (Hz)')
xlabel('Time (s)')
axis xy
