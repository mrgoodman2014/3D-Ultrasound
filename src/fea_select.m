%%      特征点提取
%% 输入 vd  panju   输出  pt_fea

panju=3.2;
len=sum(sum(sum(vd>panju)));
pt_fea=zeros(len,3);
temp=0;
for i=1:size(vd,1)
    for j=1:size(vd,2)
        for k=1:size(vd,3)
            if lap(i,j,k)>panju
                temp=temp+1;
                pt_fea(temp,:)=[i,j,k];
            end
        end
    end
    i
end