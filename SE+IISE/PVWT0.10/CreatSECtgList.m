function [ CtgList, CpntList ] = CreatSECtgList( mpc, CtgLevelMax )
%CREATCTGLIST create contingency list 
%   Edited by Hou

%% Initialization
BrNum = size(mpc.branch, 1);
GenNum = size(mpc.origen, 1);
CtgNum = BrNum + GenNum;
% CtgNum =  BrNum;
CpntList = [ones(GenNum, 1),    [1: GenNum].';          % [�豸����(1:G, 2:Br)��G/Br���]
            2 * ones(BrNum, 1), [1: BrNum].'];
% CpntList = [2*ones(BrNum, 1),  (1: BrNum).'];       % [�豸����(1:G, 2:Br)��G/Br���]

% CtgRevMtrx = full(CtgRevMtrx);
% BrU = mpc.BrOutage ./ (mpc.BrOutage + mpc.BrRepair); 
BrU = mpc.branch(:,5);
GenU = mpc.origen(:,3);
BrA = 1 - BrU;
GenA = 1 - GenU;
CpntU = [GenU; BrU]; CpntA = [GenA; BrA];
% CpntU = BrU; CpntA = BrA;
% delete components that availability = 1;
CpntA1 = 1 == CpntA;
CpntList(CpntA1, :) = [];
CpntU(CpntA1, :) = [];
CpntA(CpntA1, :) = [];
CtgNum = CtgNum - sum(CpntA1);

NormalProb = prod(CpntA);
CtgList{1} = zeros(CtgNum, 2);   %[Ctg�豸���  ���ϸ���]
CtgList{1}(:, 1) = [1: CtgNum].';
CtgList{1}(:, 2) = NormalProb ./ CpntA .* CpntU;
CtgList{1}(:, 3) = CpntU;
parfor CtgLevel = 2: CtgLevelMax   % ѭ���¹ʽ�����ÿһ������һ������
    if CtgLevel > 2
            CtgListTmp = nchoosek(1: GenNum, CtgLevel);
    else
            CtgListTmp = nchoosek(1: CtgNum, CtgLevel);
    end
    CtgProb = NormalProb ./ prod(CpntA(CtgListTmp), 2) .* prod(CpntU(CtgListTmp), 2);
    CtgProb1 = 1;
    for i = 1 : CtgLevel
        CtgProb1 = CtgProb1 .* CpntU(CtgListTmp(:,i));
    end
    %.* CpntU(CtgListTmp(:,2));
    CtgList{CtgLevel} = [CtgListTmp, CtgProb,CtgProb1];

end

end