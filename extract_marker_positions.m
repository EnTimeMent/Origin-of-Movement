function [frame,time,duration,marker_positions,center_of_mass_position,relative_marker_positions]=extract_marker_positions(marker_names,filename)

data=readtable(['Sample_Data/original_mocap/' char(filename) '.tsv'],'Filetype', 'text');

frame=table2array(data(:,1));
time=table2array(data(:,2));
duration=table2array(data(end,2))-table2array(data(1,2));

for k=1:size(marker_names,2)
    marker_positions{k}=[eval(['data.' char(marker_names(k)) 'X']),eval(['data.' char(marker_names(k)) 'Y']),eval(['data.' char(marker_names(k)) 'Z'])];
end

center_of_mass_position=zeros(size(marker_positions{1}));
for k=1:size(marker_names,2)
    center_of_mass_position=center_of_mass_position+marker_positions{k};
end
center_of_mass_position=center_of_mass_position/size(marker_names,2);

for k=1:size(marker_names,2)
    relative_marker_positions{k}=marker_positions{k}-center_of_mass_position;
end

end