function [reduced_marker_positions,reduced_center_of_mass_position,reduced_relative_marker_positions]=extract_reduced_marker_positions(reduced_marker_names,marker_positions,markers_associated_with_a_reduced_marker);

for index1=1:size(reduced_marker_names,2)
    reduced_marker_positions{index1}=zeros(size(marker_positions{1}));
    for index2=1:size(markers_associated_with_a_reduced_marker{index1},1)
        reduced_marker_positions{index1}=reduced_marker_positions{index1}+marker_positions{markers_associated_with_a_reduced_marker{index1}(index2)};
    end
    reduced_marker_positions{index1}=reduced_marker_positions{index1}/size(markers_associated_with_a_reduced_marker{index1},1);
end


reduced_center_of_mass_position=zeros(size(reduced_marker_positions{1}));
for k=1:size(reduced_marker_names,2)
    reduced_center_of_mass_position=reduced_center_of_mass_position+reduced_marker_positions{k};
end
reduced_center_of_mass_position=reduced_center_of_mass_position/size(reduced_marker_names,2);

for k=1:size(reduced_marker_names,2)
    reduced_relative_marker_positions{k}=reduced_marker_positions{k}-reduced_center_of_mass_position;
end

end