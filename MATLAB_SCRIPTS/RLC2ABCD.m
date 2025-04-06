function [Z, Y, ABCD] = RLC2ABCD(r, L, C, g, f, Length)
model = -1;
z = r + 1j * 2 * pi * f * L / 1000; %converting from milli henry
Z = z * Length; %full line impedence
R = real(Z); 
X = imag(Z);

y = g + 1j * 2 * pi * f * C / 1000000; %converting from micro farad
Y = y * Length;

if g == 0 && C == 0 %for short line c=0
    fprintf('\nShort line model\n');
    fprintf('----------------\n');
    fprintf(' Z = %g + j %f ohms\n',R,X) %final z value in terms of r and x
    Y = 0 + 1j * 0;
else
    while model ~= 1 && model ~= 2
        model = input('Enter 1 for Medium line or 2 for Long line --> ');
    end

    if model == 1
        fprintf('\nMedium Line - Nominal Pi Model\n');
        fprintf('-----------------------------\n');
        fprintf('Z = %f + j%f ohms\n', R, X);
        fprintf('Y = %f + j%f Siemens\n', real(Y), imag(Y));

    elseif model == 2
        Zc = sqrt(Z / Y);
        Gamal = sqrt(Z * Y);
        Z = Zc * sinh(Gamal);
        Y = 2 * tanh(Gamal / 2) / Zc;

       disp(' ') 
       disp(' Long Line - Equivalent pi model') 
       disp(' -------------------') 
       fprintf('\n') 
       fprintf(' Z = %g + j ',real(Z)),fprintf('%g ohms\n',imag(Z)), 
       fprintf(' Y= %g + j ',real(Y)),fprintf('%g siemens\n',imag(Y)) 
       fprintf(' Zc  = %g + j ',real(Zc)),fprintf('%g ohms\n',imag(Zc)) 
 
       fprintf(' alpha l  = %g neper', real(Gamal)) 
       fprintf('   beta l = %g radian', imag(Gamal)) 
       fprintf('= %gdegree\n', imag(Gamal*180/pi))
    end
end

if model ==-1 || model ==1 ||model ==2 
% ABCD Parameters
A = 1 + Z * Y / 2;
B = Z;
C = Y * (1 + Z * Y / 4);
D = A;

ABCD = [A B; C D];

fprintf('\nABCD Parameters:\n');
fprintf('%.4f + j%.4f    %.4f + j%.4f\n', real(A), imag(A), real(B), imag(B));
fprintf('%.4f + j%.4f    %.4f + j%.4f\n', real(C), imag(C), real(D), imag(D));
fprintf('\n');
else
    fprintf(' You must enter 1 or 2. Try again \n'), 
end
return
