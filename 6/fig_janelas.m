Wp = 0.3;                           % frequencia de fim da 
                                    % faixa de passagem normalizada 
                                    % (dividida por pi)

Wr = 0.5;                           % frequencia de inicio da faixa 
                                    % de rejeicao normalizada

A = 60;                             % atenuacao na faixa de rejeicao

%-----definindo o filtro-----%
% Como temos 60db de atenuacao, precisamos utilizar a janela Blackman
% que possui 74db de atenuacao que implica ripple de 0.0001

%assim, a ordem do filtro será dada por
n = round(5.5*2/(Wr - Wp)); % n: ordem do filtro

Wn = (Wr+Wp)/2; % freq de corte

b = fir1(n,Wn, 'low', blackman(n+1));               % b: coef. do numerador de H(z)
a=1                                    % a: coef. do denominador de H(z)

[h,w] = freqz(b,a);                 % resposta em frequencia
freqz(b,a)                          % plot da resposta em frequencia

%-----grafico da resposta em escala linear-----%
figure('units', 'centimeters', 'position', [3, 3, 20, 5])
plot(w/pi,abs(h))
grid on
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Magnitude |H(j\omega)|')