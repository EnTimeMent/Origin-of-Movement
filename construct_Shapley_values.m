function [Shapley_values,max_normalized_Shapley_values,utility_normalized_Shapley_values,mean_utility_normalized_Shapley_values]=construct_Shapley_values(auxiliary_graph)

%weighted degree centrality version

Shapley_values=zeros(size(auxiliary_graph,2),size(auxiliary_graph{1},1));

for k=1:size(auxiliary_graph,2)
    for index1=1:size(auxiliary_graph{1},1)
        for index2=1:size(auxiliary_graph{1},1)
            Shapley_values(k,index1)=Shapley_values(k,index1)+0.5*auxiliary_graph{k}(index1,index2);
        end
    end
end

norm_factor=max(Shapley_values')';
utility_norm_factor=sum(Shapley_values,2);

norm_factor_matrix=repmat(norm_factor,1,size(auxiliary_graph{1},1));
utility_norm_factor_matrix=repmat(utility_norm_factor,1,size(auxiliary_graph{1},1));

max_normalized_Shapley_values=Shapley_values./norm_factor_matrix;
utility_normalized_Shapley_values=Shapley_values./utility_norm_factor_matrix;
mean_utility_normalized_Shapley_values=nanmean(utility_normalized_Shapley_values,1);

end