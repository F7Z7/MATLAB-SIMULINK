Z0g = 0.25 / 3; 
Zf = 1i * 0.1; 
Z = [0.15 0.15 0.05; 
     0.15 0.15 0.05; 
     0.1  0.1  0.1; 
     0.1  0.1  0.1; 
     0.125 0.125 0.3; 
     0.15  0.15  0.35; 
     0.25  0.25  0.7125]; 

Z11s = Z(5,1) * Z(6,1) / (Z(5,1) + Z(6,1) + Z(7,1)); 
Z12s = Z(5,1) * Z(7,1) / (Z(5,1) + Z(6,1) + Z(7,1)); 
Z13s = Z(6,1) * Z(7,1) / (Z(5,1) + Z(6,1) + Z(7,1)); 

Z1P = (Z(1,1) + Z(3,1) + Z11s) * (Z(2,1) + Z(4,1) + Z12s) / ...
      (Z(1,1) + Z(3,1) + Z(2,1) + Z(4,1) + Z11s + Z12s); 
  
Z133 = 1i * (Z1P + Z13s); 
Z233 = Z133; 

Z01s = Z(5,3) * Z(6,3) / (Z(5,3) + Z(6,3) + Z(7,3)); 
Z02s = Z(5,3) * Z(7,3) / (Z(5,3) + Z(6,3) + Z(7,3)); 
Z03s = Z(6,3) * Z(7,3) / (Z(5,3) + Z(6,3) + Z(7,3)); 

Z0P = (0.25 + Z(1,3) + Z(3,3) + Z01s) * (Z(4,3) + Z02s) / ...
      (Z(1,3) + Z(3,3) + Z(4,3) + Z01s + Z02s + 3 * Z0g); 
  
Z033 = 1i * (Z0P + Z03s); 

a = cos(2*pi/3) + 1i*sin(2*pi/3); 
A = [1   1   1; 
     1 a^2  a; 
     1 a    a^2]; 
 
fprintf('(a) Balanced three-phase fault at bus 3\n'); 
Ia3F = 1.0 / (Z133 + Zf); 
fprintf('Ia3F = %.4f + %.4fi\n', real(Ia3F), imag(Ia3F));

fprintf('(b) Single line-to-ground fault at bus 3\n'); 
I03 = 1.0 / (Z033 + 3*Zf + Z133 + Z133); 
fprintf('I03 = %.4f + %.4fi\n', real(I03), imag(I03));
I012 = [I03; I03; I03]; 
Iabc3 = A * I012; 
fprintf('Iabc3 = %.4f + %.4fi\n %.4f + %.4fi\n %.4f + %.4fi\n', real(Iabc3(1)), imag(Iabc3(1)), real(Iabc3(2)), imag(Iabc3(2)), real(Iabc3(3)), imag(Iabc3(3)));
fprintf('I012 = %.4f + %.4fi\n %.4f + %.4fi\n %.4f + %.4fi\n',real(I012(1)),imag(I012(1)),real(I012(2)), imag(I012(2)), real(I012(3)), imag(I012(3)));

fprintf('(c) Line-to-line fault at bus 3\n'); 
I13 = 1.0 / (Z133 + Z133 + Zf); 
I012 = [0; I13; -I13]; 
Iabc3 = A * I012; 
fprintf('Iabc3 = %.4f + %.4fi\n  %.4f + %.4fi\n %.4f + %.4fi\n', real(Iabc3(1)), imag(Iabc3(1)), real(Iabc3(2)), imag(Iabc3(2)), real(Iabc3(3)), imag(Iabc3(3)));
fprintf('I012 = %.4f + %.4fi\n %.4f + %.4fi\n %.4f + %.4fi\n',real(I012(1)),imag(I012(1)),real(I012(2)), imag(I012(2)), real(I012(3)), imag(I012(3)));


fprintf('(d) Double line-to-ground fault at bus 3\n'); 
I13=1/(Z133+Z133*(Z033+3*Zf)/(Z133+Z033+3*Zf));
fprintf('I13 = %.4f + %.4fi\n', real(I13), imag(I13));
I23 = -(1.0 - Z133 * I13) / Z133; 
I03 = -(1.0 - Z133 * I13) / (Z033 + 3*Zf); 
fprintf('I03 = %.4f + %.4fi\n', real(I03), imag(I03));
I012 = [I03; I13; I23]; 
Iabc3 = A * I012; 
fprintf('Iabc3 = %.4f + %.4fi\n %.4f + %.4fi\n %.4f + %.4fi\n', real(Iabc3(1)), imag(Iabc3(1)), real(Iabc3(2)), imag(Iabc3(2)), real(Iabc3(3)), imag(Iabc3(3)));
fprintf('I012 = %.4f + %.4fi\n %.4f + %.4fi\n %.4f + %.4fi\n',real(I012(1)),imag(I012(1)),real(I012(2)), imag(I012(2)), real(I012(3)), imag(I012(3)));

Iabc3p = [abs(Iabc3) angle(Iabc3) * 180 / pi]

