function [reduced_marker_names,reduced_edge_names,reduced_edges,reduced_adjacency_matrix]=construct_mocap_reduced_skeleton()

reduced_marker_names={'head', 'shoulder_center', 'spine', 'hip_center', 'left_shoulder', 'right_shoulder', 'left_elbow', 'right_elbow', 'left_wrist', 'right_wrist', 'left_hand', 'right_hand', 'left_hip', 'right_hip', 'left_knee','right_knee','left_ankle', 'right_ankle', 'left_foot', 'right_foot'};

reduced_edge_names{1}={'head','shoulder_center'};
reduced_edge_names{2}={'right_shoulder','shoulder_center'};
reduced_edge_names{3}={'left_shoulder','shoulder_center'};
reduced_edge_names{4}={'right_shoulder','right_elbow'};
reduced_edge_names{5}={'right_wrist','right_elbow'};
reduced_edge_names{6}={'right_wrist','right_hand'};
reduced_edge_names{7}={'left_shoulder','left_elbow'};
reduced_edge_names{8}={'left_wrist','left_elbow'};
reduced_edge_names{9}={'left_wrist','left_hand'};
reduced_edge_names{10}={'spine','shoulder_center'};
reduced_edge_names{11}={'spine','hip_center'};
reduced_edge_names{12}={'right_hip','hip_center'};
reduced_edge_names{13}={'left_hip','hip_center'};
reduced_edge_names{14}={'right_hip','right_knee'};
reduced_edge_names{15}={'right_ankle','right_knee'};
reduced_edge_names{16}={'right_ankle','right_foot'};
reduced_edge_names{17}={'left_hip','left_knee'};
reduced_edge_names{18}={'left_ankle','left_knee'};
reduced_edge_names{19}={'left_ankle','left_foot'};
    
for index1=1:size(reduced_marker_names,2)
    for index2=1:size(reduced_edge_names,2)
        for index3=1:2
            if strcmp(reduced_marker_names(index1),reduced_edge_names{index2}(index3))
                reduced_edges(index2,index3)=index1;
            end
        end
    end
end

%n1=[1 17 19 17 12 18 9 4 10 19 20 2 2 15 16 11 7 8 3]; 
%n2=[19 19 9 12 18 14 4 10 6 20 2 15 7 16 11 13 8 3 5];

reduced_adjacency_matrix=zeros(size(reduced_marker_names,2));

for index1=1:size(reduced_marker_names,2)
    for index2=1:size(reduced_marker_names,2)
        for index3=1:size(reduced_edges,1)
            if (index1==reduced_edges(index3,1) && index2==reduced_edges(index3,2)) || (index1==reduced_edges(index3,2) && index2==reduced_edges(index3,1))
                reduced_adjacency_matrix(index1,index2)=1;
            end
        end
    end
 end

end