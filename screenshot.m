function []=screenshot(marker_positions,center_of_mass_position,adjacency_matrix,frame,t,show_center_of_mass)

frame_number=t-1+frame(1);

hold on
for index1=1:size(marker_positions,2)
    plot3(marker_positions{index1}(frame_number,1),marker_positions{index1}(frame_number,3),marker_positions{index1}(frame_number,2),'ro','MarkerFaceColor','r','Markersize',4);
end

if show_center_of_mass==1
    plot3(center_of_mass_position(frame_number,1),center_of_mass_position(frame_number,3),center_of_mass_position(frame_number,2),'go','MarkerFaceColor','g','Markersize',4);
end

for index1=1:size(marker_positions,2)
    for index2=1:size(marker_positions,2)
        if adjacency_matrix(index1,index2)
            line([marker_positions{index1}(frame_number,1),marker_positions{index2}(frame_number,1)],[marker_positions{index1}(frame_number,3),marker_positions{index2}(frame_number,3)],[marker_positions{index1}(frame_number,2),marker_positions{index2}(frame_number,2)],'Linewidth',1);
        end  
    end
end

xlabel('$x$','interpreter','latex','fontsize',14);
ylabel('$y$','interpreter','latex','fontsize',14);
set(get(gca,'YLabel'),'Rotation',0)
zlabel('$z$','interpreter','latex','fontsize',14);
set(get(gca,'ZLabel'),'Rotation',0)

set(gca,'DataAspectRatio',[1 1 1]);
%axis equal
%pbaspect([1/3,1,1])

view([300 10])
xlim([-600 600]);
ylim([-600 600]);
zlim([0 2000]);
grid on
   
end