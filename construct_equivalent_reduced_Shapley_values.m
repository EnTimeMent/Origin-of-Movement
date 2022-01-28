function [equivalent_reduced_Shapley_values,max_normalized_equivalent_reduced_Shapley_values,utility_normalized_equivalent_reduced_Shapley_values,mean_utility_normalized_equivalent_reduced_Shapley_values]=construct_equivalent_reduced_Shapley_values(Shapley_values,markers_associated_with_a_reduced_marker)

equivalent_reduced_Shapley_values=zeros(size(Shapley_values,1),size(markers_associated_with_a_reduced_marker,2));

for k=1:size(markers_associated_with_a_reduced_marker,2)
    for index1=1:size(markers_associated_with_a_reduced_marker{k},1)
        equivalent_reduced_Shapley_values(:,k)=equivalent_reduced_Shapley_values(:,k)+Shapley_values(:,markers_associated_with_a_reduced_marker{k}(index1));
    end
    equivalent_reduced_Shapley_values(:,k)=equivalent_reduced_Shapley_values(:,k)/size(markers_associated_with_a_reduced_marker{k},1);
end

norm_factor=max(equivalent_reduced_Shapley_values')';
utility_norm_factor=sum(equivalent_reduced_Shapley_values,2);

norm_factor_matrix=repmat(norm_factor,1,size(equivalent_reduced_Shapley_values,2));
utility_norm_factor_matrix=repmat(utility_norm_factor,1,size(equivalent_reduced_Shapley_values,2));

max_normalized_equivalent_reduced_Shapley_values=equivalent_reduced_Shapley_values./norm_factor_matrix;
utility_normalized_equivalent_reduced_Shapley_values=equivalent_reduced_Shapley_values./utility_norm_factor_matrix;
mean_utility_normalized_equivalent_reduced_Shapley_values=nanmean(utility_normalized_equivalent_reduced_Shapley_values,1);

end