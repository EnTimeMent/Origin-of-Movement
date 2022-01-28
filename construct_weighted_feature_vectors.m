function [marker_weighted_feature_vectors,angular_momentum_feature]=construct_weighted_feature_vectors(weights,marker_speed,marker_tangential_acceleration,marker_energy,marker_angular_momentum)
for k=1:size(marker_speed,2)
    marker_weighted_feature_vectors{k}=[weights(1)*marker_speed{k}, weights(2)*marker_tangential_acceleration{k}, weights(3)*marker_energy{k}];
    angular_momentum_feature{k}=marker_angular_momentum{k};
end
end