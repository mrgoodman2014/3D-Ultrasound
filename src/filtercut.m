
moren=min(min(min(oper)));
if min_v==-1000
    min_v=min(min(min(ref)));
end
if max_v==-1000
    max_v=max(max(max(ref)));
end

for i=1:size(ref,1)
    for j=1:size(ref,2)
        for k=1:size(ref,3)
            if ref(i,j,k)>=min_v && ref(i,j,k)<=max_v
               oper(i,j,k)=moren;
            end
        end
    end
end
clear moren min_v max_v i j k