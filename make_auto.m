function auto_similarite=make_auto(Sig_gramme)
l=size(Sig_gramme);
auto_similarite=zeros(l(2),l(2));
for j=1:l(2)
    for k=1:j
        auto_similarite(j,k)=Sig_gramme(:,j)'*Sig_gramme(:,k);
        auto_similarite(k,j)=auto_similarite(j,k);
    end
end
auto_similarite=auto_similarite/max(max(auto_similarite));
end