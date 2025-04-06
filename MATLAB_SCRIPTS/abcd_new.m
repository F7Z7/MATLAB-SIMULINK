% User Inputs
r = input('Enter resistance (ohms per unit length): ');
l = input('Enter inductance (mH per unit length): ');
c = input('Enter capacitance (uF per unit length): ');
g = input('Enter conductance (S per unit length): ');
f = input('Enter frequency (Hz): ');
Len = input('Enter line length: ');
Vr_3 = input('Enter receiving end line voltage (kV L-L): ');
MVAr = input('Enter receiving end power in MVA: ');
pfr = input('Enter receiving end power factor: ');

% Per-unit length impedance and admittance
z = r + 1j * 2 * pi * f * l / 1000;  % from mH to H
y = g + 1j * 2 * pi * f * c / 1e6;   % from uF to F

Z = z * Len;
Y = y * Len;

% Determine Line Type
if c == 0 && g == 0
    line = 'short';
else
    model = input('Enter 1 for Medium Line, 2 for Long Line: ');
    if model == 1
        line = 'medium';
    elseif model == 2
        line = 'long';
    else
        error('Invalid line model selected');
    end
end

% Calculate ABCD Parameters
switch line
    case 'short'
        disp('Using Short Line Model');
        A = 1;
        B = Z;
        C = 0;
        D = 1;

    case 'medium'
        disp('Using Medium Line (Nominal Pi) Model');
        A = 1 + (Z * Y / 2);
        B = Z;
        C = Y * (1 + (Z * Y / 4));
        D = A;

    case 'long'
        disp('Using Long Line Model');
        Zc = sqrt(Z / Y);
        gamma = sqrt(Z * Y);
        A = cosh(gamma);
        B = Zc * sinh(gamma);
        C = sinh(gamma) / Zc;
        D = A;

        fprintf('Zc = %.4f + j%.4f ohms\n', real(Zc), imag(Zc));
        fprintf('Gamma = %.4f + j%.4f (nepers + j*radians)\n', real(gamma), imag(gamma));
end

% Form ABCD Matrix
ABCD = [A B; C D];

% Receiving end phase voltage
VR = Vr_3 / sqrt(3);  % kV phase
VR = VR + 1j * 0;

% Power factor angle and receiving end power
AR = acos(pfr);
SR = MVAr * (cos(AR) + 1j * sin(AR));  % MVA
IR = conj(SR) / (3 * conj(VR));        % kA

% Sending end voltage and current
VsIs = ABCD * [VR; IR];
Vs = VsIs(1);
Is = VsIs(2);

% Results
Vs3ph = sqrt(3) * abs(Vs);             % L-L voltage at sending end
Ism = 1000 * abs(Is);                  % Sending end current in A
pfs = cos(angle(Vs) - angle(Is));      % Sending end PF
Ss = 3 * Vs * conj(Is);                % Sending end apparent power
REG = (Vs3ph/A - Vr_3) / Vr_3 * 100;     % % Voltage regulation

% Display Output
fprintf('\nResults:\n');
fprintf('Is = %.2f A\n', Ism);
fprintf('Sending Power Factor = %.4f\n', pfs);
fprintf('Vs = %.2f kV (Line-to-Line)\n', Vs3ph);
fprintf('Sending Power = %.2f MW\n', real(Ss));
fprintf('Sending Reactive Power = %.2f MVAR\n', imag(Ss));
fprintf('Voltage Regulation = %.2f%%\n', REG);
