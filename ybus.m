clear;clc;
zdata=[1 0 0 1;
    2 0 0 0.8;
    1 3 0 0.2;
    1 2 0 0.4;
    2 3 0 0.2;
    3 4 0 0.08];
n1=zdata(:,1);
nr=zdata(:,2);
r=zdata(:,3);
x=zdata(:,4);

nbr=length(n1)
nbus=max(max(n1),max(nr))
z=r+1i*x
y=ones(nbr,1)./z
Y=zeros(nbr,nbr)

for k=1:nbr
 if n1(k)>0&&nr(k)>0
     Y(n1(k),nr(k))=Y(n1(k),nr(k))-y(k);
     Y(nr(k),n1(k))=Y(n1(k),nr(k));
 end
end

for n=1:nbus
    for k=1:nbr
        if n1(k)==n||nr(k)==n
            Y(n,n)=Y(n,n)+y(k);
        end
    end
end
Y