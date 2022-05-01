function Chroma=make_chroma(Signal,fe,ecart)
N=length(Signal);
P=0:1:N-1;
Hamming=0.54-0.46*cos(2*pi*P/N);     %Pour effectuer le calcul des chromas, on se base sur une méthode "soft" où l'on calcule une moyenne énergétique spectrale autours
Si_fenetre=Signal.*Hamming;          % d'une fréquence correspondant à une note.
Spectre_signal=abs(fft(Si_fenetre))*1/N;
nuf=0:fe/N:fe-1/N;
fo=55;%On construit les gammes à partir du la 0.
h=floor(log2(fe/55));% Dans un premier temps on construit les différentes fréquences constituant nos notes ainsi que les fréquences limites servant à filtrer les raies
gamme=zeros(h,36);      % proches de nos signaux musicaux.
chroma=zeros(h,12);
gamme(1,1)=((ecart-1)/ecart)*fo;%ecart permet de définir la largeur du filtre. Plus écart est grand, plus le filtre est resséré autours de la fréquence musicale. Cette ligne correspond à la fréquence basse du filtre
gamme(1,2)=fo;% cette ligne correspond à la fréquence centrale du filtre
gamme(1,3)=((ecart+1)/ecart)*fo; %cette ligne correspond à la fréquence haute
for j=5:3:36
    gamme(1,j)=gamme(1,j-3)*nthroot(2,12); %on applique le schéma précédant à toute les fréquences 'musicales'(gammes tempérées) jusqu'à environ fe/2.
    gamme(1,j+1)=gamme(1,j)*((ecart+1)/ecart);
    gamme(1,j-1)=gamme(1,j)*((ecart-1)/ecart);
end
for i=2:h
    gamme(i,:)=gamme(i-1,:)*2;
end
gamme=round(gamme);
for i=1:12
    for k=1:h
        fil=make_filtre_triangu(gamme(k,(i-1)*3+1),gamme(k,(i-1)*3+2),gamme(k,(i-1)*3+3),fe); %on calcule ici le filtre correspondant aux truples fréquentiels donné
        chroma(k,i)=Spectre_signal(1:N/2)*fil';% le chroma de la note précise (la3 par exemple) est calculé ici
    end
end

Chroma=sum(chroma,1)/sum(sum(chroma)); %on additionne toutes les notes étant des octaves et on normalise.
Chroma=Chroma';
end
