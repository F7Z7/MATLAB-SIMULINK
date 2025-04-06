% Main Script for Transmission Line Analysis
% -------------------------------------------

% User Inputs
r = input('Enter line resistance in ohms per unit length, r = ');
L = input('Enter line inductance in millihenry per unit length, L = ');
C = input('Enter line capacitance in microfarad per unit length, C = ');
g = input('Enter line conductance in siemens per unit length, g = ');
f = input('Enter Frequency in Hz = ');
Length = input('Enter Line length = ');
VR3ph = input('Enter receiving end line voltage (L-L) in kV = ');
MVAr = input('Enter receiving end power in MVA = ');
pfr = input('Enter receiving end power factor = ');

% Receiving End Phase Voltage
VR = VR3ph / sqrt(3) + 1j * 0;

% Function Call to Calculate ABCD Parameters
[Z, Y, ABCD] = RLC2ABCD(r, L, C, g, f, Length);

% Power Factor Angle and Power Calculations
AR = acos(pfr);                   % Receiving end power factor angle
SR = MVAr * (cos(AR) + 1j * sin(AR));  % MVA (Receiving end power)
IR = conj(SR) / (3 * conj(VR));   % kA (Receiving end current)

% Voltage and Current at Sending End
VsIs = ABCD * [VR; IR];
Vs = VsIs(1);
Vs3ph = sqrt(3) * abs(Vs);       % Sending end L-L voltage

Is = VsIs(2);
Ism = 1000 * abs(Is);             % Sending end current in A
pfs = cos(angle(Vs) - angle(Is)); % Sending end power factor

% Sending End Power and Voltage Regulation
Ss = 3 * Vs * conj(Is);           % MVA (sending end power)
REG = (Vs3ph / abs(ABCD(1, 1)) - VR3ph) / VR3ph * 100;

% Display Results
fprintf('Is = %.2f A\n', Ism)
fprintf('pfs = %.4f\n', pfs)
fprintf('Vs = %.2f L-L kV\n', Vs3ph)
fprintf('Ps = %.2f MW\n', real(Ss))
fprintf('Qs = %.2f Mvar\n', imag(Ss))
fprintf('Percent Voltage Regulation = %.2f%%\n', REG)


