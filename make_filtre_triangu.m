function filtre=make_filtre_triangu(f_m_minus,f_m,f_m_plus,fe)
h=f_m_minus;
filtre=zeros(1,floor(fe/2));
if(f_m_minus~=f_m &&f_m~=f_m_plus)
    for k=f_m_minus:f_m
        filtre(h)=-(k-f_m_minus)/(f_m-f_m_plus);
        h=h+1;
    end    
    for d=f_m:f_m_plus
        filtre(h)=(f_m_plus-d)/(f_m_plus-f_m);
        h=h+1;
    end
else
    filtre(f_m)=1;
end
end
