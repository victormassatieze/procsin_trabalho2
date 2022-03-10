%% --- Inicializando os coeficientes do filtro:
fig_ellip;
close all % Fecha as figuras geradas pelo script acima

%% ---Realizando a transformação espectral:
[b,a] = iirlp2hp(b,a,0.4,0.6); % 0.4pi -> pi - 0.4pi

figure('units', 'centimeters', 'position', [3, 3, 20, 9])
freqz(b,a) % plot da resposta em frequencia
saveas(gcf,'ellipHP_freqz.png')

%-----grafico da resposta em escala linear-----%
figure('units', 'centimeters', 'position', [3, 3, 20, 5])
[h,w] = freqz(b,a); % resposta em frequencia
plot(w/pi,abs(h))
grid on
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Magnitude |H(j\omega)| (Aproximação Elíptica)')
saveas(gcf,'ellipHP_mag.png')

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

%% --- Processando os sinais com o novo filtro:
y1 = filter(b,a,x1);
y2 = filter(b,a,x2);

% --- Descomente para ouvir os sinais:
%soundsc(y1,FS);
%soundsc(y2,FS);

% --- Salva os resultados:
audiowrite('uranus_ellipHP.wav',y1,FS);
audiowrite('sample-0_ellipHP.wav',y2,FS);

%% --- Salva os espectrogramas:
[sx1,fx1,tx1] = spectrogram(x1,hamming(1024),512,2048,FS);
[sx2,fx2,tx2] = spectrogram(x2,hamming(1024),512,2048,FS);
[sy1,fy1,ty1] = spectrogram(y1,hamming(1024),512,2048,FS);
[sy2,fy2,ty2] = spectrogram(y2,hamming(1024),512,2048,FS);

% --- Exibe os espectrogramas originais e filtrados:
f3 = figure('units', 'centimeters','position',[3,2,30,8]);
figure(f3);
h = tiledlayout(1,2, 'Padding', 'compact');
nexttile
surf(ty1,fy1,20*log10(abs(sy1)),'LineStyle','none')
title('Espectrograma de Potência do sinal musical filtrado', ...
    'Aproximação Elíptica')
view(0,90)
xlim([-inf inf])
xlabel('tempo [s]')
ylim([-inf inf])
ylabel('frequência [Hz]')
colormap bone
colorbar
nexttile
surf(ty2,fy2,20*log10(abs(sy2)),'LineStyle','none')
title('Espectrograma de Potência do sinal de voz filtrado', ...
    'Aproximação Elíptica')
view(0,90)
xlim([-inf inf])
xlabel('tempo [s]')
ylim([-inf inf])
colormap bone
colorbar
saveas(f3,'ellipHP_filt.png')