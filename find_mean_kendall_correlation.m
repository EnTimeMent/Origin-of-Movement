function mean_kendall_correlation=find_mean_kendall_correlation(Shapley_values1,Shapley_values2)

for k=1:size(Shapley_values1)
    instant_kendall_correlation(k)=corr(Shapley_values1(k,:)',Shapley_values2(k,:)','Type','Kendall');
end
mean_kendall_correlation=nanmean(instant_kendall_correlation);

end

