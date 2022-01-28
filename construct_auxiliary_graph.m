function auxiliary_graph=construct_auxiliary_graph(weight_matrix,adjacency_matrix,marker_weighted_feature_vectors,marker_angular_momentum_feature,weight_angular_momentum_feature,N_clusters)

for k=1:size(weight_matrix,2)
    if sum(sum(isnan(weight_matrix{k}))) || sum(sum(isinf(weight_matrix{k})))
        clusters(k,:)=nan(1,size(weight_matrix{k},1));
        auxiliary_graph{k}=nan(size(weight_matrix{k}));
    else
        clusters(k,:)=cluster_shi_r(weight_matrix{k},N_clusters,'ncut');
        auxiliary_graph{k}=zeros(size(weight_matrix{k}));
        for index1=1:size(weight_matrix{k},1)-1
            for index2=index1+1:size(weight_matrix{k},2)
                check=adjacency_matrix(index1,index2);
                if (check==1 && clusters(k,index1)~=clusters(k,index2))
                    auxiliary_graph{k}(index1,index2)=norm(marker_weighted_feature_vectors{index1}(k,:)-marker_weighted_feature_vectors{index2}(k,:))+weight_angular_momentum_feature*norm(marker_angular_momentum_feature{index1}(k,:)-marker_angular_momentum_feature{index2}(k,:));
                    auxiliary_graph{k}(index2,index1)=auxiliary_graph{k}(index1,index2);
                end
            end
        end
        
    end
    
end

end