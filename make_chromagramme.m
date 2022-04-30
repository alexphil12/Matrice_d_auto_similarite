function Chromagramme=make_chromagramme(Signal,fe,ecart)
N=length(Signal);
nbre_frame=floor(N/fe);
Chromagramme=zeros(12,nbre_frame);
for j=1:nbre_frame
    Chromagramme(:,j)=make_chroma(Signal(fe*(j-1)+1:fe*j),fe,ecart);%la fonction make chroma est simplement appliqué à chaque seconde du signal et sauvegardée dans un tableau
end%chromagramme
end

