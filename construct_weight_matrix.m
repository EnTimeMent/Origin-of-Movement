function weight_matrix=construct_weights_matrix(adjacency_matrix,marker_weighted_feature_vectors,weight_angular_momentum_feature,marker_angular_momentum_feature)

for k=1:size(marker_weighted_feature_vectors{1},1)
    for index1=1:size(adjacency_matrix,1)
        tolerance_temp(k,index1)=norm(marker_weighted_feature_vectors{index1}(k,:))*10^(-3);
    end
end

tolerance=mean(nanmean(tolerance_temp));

for k=1:size(marker_weighted_feature_vectors{1},1)
    weight_matrix_1{k}=zeros(size(adjacency_matrix));
    for index1=1:size(adjacency_matrix,1)-1
        for index2=index1+1:size(adjacency_matrix,2)
            check=adjacency_matrix(index1,index2);
            if check==1
                weight_matrix_1{k}(index1,index2)=1/(norm(marker_weighted_feature_vectors{index1}(k,:)-marker_weighted_feature_vectors{index2}(k,:))+tolerance);
                weight_matrix_1{k}(index2,index1)=weight_matrix_1{k}(index1,index2);
           end
           if check==0
               weight_matrix_1{k}(index1,index2)=1/(5*norm(marker_weighted_feature_vectors{index1}(k,:)-marker_weighted_feature_vectors{index2}(k,:))+tolerance);
               weight_matrix_1{k}(index2,index1)=weight_matrix_1{k}(index1,index2);
           end
       end
   end
   
end

if tolerance==0
    for k=1:size(marker_weighted_feature_vectors{1},1)
        weight_matrix_1{k}=zeros(size(adjacency_matrix));
    end
end
    
for k=1:size(marker_weighted_feature_vectors{1},1)
    weight_matrix_2{k}=zeros(size(adjacency_matrix));
    for index1=1:size(adjacency_matrix,1)-1
        for index2=index1+1:size(adjacency_matrix,2)
            check=adjacency_matrix(index1,index2);
            if check==1
                if ~isnan(norm(marker_angular_momentum_feature{index1}(k,:)*norm(marker_angular_momentum_feature{index2}(k,:)))) && ~isinf(norm(marker_angular_momentum_feature{index1}(k,:)*norm(marker_angular_momentum_feature{index2}(k,:))))
                    temp=dot(marker_angular_momentum_feature{index1}(k,:),marker_angular_momentum_feature{index2}(k,:))/(norm(marker_angular_momentum_feature{index1}(k,:))*norm(marker_angular_momentum_feature{index2}(k,:)))+1;
                else
                    temp=NaN;
                end
                weight_matrix_2{k}(index1,index2)=temp;
                weight_matrix_2{k}(index2,index1)=temp;
           end
           if check==0
                if ~isnan(norm(marker_angular_momentum_feature{index1}(k,:)*norm(marker_angular_momentum_feature{index2}(k,:)))) && ~isinf(norm(marker_angular_momentum_feature{index1}(k,:)*norm(marker_angular_momentum_feature{index2}(k,:))))
                    temp=1/5*(dot(marker_angular_momentum_feature{index1}(k,:),marker_angular_momentum_feature{index2}(k,:))/(norm(marker_angular_momentum_feature{index1}(k,:))*norm(marker_angular_momentum_feature{index2}(k,:)))+1);
                else
                    temp=NaN;
                end
                weight_matrix_2{k}(index1,index2)=temp;
                weight_matrix_2{k}(index2,index1)=temp;
           end
       end
   end
   
end

for k=1:size(marker_weighted_feature_vectors{1},1)
    weight_matrix{k}=weight_matrix_1{k}+weight_angular_momentum_feature*weight_matrix_2{k};
end

end