% first, get the data fixed by PCA
X=importdata('wine.data'); %import data
X_mean_nor = X-mean(X); %mean normalisation
X_cov = cov(X_mean_nor); %covariance matrix
[X_evector, X_evalue] = eig(X_cov); %eigenvector and eigenvalue
X_evalue1=reshape(X_evalue,1,169);
[X_evalue_sort,ind]=sort(X_evalue1);
max_value1=X_evalue_sort(169); %max eigenvalue
max_value2=X_evalue_sort(168); %2nd max eigenvalue
max_vector1 = null(X_cov - max_value1 * eye(length(X_cov))); %corresponding eigenvector
max_vector2 = null(X_cov - max_value2 * eye(length(X_cov)));
A = [max_vector2, max_vector1]; %combine corresponding eigenvectors of two of the max eigenvalues
final_X= X_mean_nor * A; %get the final answer;

% then call the Kmeans algorithm
[center, km_final_X]=kmeans(final_X,3) ; % km_final_X means final_X plus clustering

% draw the figure
figure
hold on % to make sure the figure contains all the points
for i=1:178
    if km_final_X(i,3)==1 % 1ts kind of points
        plot(km_final_X(i,1),km_final_X(i,2),'ro');
    elseif km_final_X(i,3)==2 % 2ndkind of points
        plot(km_final_X(i,1),km_final_X(i,2),'g+')
    else %3rd kind of points
        plot(km_final_X(i,1),km_final_X(i,2),'kd');
    end
end
grid on