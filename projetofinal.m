close all; clear all; clc;
% Parâmetros do sinal cardíaco simulado
fs = 1000;          %Frequência de amostragem em Hz
t = 0:1/fs:5;        %Tempo de 0 a 5 segundos com passo de 1/fs
f_card = 1;      %Frequência cardíaca em Hz (60 BPM)
amp_card = 1.5; %Amplitude do sinal cardíaco

%Sinal cardíaco simulado
sinal_card = amp_card*sin(2*pi*f_card*t);

%Ruído
ruido = 0.3 * randn(size(t)); % Ruído gaussiano com desvio padrão de 0.3
sinal_captado = sinal_card + ruido;

%FIR (Passa-baixa para remover interferências)
ordem_filtro = 50;
freq_corte = 5; % Frequência de corte em Hz
coeficientes_fir = fir1(ordem_filtro, freq_corte/(fs/2));

%Filtragem
sinal_filtrado = filter(coeficientes_fir, 1, sinal_captado);

figure;

subplot(3,1,1);
plot(t, sinal_card);
title('Sinal Cardíaco Puro');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, sinal_captado);
title('Sinal Cardíaco com Ruído');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, sinal_filtrado);
title('Sinal Cardíaco Filtrado');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Mostrar o filtro FIR
figure;
freqz(coeficientes_fir, 1, 1024, fs);% 1024 pontos e 1 como denominador da função de transferencia

