function Chroma=make_chroma(Signal,fe,ecart)
N=length(Signal);
P=0:1:N-1;
Hamming=0.54-0.46*cos(2*pi*P/N);
Si_fenetre=Signal.*Hamming;
Spectre_signal=abs(fft(Si_fenetre))*1/N;
nuf=0:fe/N:fe-1/N;
fo=55;
h=floor(log2(22100/55));
gamme=zeros(h,36);
chroma=zeros(h,12);
gamme(1,1)=((ecart-1)/ecart)*fo;
gamme(1,2)=fo;
gamme(1,3)=((ecart+1)/ecart)*fo;
for j=5:3:36
    gamme(1,j-1)=gamme(1,j-4)*nthroot(2,12);
    gamme(1,j)=gamme(1,j-3)*nthroot(2,12);
    gamme(1,j+1)=gamme(1,j-2)*nthroot(2,12);
end
for i=2:h
    gamme(i,:)=gamme(i-1,:)*2;
end
gamme=floor(gamme);
for i=1:12
    for k=1:h
        fil=make_filtre_triangu(gamme(k,(i-1)*3+1),gamme(k,(i-1)*3+2),gamme(k,(i-1)*3+3),fe);
        chroma(k,i)=Spectre_signal(1:N/2)*fil';
    end
end

Chroma=sum(chroma,1)/sum(sum(chroma));
Chroma=Chroma';
end