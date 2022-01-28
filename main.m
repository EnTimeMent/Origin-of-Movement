clear all;
close all;
clc;

[marker_names,edge_names,edges,adjacency_matrix]=construct_mocap_skeleton();
%construction of the skeleton model for the 62-markers case (this should be
%updated in case of a different model). In some recordings, a different
%number/identity of the markers was used, so in these cases the model
%should be changed. Moreover, in more recent recordings, a different model
%was used

[reduced_marker_names,reduced_edge_names,reduced_edges,reduced_adjacency_matrix]=construct_mocap_reduced_skeleton();
%the same for the reduced model wih 20 markers

[markers_associated_with_a_reduced_marker,reduced_marker_associated_with_a_marker]=construct_correspondence_skeleton_models(marker_names,reduced_marker_names);
%correspondence between markers in the two models

filename='2016-03-22_t002_300-1800';

[frame,time,duration,marker_positions,center_of_mass_position,relative_marker_positions]=extract_marker_positions(marker_names,filename);
%extraction of data from the tsv file for the full model

[reduced_marker_positions,reduced_center_of_mass_position,reduced_relative_marker_positions]=extract_reduced_marker_positions(reduced_marker_names,marker_positions,markers_associated_with_a_reduced_marker);
%the same for the reduced model

t=1000;
show_center_of_mass=0;
%alternative: show_center_of_mass=1

close all
figure(1)
screenshot(marker_positions,center_of_mass_position,adjacency_matrix,frame,t,show_center_of_mass);
%screenshot of the marker set for the full model (it would be nice to
%obtain a movie from this)

figure(2)
screenshot(reduced_marker_positions,reduced_center_of_mass_position,reduced_adjacency_matrix,frame,t,show_center_of_mass);
%the same for the reduced model

smoothing=1;
%alternative: smoothing=0 (no smoothing is performed). The parameters of the smoothing are inside the following function, and could be changed

[marker_speed,marker_tangential_acceleration,marker_energy,marker_angular_momentum]=extract_basic_features(marker_positions,center_of_mass_position,relative_marker_positions,duration,smoothing);
%extraction of some basic features for the full model (a basic smoothing step is
%done here, but further data cleaning would be needed)..this code could be modified to insert other features

[reduced_marker_speed,reduced_marker_tangential_acceleration,reduced_marker_energy,reduced_marker_angular_momentum]=extract_basic_features(reduced_marker_positions,reduced_center_of_mass_position,reduced_relative_marker_positions,duration,smoothing);
%the same for the reduced model

total_markers_energy=construct_total_markers_energy(marker_energy);
%construction of a potentially useful global feature

total_reduced_markers_energy=construct_total_markers_energy(reduced_marker_energy);

N_clusters=4;%12;
%maximum number of clusters for the full model

reduced_N_clusters=4;
%here, the same number has been selected for the reduced model

weights_matrix=[1 0 0 0;
                0 1 0 0;
                0 0 1 0;
                0 0 0 1];
%the weights in each row correspond to a single analysis. There are the
%weights of the 4 features considered so far. The features have different
%orders of magnitude, so some normalization (or a different order of
%magnitude of the weight of each feauture) is likely needed in case the
%features will be combined in the future
            
for k=1:size(weights_matrix,1)
    weights=weights_matrix(k,:);
    
    [marker_weighted_feature_vectors,marker_angular_momentum_feature]=construct_weighted_feature_vectors(weights,marker_speed,marker_tangential_acceleration,marker_energy,marker_angular_momentum);
    %the first three features are combined using the weights; the fourth
    %one is kept apart, since it requires a different processing later

    [reduced_marker_weighted_feature_vectors,reduced_marker_angular_momentum_feature]=construct_weighted_feature_vectors(weights,reduced_marker_speed,reduced_marker_tangential_acceleration,reduced_marker_energy,reduced_marker_angular_momentum);

    weight_angular_momentum_feature=weights(4);
    
    weight_matrix=construct_weight_matrix(adjacency_matrix,marker_weighted_feature_vectors,weight_angular_momentum_feature,marker_angular_momentum_feature);
    %a weighted adjacency matrix is constructed for each frame, considering
    %both physical edges and bridge edges (see the paper)
    
    reduced_weight_matrix=construct_weight_matrix(reduced_adjacency_matrix,reduced_marker_weighted_feature_vectors,weight_angular_momentum_feature,reduced_marker_angular_momentum_feature);

    auxiliary_graph=construct_auxiliary_graph(weight_matrix,adjacency_matrix,marker_weighted_feature_vectors,marker_angular_momentum_feature,weight_angular_momentum_feature,N_clusters);
    %the auxiliary graph is constructed (see the paper)
    
    reduced_auxiliary_graph=construct_auxiliary_graph(reduced_weight_matrix,reduced_adjacency_matrix,reduced_marker_weighted_feature_vectors,reduced_marker_angular_momentum_feature,weight_angular_momentum_feature,reduced_N_clusters);

    [Shapley_values,max_normalized_Shapley_values,utility_normalized_Shapley_values,mean_utility_normalized_Shapley_values]=construct_Shapley_values(auxiliary_graph);
    %the Shapley values are found (see the paper): in this case, for
    %simplicity they are just weighted degree centralities for the
    %auxiliary graph. Several normalizations are done (division by the maximum Shapley value for frame, and division by the summation of all Shapley values for frame). Since they are quite noisy, in the future, it
    %would be better to compute them only for specific fragments in which
    %there is a clear origin of movement. To reduced the noise, it would be better also to
    %perform the analysis by making an average of the feature values over
    %a larger number of frames, and considering different time scales
    
    [reduced_Shapley_values,max_normalized_reduced_Shapley_values,utility_normalized_reduced_Shapley_values,mean_utility_normalized_reduced_Shapley_values]=construct_Shapley_values(reduced_auxiliary_graph);

    final_analysis_reduced_Shapley_values{k}=reduced_Shapley_values;
    final_analysis_max_normalized_reduced_Shapley_values{k}=max_normalized_reduced_Shapley_values;
    final_analysis_utility_normalized_reduced_Shapley_values{k}=utility_normalized_reduced_Shapley_values;
    
    [equivalent_reduced_Shapley_values,max_normalized_equivalent_reduced_Shapley_values,utility_normalized_equivalent_reduced_Shapley_values,mean_utility_normalized_equivalent_reduced_Shapley_values]=construct_equivalent_reduced_Shapley_values(Shapley_values,markers_associated_with_a_reduced_marker);
    %here, the Shapley values for the full model are mapped in some way to
    %the ones for the reduced model
    
    mean_kendall_correlation_original_reduced_Shapley_values{k}=find_mean_kendall_correlation(reduced_Shapley_values,equivalent_reduced_Shapley_values);
    %average of the Kendall correlation between two different rankings
end

mean_kendall_correlation_Shapley_values=zeros(size(weights_matrix));

for h=1:size(weights_matrix,1)
    for k=1:size(weights_matrix,1)
        mean_kendall_correlation_Shapley_values(h,k)=find_mean_kendall_correlation(final_analysis_reduced_Shapley_values{h},final_analysis_reduced_Shapley_values{k});
        %average of the Kendall correlation between two different rankings
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:size(reduced_marker_names,2)
    new_reduced_marker_names{k} = strrep(reduced_marker_names{k},'_',' ');
end

figure(3)
for k=1:size(reduced_marker_speed,2)
    subplot(5,4,k)
    plot(time-time(1),reduced_marker_speed{k},'b')
    xlabel('$t$','interpreter','latex','fontsize',14)
    ylabel('$\|\underline{v}\|$','interpreter','latex','fontsize',14)
    set(get(gca,'YLabel'),'Rotation',0)
    label_h = ylabel('$\|\underline{v}\|$','fontsize',14);
    label_h.Position(1) = -3; % change horizontal position of ylabel
    %label_h.Position(2) = -1; % change vertical position of ylabel
    title(['marker {\iti}=' num2str(k) ' (' char(new_reduced_marker_names(k)) ')']);
end 
%plot of the speed feature for all the markers of the reduced model (some
%further noise reduction is likely needed)

data=movmedian(final_analysis_reduced_Shapley_values{1},5);
data=movmean(data,25);

figure(4)
for k=1:size(reduced_marker_speed,2)
    subplot(5,4,k)
    plot(time-time(1),data(:,k),'b')
    xlabel('$t$','interpreter','latex','fontsize',14)
    ylabel('$Sh_i$','interpreter','latex','fontsize',14)
    set(get(gca,'YLabel'),'Rotation',0)
    label_h = ylabel('$Sh_i$','interpreter','latex','fontsize',14);
    label_h.Position(1) = -3; % change horizontal position of ylabel
    %label_h.Position(2) = -1; % change vertical position of ylabel
    title(['marker {\iti}=' num2str(k) ' (' char(new_reduced_marker_names(k)) ')']);
end 
%plot of the Shapley values for all the markers of the reduced model (some
%further noise reduction is likely needed)

data=movmedian(final_analysis_reduced_Shapley_values{1},5);
data=movmean(data,25);

max_data=max(data')';
max_data=movmedian(max_data,5);
max_data=movmean(max_data,25);

figure(5)
hold on
plot(time(300:1300)-time(1),max_data(300:1300),'b');
plot(time(300:1300)-time(1),total_reduced_markers_energy(300:1300),'r');
xlabel('$t$','interpreter','latex','fontsize',14)
ylabel('${\rm max}_{i=1,\ldots,20} Sh_i,K$','interpreter','latex','fontsize',14)
%label_h = ylabel('${\rm max}_{i=1,\ldots,20} Sh_i,K$','Fontsize',14)
%label_h.Position(1) = -1; % change horizontal position of ylab
%set(get(gca,'YLabel'),'Rotation',0)
legend({'max Shapley value','total kinetic energy'})
xlim([3,14])
%by looking at another global feature, one may try to find "interesting
%fragments" on which one could concentrate the analysis

correlation=corr(total_reduced_markers_energy(300:1300),max_data(300:1300),'type','Spearman','rows','complete')
title(['Spearman''s correlation \rho=' num2str(correlation)])