patch='/patches7';
datasets{1}.data = load_patches('~/data/desc/caltech10/all_32_3_extra_hybrid_mean/', patch);
datasets{1}.name = 'caltech';
datasets{2}.data = load_patches('~/data/desc/office/amazon10/', patch);
datasets{2}.name = 'amazon';
datasets{3}.data = load_patches('~/data/desc/office/dslr10/', patch);
datasets{3}.name = 'dslr';
datasets{4}.data = load_patches('~/data/desc/office/webcam10/', patch);
datasets{4}.name = 'webcam';
elements=1:numel(datasets);
DIMS=128;
for idx=elements
	disp 'Start cycle'
	X = cell_to_matrix(datasets{idx}.data);
	name = datasets{idx}.name;
	to_apply = elements([1:idx-1 idx+1:end]);
	[xmean, xstd, coeff, latent ] = getPCAMatrix(X);
	variance_kept = sum(latent(1:DIMS))/sum(latent)
	disp 'Applying PCA to targets'
	for dest=to_apply
		disp(datasets{dest}.name)
		reduced_data = apply_pca(datasets{dest}.data, coeff, DIMS, xmean, xstd );
		save(strcat(name,'_to_',datasets{dest}.name,'__std_lvl7'), 'reduced_data');
	end
	save(strcat('variance',DIMS,'_std_lvl7'), 'variance_kept');
end