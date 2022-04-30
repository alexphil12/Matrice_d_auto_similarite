function mfcc_gramme=make_mfcc_gramme(Signal,fe,nbr_filtre)
N=length(Signal);
nbre_frame=floor(N/fe);
mfcc_gramme=zeros(13,nbre_frame);
for j=1:nbre_frame
    mfcc_gramme(:,j)=make_mfcc(Signal(fe*(j-1)+1:fe*j),fe,nbr_filtre);
end
end