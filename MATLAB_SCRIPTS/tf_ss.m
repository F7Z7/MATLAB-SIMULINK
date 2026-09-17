%% program to conv tf-ss and vice versa

num = 10;
den = [1 3 2 0];

G = tf(num,den)


[A,B,C,D] = tf2ss(num,den)
eig(A)

Qc = ctrb(A,B)

fprintf("Controllability rank = %d\n",rank(Qc));

p = [-2 -1+1i -1-1i];

K=place(A,B,p)

A_closed=A-B*K

eig(A_closed)

sys_cl=ss(A_closed,B,C,D)

tf_cl=tf(sys_cl)