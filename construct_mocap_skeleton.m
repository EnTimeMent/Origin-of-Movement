function [marker_names,edge_names,edges,adjacency_matrix]=construct_mocap_skeleton()

marker_names={'RFHD','LFHD','RBHD','LBHD','ARIEL' ... 
       ,'C7','LSHO','RSHO','LBSH','RBSH','T5','T10','BWT','LBWT','RBWT' ...
       ,'STRN','CLAV','LFSH','RFSH','FWT','RFWT','LFWT' ...
       ,'LFUPA','LBUPA','LIEL','LELB','LFRM','LOWR','LIWR','RFUPA','RBUPA','RIEL','RELB','RFRM','ROWR','RIWR' ...
       ,'LPLM','LTHMB','LPNKY','RPLM','RTHMB','RPNKY' ...
       ,'LFTHI','LBTHI','LKNE','LKNI','LSHN','LANK','RFTHI','RBTHI','RKNE','RKNI','RSHN','RANK','LHEL','RHEL' ...
       'LMT1','LMT5','RMT1','RMT5','RINDX','LINDX'};
   
edge_names{1}={'ARIEL','RFHD'};
edge_names{2}={'ARIEL','LFHD'};
edge_names{3}={'ARIEL','RBHD'};
edge_names{4}={'ARIEL','LBHD'};
edge_names{5}={'RFHD','RBHD'};
edge_names{6}={'LFHD','LBHD'};
edge_names{7}={'RFHD','LFHD'};
edge_names{8}={'RBHD','LBHD'};
edge_names{9}={'ARIEL','C7'};

edge_names{10}={'C7','RSHO'};
edge_names{11}={'C7','LSHO'};
edge_names{12}={'RSHO','RFSH'};
edge_names{13}={'LSHO','LFSH'};
edge_names{14}={'RFSH','STRN'};
edge_names{15}={'LFSH','STRN'};

edge_names{16}={'RSHO','RFUPA'};
edge_names{17}={'RSHO','RBUPA'};
edge_names{18}={'RFUPA','RBUPA'};
edge_names{19}={'RFUPA','RIEL'};
edge_names{20}={'RIEL','RIWR'};
edge_names{21}={'RBUPA','RELB'};
edge_names{22}={'RELB','ROWR'};
edge_names{23}={'RELB','RIEL'};
edge_names{24}={'RELB','RFRM'};
edge_names{25}={'RFRM','RIEL'};

edge_names{26}={'LSHO','LFUPA'};
edge_names{27}={'LSHO','LBUPA'};
edge_names{28}={'LFUPA','LBUPA'};
edge_names{29}={'LFUPA','LIEL'};
edge_names{30}={'LIEL','LIWR'};
edge_names{31}={'LBUPA','LELB'};
edge_names{32}={'LELB','LOWR'};
edge_names{33}={'LELB','LIEL'};
edge_names{34}={'LELB','LFRM'};
edge_names{35}={'LFRM','LIEL'};

edge_names{36}={'LBWT','BWT'};
edge_names{37}={'RBWT','BWT'};
edge_names{38}={'LBWT','LFWT'};
edge_names{39}={'RBWT','RFWT'};
edge_names{40}={'RFWT','FWT'};
edge_names{41}={'LFWT','FWT'};

edge_names{42}={'STRN','CLAV'};
edge_names{43}={'CLAV','FWT'};

edge_names{44}={'LSHO','LBSH'};
edge_names{45}={'RSHO','RBSH'};
edge_names{46}={'LBSH','T5'};
edge_names{47}={'RBSH','T5'};
edge_names{48}={'T5','T10'};
edge_names{49}={'T10','BWT'};

edge_names{50}={'RBTHI','RBWT'};
edge_names{51}={'RBTHI','RFWT'};
edge_names{52}={'RBTHI','RFTHI'};
edge_names{53}={'RFTHI','RKNE'};
edge_names{54}={'RFTHI','RKNI'};
edge_names{55}={'RSHN','RKNE'};
edge_names{56}={'RSHN','RKNI'};
edge_names{57}={'RSHN','RANK'};

edge_names{58}={'LBTHI','LBWT'};
edge_names{59}={'LBTHI','LFWT'};
edge_names{60}={'LBTHI','LFTHI'};
edge_names{61}={'LFTHI','LKNE'};
edge_names{62}={'LFTHI','LKNI'};
edge_names{63}={'LSHN','LKNE'};
edge_names{64}={'LSHN','LKNI'};
edge_names{65}={'LSHN','LANK'};

edge_names{66}={'RANK','RHEL'};
edge_names{67}={'LANK','LHEL'};

edge_names{68}={'RHEL','RMT1'};
edge_names{69}={'RHEL','RMT5'};
edge_names{70}={'RMT1','RMT5'};
edge_names{71}={'RMT1','RTOE'};
edge_names{72}={'RMT5','RTOE'};

edge_names{73}={'LHEL','LMT1'};
edge_names{74}={'LHEL','LMT5'};
edge_names{75}={'LMT1','LMT5'};
edge_names{76}={'LMT1','LTOE'};
edge_names{77}={'LMT5','LTOE'};

edge_names{78}={'RPLM','ROWR'};
edge_names{79}={'RPLM','RIWR'};
edge_names{80}={'RPLM','RPNKY'};
edge_names{81}={'RPLM','RTHMB'};
edge_names{82}={'RPLM','RINDX'};

edge_names{83}={'LPLM','LOWR'};
edge_names{84}={'LPLM','LIWR'};
edge_names{85}={'LPLM','LPNKY'};
edge_names{86}={'LPLM','LTHMB'};
edge_names{87}={'LPLM','LINDX'};
   
for index1=1:size(marker_names,2)
    for index2=1:size(edge_names,2)
        for index3=1:2
            if strcmp(marker_names(index1),edge_names{index2}(index3))
                edges(index2,index3)=index1;
            end
        end
    end
end

adjacency_matrix=zeros(size(marker_names,2));

for index1=1:size(marker_names,2)
    for index2=1:size(marker_names,2)
        for index3=1:size(edges,1)
            if (index1==edges(index3,1) && index2==edges(index3,2)) || (index1==edges(index3,2) && index2==edges(index3,1))
                adjacency_matrix(index1,index2)=1;
            end
    end
end
    
end