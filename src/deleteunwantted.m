%% 
%在体数据中做阈值处理
% dataref=vdata;  %参考数据
% data=vdata;  %要处理的数据
% thred=50;  %阈值
% data=(dataref>50).*data;
% data=smooth3(data);
%% 
% 体数据中取出非联通的小区域


% fv输入，fv_main 输出
%三角片数据中去除非联通的小区域

fring = compute_face_ring(fv.faces);
visited=0;
total_mesh=length(fring);
region_stat=zeros(1,total_mesh);
seed=0;
region_index=0;
while visited<total_mesh
    for i=1:total_mesh
        if region_stat(i)==0
            seed=i;
            region_index=region_index+1;
            visitlist=[i];
            region_stat(i)=region_index;
            break;
        end
    end
    while isempty(visitlist)==0
        for i=1:length(fring{visitlist(1)})
            if region_stat(fring{visitlist(1)}(i))==0
               region_stat(fring{visitlist(1)}(i))=region_index;
               visitlist(1+length(visitlist))=fring{visitlist(1)}(i);
            end
        end
        visitlist(1)=[];
    end
    visited=sum(region_stat>0);
end
clear visitlist visited i seed total_mesh
for i=1:region_index
    region_f{i}=fv.faces(find(region_stat==i),:);
end
fv_main=fv;
[k,kk]=hist(region_stat,max(region_stat));
k=find(k==max(k));
fv_main.faces=region_f{k};
%这里还需要分离出vertex
vertex_of=reshape(fv_main.faces,1,size(fv_main.faces,1)*size(fv_main.faces,2));
point_from_orig=sort(unique(vertex_of));
pt_deleted=setdiff(1:size(fv.vertices,1),point_from_orig);%去除的点标号
vertex=fv.vertices(point_from_orig,:);%新的节点坐标
fv_main.vertices=vertex;
for i=1:length(vertex_of)
    vertex_of(i)=vertex_of(i)-sum(pt_deleted<vertex_of(i));
end
fv_main.faces=reshape(vertex_of,length(vertex_of)/3,3);
fv_main.NormalMode='auto';
fv=fv_main;
clear vertex_of i vertex pt_deleted point_from_orig k kk fv_main

