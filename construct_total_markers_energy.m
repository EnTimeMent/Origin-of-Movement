function total_markers_energy=construct_total_markers_energy(marker_energy)

total_markers_energy=zeros(size(marker_energy{1}));

for k=1:size(marker_energy,2)
    total_markers_energy=total_markers_energy+marker_energy{k};
end