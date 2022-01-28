function [marker_speed,marker_tangential_acceleration,marker_energy,marker_angular_momentum]=extract_basic_features(marker_positions,center_of_mass_position,relative_marker_positions,duration,smoothing)

for index1=1:size(marker_positions,2)
    marker_speed{index1}(1,1)=NaN;
    temp=diff(marker_positions{index1})*duration/size(marker_positions{index1},1);
    for index2=1:size(marker_positions{index1},1)-1
        marker_speed{index1}(index2+1,1)=norm(temp(index2,:));
    end
    if smoothing==1
        %order=5;
        %framelength=27;
        %marker_speed{index1}=sgolayfilt(marker_speed{index1},order,framelength);
        marker_speed{index1}=movmedian(marker_speed{index1},5);
        marker_speed{index1}=movmean(marker_speed{index1},25);
    end 
end

for index1=1:size(marker_positions,2)
    marker_energy{index1}=1/2*marker_speed{index1}.^2;
    if smoothing==1
        %order=5;
        %framelength=27;
        %marker_energy{index1}=sgolayfilt(marker_energy{index1},order,framelength);
        marker_energy{index1}=movmedian(marker_energy{index1},5);
        marker_energy{index1}=movmean(marker_energy{index1},25);
    end 
end

for index1=1:size(marker_speed,2)
    marker_tangential_acceleration{index1}(1,1)=NaN;
    temp=diff(marker_speed{index1})*duration/size(marker_speed{index1},1);
    for index2=1:size(marker_speed{index1},1)-1
        marker_tangential_acceleration{index1}(index2+1,1)=abs(temp(index2,:));
    end
    if smoothing==1
        %order=5;
        %framelength=27;
        %marker_tangential_acceleration{index1}=sgolayfilt(marker_tangential_acceleration{index1},order,framelength);
        marker_tangential_acceleration{index1}=movmedian(marker_tangential_acceleration{index1},5);  
        marker_tangential_acceleration{index1}=movmean(marker_tangential_acceleration{index1},25);  
    end 
end

for index1=1:size(marker_speed,2)
    marker_angular_momentum{index1}(1,1:3)=NaN;
    marker_velocity=diff(marker_positions{index1})*duration/size(marker_positions{index1},1);
    center_of_mass_velocity=diff(center_of_mass_position)*duration/size(center_of_mass_position,1);
    relative_marker_velocity=marker_velocity-center_of_mass_velocity;
    for index2=1:size(marker_speed{index1},1)-1
        marker_angular_momentum{index1}(index2+1,1:3)=cross(relative_marker_positions{index1}(index2,:),relative_marker_velocity(index2,:));
    end
    if smoothing==1
        %order=5;
        %framelength=27;
        %marker_angular_momentum{index1}=sgolayfilt(marker_angular_momentum{index1},order,framelength);
        marker_angular_momentum{index1}=movmedian(marker_angular_momentum{index1},5);  
        marker_angular_momentum{index1}=movmean(marker_angular_momentum{index1},25);  
    end 
end

end