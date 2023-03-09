function []=kkmeans(type,K)
str=strcat(type,'_lv8760.mat');

data=load(str);
data=data.ldlv;
data(:,end)=[];

X = data;
% X = [randn(50,2)+ones(50,2);randn(50,2)-ones(50,2);randn(50,2)+[ones(50,1),-ones(50,1)]];
opts = statset('Display','off'); 
%  [��]=Kmeans(��,��Param1��,Val1,��Param2��,Val2,��)����������������ܣ�     
%  X :N*P�����ݾ���       K: ��ʾ��X����Ϊ���࣬Ϊ����       Idx :N*1���������洢����ÿ����ľ�����       C: K*P�ľ��󣬴洢����K����������λ��      sumD 1*K�ĺ��������洢����������е���������ĵ����֮��      D N*K�ľ��󣬴洢����ÿ�������������ĵľ���      [��]=Kmeans(��,'Param1',Val1,'Param2',Val2,��)      �����еĲ���Param1��Param2�ȣ���Ҫ��������Ϊ���£�      1. ��Distance��(������)        ��sqEuclidean�� ŷʽ���루Ĭ��ʱ�����ô˾��뷽ʽ��        ��cityblock�� �������ͣ��ֳƣ�L1        ��cosine�� �������        ��correlation��  �����ʱ���ϵ��ֵ        ��Hamming�� ֻ��Զ���������      2. ��Start������ʼ����λ��ѡ�񷽷���        ��sample�� ��X�����ѡȡK�����ĵ�        ��uniform�� ����X�ķֲ���Χ���ȵ��������K������        ��cluster�� ��ʼ����׶����ѡ��10%��X�����������˷�����ʼʹ�á�sample��������         matrix �ṩһK*P�ľ�����Ϊ��ʼ����λ�ü���      3. ��Replicates���������ظ�������  ����

%����Kmeans����? ? ?X :N*P�����ݾ��� K: ��ʾ��X����Ϊ���࣬Ϊ����
%X N*P�����ݾ���
%Idx N*1������,�洢����ÿ����ľ�����
%Ctrs K*P�ľ���,�洢����K����������λ��
%SumD 1*K�ĺ�����,�洢����������е���������ĵ����֮��
%D N*K�ľ��󣬴洢����ÿ�������������ĵľ���; 
% K = 200;
% [Idx,Ctrs,SumD,D] = kmeans(X,50,'Replicates',100,'Options',opts); 
[Idx,Ctrs,SumD,D] = kmeans(X,K,'Replicates',200,'Options',opts); 

% [Idx,Ctrs] = kmeans(X,K); 
% load = zeros(
dim=size(X,2);
for i =  1 : K
    Ctrs(i,dim+1) = sum(Idx==i);
end
ldlv = Ctrs;

if dim == 1
ldlv=sortrows(ldlv,-1);
end
if dim == 17
    cc = [1.08;0.97;1.8;0.74;0.71;1.36;1.25;1.71;1.75;1.95;2.65;1.94;3.17;1;3.33;1.81;1.28];
    for i = 1 : K
          ldlv(i,dim+2)=cc'*ldlv(i,1:dim)';
    end
    ldlv=sortrows(ldlv,-(dim+2));
    ldlv(:,end) =[];
end

str=strcat(type,'_lv',num2str(K),'.mat');
save(str,'ldlv');
% legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW');

% Ctrs

% SumD
% --------------------- 
% ���ߣ�SethChai 
% ��Դ��CSDN 
% ԭ�ģ�https://blog.csdn.net/a493823882/article/details/79282425 
% ��Ȩ����������Ϊ����ԭ�����£�ת���븽�ϲ������ӣ�