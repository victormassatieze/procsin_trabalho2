Wp = 0.6;                           % frequencia de fim da 
                                    % faixa de passagem normalizada 
                                    % (dividida por pi)

Wr = 0.7;                           % frequencia de inicio da faixa 
                                    % de rejeicao normalizada

A = 40;                             % atenuacao na faixa de rejeicao

%-----definindo o filtro-----%
% Como temos 40db de atenuacao, precisamos utilizar a janela hanning
% que possui 44db de atenuacao que implica ripple de 0.006

%assim, a ordem do filtro será dada por
n = round(3.1*2/(Wr - Wp)); % n: ordem do filtro

Wn = [0.15, 0.65]; % freq de corte

b = fir1(n,Wn, 'bandpass', hanning(n+1));               % b: coef. do numerador de H(z)
a=1;                                    % a: coef. do denominador de H(z)

[h,w] = freqz(b,a);                 % resposta em frequencia
freqz(b,a)                          % plot da resposta em frequencia

%-----grafico da resposta em escala linear-----%
figure('units', 'centimeters', 'position', [3, 3, 20, 5])
plot(w/pi,abs(h))
grid on
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Magnitude |H(j\omega)|')