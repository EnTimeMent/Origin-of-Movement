function [markers_associated_with_a_reduced_marker,reduced_marker_associated_with_a_marker]=construct_correspondence_skeleton_models(marker_names,reduced_marker_names)

marker_names_associated_with_a_reduced_marker{1}={'ARIEL','RFHD','LFHD','LBHD','RBHD'};
marker_names_associated_with_a_reduced_marker{2}={'C7','CLAV'};
marker_names_associated_with_a_reduced_marker{3}={'T10'};
marker_names_associated_with_a_reduced_marker{4}={'BWT','LBWT','RBWT','RFWT','LFWT'};
marker_names_associated_with_a_reduced_marker{5}={'LSHO','LBSH','LFSH'};
marker_names_associated_with_a_reduced_marker{6}={'RSHO','RBSH','RFSH'};
marker_names_associated_with_a_reduced_marker{7}={'LIEL','LELB'};
marker_names_associated_with_a_reduced_marker{8}={'RIEL','RELB'};
marker_names_associated_with_a_reduced_marker{9}={'LOWR','LIWR'};
marker_names_associated_with_a_reduced_marker{10}={'ROWR','RIWR'};
marker_names_associated_with_a_reduced_marker{11}={'LPLM','LINDX','LPNKY'};
marker_names_associated_with_a_reduced_marker{12}={'RPLM','RINDX','RPNKY'};
marker_names_associated_with_a_reduced_marker{13}={'LFWT','LBWT'};
marker_names_associated_with_a_reduced_marker{14}={'RFWT','RBWT'};
marker_names_associated_with_a_reduced_marker{15}={'LKNE','LKNI'};
marker_names_associated_with_a_reduced_marker{16}={'RKNE','RKNI'};
marker_names_associated_with_a_reduced_marker{17}={'LANK','LHEL'};
marker_names_associated_with_a_reduced_marker{18}={'RANK','RHEL'};
marker_names_associated_with_a_reduced_marker{19}={'LMT1','LMT5'};
marker_names_associated_with_a_reduced_marker{20}={'RMT1','RMT5'};

for index1=1:size(reduced_marker_names,2)
    markers_associated_with_a_reduced_marker{index1}=[];
    for index2=1:size(marker_names,2)
        for index3=1:size(marker_names_associated_with_a_reduced_marker{index1},2)
            if strcmp(marker_names(index2),marker_names_associated_with_a_reduced_marker{index1}(index3))
                markers_associated_with_a_reduced_marker{index1}=[markers_associated_with_a_reduced_marker{index1};index2];
            end
        end
    end
end

for index1=1:size(marker_names,2)
    reduced_marker_associated_with_a_marker{index1}=[];
    for index2=1:size(reduced_marker_names,2)
        for index3=1:size(marker_names_associated_with_a_reduced_marker{index2},2)
            if strcmp(marker_names(index1),marker_names_associated_with_a_reduced_marker{index2}(index3))
                reduced_marker_associated_with_a_marker{index1}=[reduced_marker_associated_with_a_marker{index1};index2];
            end
        end
    end
end

end