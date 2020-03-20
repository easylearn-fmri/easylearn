% This script is used to visualize the classification weight using network matrix and circle style.
%% -----------------------------------------------------------------
tvalues_medicated = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\tvalues_medicated.mat');
tvalues_feu = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\tvalues_feu.mat');
mask_medicated = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\mask_medicated1.mat');
mask_feu = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\mask_feu1.mat');
cohen_medicated = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\cohen_medicated1.mat');
cohen_feu = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\cohen_feu1.mat');
average_fc_all = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\average_fc_all.mat');
average_fc_feu = importdata('D:\WorkStation_2018\SZ_classification\Data\Stat_results\average_fc_feu.mat');
load D:\WorkStation_2018\SZ_classification\Data\Stat_results\weights.mat;
load D:\WorkStation_2018\SZ_classification\Data\Stat_results\mycmap.mat;
legends = {'Amyg', 'BG', 'Tha', 'Hipp', 'Limbic', 'Visual', 'SomMot', 'Control', 'Default', 'DorsAttn',  'Sal/VentAttn'};
legned_fontsize = 7;
thred_cohen = 0.5;
if_add_mask = 1;
how_disp = 'all';
if_binary = 0;
which_group = 1;

%  Filter weights
[sort_weight_pooling, id] = sort(abs(weight_pooling(:)));
weight_pooling(id(1:floor(length(id) * perc_filter))) = 0;

[sort_weight_unmedicated, id] = sort(abs(weight_unmedicated(:)));
weight_unmedicated(id(1:floor(length(id) * perc_filter))) = 0;

% Plot
net_index_path = 'D:\My_Codes\lc_rsfmri_tools_python\Workstation\SZ_classification\ML\netIndex.mat';
load D:\My_Codes\lc_rsfmri_tools_python\Workstation\SZ_classification\ML\colormap_weight.mat;
load D:\My_Codes\easylearn\Workstation\SZ_classification\Visulization\mycmap_weight

% figure;
h = subplot(2,2,1);
lc_netplot(weight_pooling, if_add_mask, weight_pooling ~= 0, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap_weight);
caxis([-1.5 5]);
axis square
% title('All datasets', 'fontsize', 10, 'fontweight','bold');
% colorbar('Location','westoutside');

h = subplot(2,2,2);
lc_netplot(weight_unmedicated, if_add_mask, weight_unmedicated ~= 0, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap_weight );
caxis([-1.5 5]);
axis square
% title('First episode unmedicated subgroup', 'fontsize', 10, 'fontweight','bold');


% Differences
h = subplot(2,2,3);
lc_netplot(cohen_medicated, if_add_mask, abs(cohen_medicated)>=thred_cohen, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap)
caxis([-1 1]);
axis square

h = subplot(2,2,4);
lc_netplot(cohen_feu, if_add_mask, abs(cohen_feu)>=thred_cohen, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap)
caxis([-1 1]);
axis square

% Distance, correlation and visulization
dis_weight = pdist2(zscore(weight_pooling(:))', zscore(weight_unmedicated(:))', 'euclidean');
dis_cohen = pdist2(zscore(cohen_medicated(:))', zscore(cohen_feu(:)'), 'euclidean');

% Save
% print('D:\WorkStation_2018\SZ_classification\Data\Stat_results\corr_scatter_weight.tif', '-dtiff','-r1200' )
% set(gcf,'PaperType','a3');
% saveas(gcf, 'D:\WorkStation_2018\SZ_classification\Data\Stat_results\diff2_all_cb.pdf');

% Tvalues
figure
if_add_mask = 0;
cohen_tresh = 0.2;
h = subplot(1,2,1);
lc_netplot(tvalues_medicated, if_add_mask, abs(cohen_medicated) > cohen_tresh, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap)
caxis([-6 6]);
axis square

h = subplot(1,2,2);
lc_netplot(tvalues_feu, if_add_mask, abs(cohen_feu) > cohen_tresh, how_disp, 0, which_group, net_index_path, 1, legends, legned_fontsize);
colormap(h, mycmap)
caxis([-6 6]);
axis square
