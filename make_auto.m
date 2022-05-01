function auto_similarite=make_auto(Sig_gramme)
l=size(Sig_gramme);
auto_similarite=zeros(l(2),l(2));
for j=1:l(2)
    for k=1:j
        auto_similarite(l(2)-j+1,k)=Sig_gramme(:,j)'*Sig_gramme(:,k);% Trace l'autosimilarité en effectuant le produit scalaire de deux vecteurs"temporelles" plus ou
        auto_similarite(k,l(2)-j+1)=auto_similarite(l(2)-j+1,k);            %moins éloigné. Ensuite la case symétrique reçoit la même valeur.
    end
end
for j=1:l(2)
    for k=1:j
        auto_similarite(l(2)-j+1,k)=Sig_gramme(:,j)'*Sig_gramme(:,k);
        auto_similarite(k,l(2)-j+1)=auto_similarite(l(2)-j+1,k);
    end
end
auto_similarite=auto_similarite/max(max(auto_similarite));
end
