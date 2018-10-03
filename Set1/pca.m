%(a)
X=importdata(‘wine.data’); %import data
%(b)
X_mean_nor = X-mean(X); %mean normalisation
X_cov = cov(X_mean_nor); %covariance matrix
[X_evector, X_evalue] = eig(X_cov); %eigenvector and eigenvalue
X_evalue1=reshape(X_evalue,1,169);
[X_evalue_sort,ind]=sort(X_evalue1);
max_value1=X_evalue_sort(169); %max eigenvalue
max_value2=X_evalue_sort(168); %2nd max eigenvalue
max_vector1 = null(X_cov - max_value1 * eye(length(X_cov))); %corresponding eigenvector
max_vector2 = null(X_cov - max_value2 * eye(length(X_cov)));
%(c)
A = [max_vector2, max_vector1]; %combine corresponding eigenvectors of two of the max eigenvalues
%(d)
final_X= X_mean_nor * A; %get the final answer;

