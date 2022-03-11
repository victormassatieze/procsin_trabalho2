%% --- Inicializando o filtro:
fig_janelas_BP;
close all % Fecha as figuras geradas pelo script acima

%% --- Carregando os sinais de audio:
[x1,sr1] = audioread("uranus.wav");
[x2,sr2] = audioread("sample-0.wav");

FS = 16000;

% --- Alterando a freq de amostragem para FS:
if sr1 ~= FS
   x1 = resample(x1, FS, sr1);
end
if sr2 ~= FS
   x2 = resample(x2, FS, sr2);
end

%% --- Filtrando os sinais:
y1 = filter(b,a,x1);
y2 = filter(b,a,x2);

% --- Descomente para ouvir os sinais:
%soundsc(y1,FS);
soundsc(y2,FS);

% --- Salva os resultados:
audiowrite('uranus_butter.wav',y1,FS);
audiowrite('sample-0_butter.wav',y2,FS);

%% --- Salva os espectrogramas:
[sx1,fx1,tx1] = spectrogram(x1,hamming(1024),512,2048,FS);
[sx2,fx2,tx2] = spectrogram(x2,hamming(1024),512,2048,FS);
[sy1,fy1,ty1] = spectrogram(y1,hamming(1024),512,2048,FS);
[sy2,fy2,ty2] = spectrogram(y2,hamming(1024),512,2048,FS);

% --- Exibe os espectrogramas originais e filtrados:
f = figure('units', 'centimeters','position',[3,2,30,15]);
figure(f);
h = tiledlayout(2,2, 'Padding', 'compact');
nexttile
surf(tx1,fx1,20*log10(abs(sx1)),'LineStyle','none')
view(0,90)
title('Espectrograma de Potência do sinal musical original')
xlim([-inf inf])
ylim([-inf inf])
ylabel('frequência [Hz]')
colormap bone
colorbar
nexttile
surf(tx2,fx2,20*log10(abs(sx2)),'LineStyle','none')
view(0,90)
title('Espectrograma de Potência do sinal de voz original')
xlim([-inf inf])
ylim([-inf inf])
colormap bone
colorbar
nexttile
surf(ty1,fy1,20*log10(abs(sy1)),'LineStyle','none')
title('Espectrograma de Potência do sinal musical filtrado','Butterworth')
view(0,90)
xlim([-inf inf])
ylim([-inf inf])
ylabel('frequência [Hz]')
colormap bone
colorbar
nexttile
surf(ty2,fy2,20*log10(abs(sy2)),'LineStyle','none')
title('Espectrograma de Potência do sinal de voz filtrado','Butterworth')
view(0,90)
xlim([-inf inf])
ylim([-inf inf])
colormap bone
colorbar