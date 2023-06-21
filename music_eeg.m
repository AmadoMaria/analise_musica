load('music_listening_experiment_s01.mat')
%qual a hipótese?

sr = Fs; % taxa de amostragem
dt = 1/sr; % período infinitesimal

%comparar a atividade cerebral para um sensor
%plot com o descanso e com uma música

rest_1 = EEG_Rest(1:1,:);
song1_1 = EEG_Songs(1:1,:);

tt = (1:length(rest_1))*dt;
hold on
plot(tt, rest_1)
hold off
%%
[pxx1,f1]=pwelch(rest_1,2*sr,sr/2,[],sr);

plot(f1, pxx1)

%%
