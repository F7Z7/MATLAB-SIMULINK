s = tf('s');
G = 1/(s*(s+1)*(s+2));
nyquist(G)
grid on
