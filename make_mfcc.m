function MFCC=make_mfcc(Signal,fe,Nfiltre)
N=length(Signal);
assert(N>=13);
P=0:1:N-1;
Hamming=0.54-0.46*cos(2*pi*P/N);
Si_fenetre=Signal.*Hamming;
Spectre_signal=abs(fft(Si_fenetre))*(1/N);
Low_freq_mel=0;
High_freq_mel=(2595*log10(1 + (fe / 2) / 700));%les points Haut et bas de notre échelle de mel
points_mel=Low_freq_mel:(High_freq_mel/(Nfiltre+2)):High_freq_mel; %espacement régulier dans l'échelle de mel
hz_points=(700 * (10.^(points_mel / 2595) - 1)); %point à 0 des filtres de mel
bin=floor((N + 1) * hz_points / fe); %idem à la bonne place fréquentielle(entier pour l'itération suivante)
fbank=zeros(Nfiltre, floor(floor(N /2)));
for m=2:Nfiltre+1
    f_m_minus=bin(m - 1);   
    f_m=bin(m);             
    f_m_plus=bin(m + 1);
    for k=f_m_minus:f_m
        fbank(m-1,k+1)=(k-bin(m-1))/(bin(m)-bin(m-1));
    end    
    for d=f_m:f_m_plus
        fbank(m-1,d+1)=(bin(m+1)-d)/(bin(m+1)-bin(m));
    end
end
filter_banks=log10(Spectre_signal(1,floor(N/2)))*fbank;
MFCC=idct(filter_banks);
MFCC=sum(MFCC,2);
MFCC=MFCC(1:13);
end