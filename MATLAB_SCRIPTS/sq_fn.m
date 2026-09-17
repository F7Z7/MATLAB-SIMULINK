t=0:0.01:10;
sig1=sin(2*pi*t);
subplot(3,1,1)
plot(t,sig1)
xlabel("normal",FontWeight="bold")
noise=0.5*randn(size(t));
%plot(t,noise)
noisy_signal=sig1+noise;
subplot(3,1,2)
plot(t,noisy_signal)
xlabel("noisy signal",FontWeight="bold")
filter_signal=movmean(noisy_signal,10);
subplot(3,1,3)
plot(t,filter_signal)
xlabel("filtered signal",FontWeight="bold")