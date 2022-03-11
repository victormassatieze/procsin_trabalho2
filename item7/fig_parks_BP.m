Wp = 0.3;                           % frequencia de fim da 
                                    % faixa de passagem normalizada 
                                    % (dividida por pi)
ripple = 0.005;

Wr = 0.5;                           % frequencia de inicio da faixa 
                                    % de rejeicao normalizada

A = 60;                             % atenuacao na faixa de rejeicao

%-----definindo o filtro-----%
%Wn = [0.15, 0.65]; % freq de corte

[n,fo,ao,w] = firpmord([0.1 0.2 0.6 0.7],[0 1 0],[ripple ripple ripple]);
b = firpm(n,fo,ao,w);               % b: coef. do numerador de H(z)
a = 1
[h,w] = freqz(b,a);                 % resposta em frequencia
freqz(b,a)                          % plot da resposta em frequencia

%-----grafico da resposta em escala linear-----%
figure('units', 'centimeters', 'position', [3, 3, 20, 5])
plot(w/pi,abs(h))
grid on
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Magnitude |H(j\omega)|')