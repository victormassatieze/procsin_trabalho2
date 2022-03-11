Wp = 0.6;                           % frequencia de fim da 
                                    % faixa de passagem normalizada 
                                    % (dividida por pi)

Wr = 0.7;                           % frequencia de inicio da faixa 
                                    % de rejeicao normalizada

delta = 1-0.01;                    % ripple linear

deltadB = 20*log10(delta);          % ripple em dB

A = 40;                             % atenuacao na faixa de rejeicao

%-----definindo o filtro-----%
[n,Wn]=buttord(Wp,Wr,deltadB,A);    % n: ordem do filtro
                                    % Wn: frequência de 3dB

[b,a] = butter(n,Wn);               % b: coef. do numerador de H(z)
                                    % a: coef. do denominador de H(z)

[h,w] = freqz(b,a);                 % resposta em frequencia
freqz(b,a)                          % plot da resposta em frequencia

%-----grafico da resposta em escala linear-----%
figure('units', 'centimeters', 'position', [3, 3, 20, 5])
plot(w/pi,abs(h))
grid on
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Magnitude |H(j\omega)|')