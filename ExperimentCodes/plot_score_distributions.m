function plot_score_distributions22(genuine_scores, imposter_scores, genuine_scores2, imposter_scores2)
bw = 0.15; limx = 4;

% Calculate mean and variance for the original genuine and imposter scores
gen_mean = mean(genuine_scores);
gen_var = var(genuine_scores);
imp_mean = mean(imposter_scores);
imp_var = var(imposter_scores);

% Calculate mean and variance for the additional genuine and imposter scores
gen_mean2 = mean(genuine_scores2);
gen_var2 = var(genuine_scores2);
imp_mean2 = mean(imposter_scores2);
imp_var2 = var(imposter_scores2);

% Generate x values for the plot
x = linspace(0, limx, 200);

% Perform kernel density estimation for the original data
[genuine_density, t1] = ksdensity(genuine_scores, x, 'Bandwidth', bw);
[imposter_density, t2] = ksdensity(imposter_scores, x, 'Bandwidth', bw);

% Perform kernel density estimation for the additional data
[genuine_density2, t3] = ksdensity(genuine_scores2, x, 'Bandwidth', bw);
[imposter_density2, t4] = ksdensity(imposter_scores2, x, 'Bandwidth', bw);

% Calculate maximum density across all densities
max_density = max([max(genuine_density), max(imposter_density), max(genuine_density2), max(imposter_density2)]);

% Generate legend strings for the original data
gen_legend_str = sprintf('Intra-class $d(\\hat{c}'',-\\hat{c})^2$ (mean=%.5f, var=%.5f)', gen_mean, gen_var);
imp_legend_str = sprintf('Inter-class $d(\\hat{c}'',\\hat{c})^2$ (mean=%.5f, var=%.5f)', imp_mean, imp_var);

% Generate legend strings for the additional data
gen_legend_str2 = sprintf('Intra-class  $d(\\hat{c}'',-\\hat{c})^2$ (mean=%.5f, var=%.5f)', gen_mean2, gen_var2);
imp_legend_str2 = sprintf('Inter-class  $d(\\hat{c}'',\\hat{c})^2$ (mean=%.5f, var=%.5f)', imp_mean2, imp_var2);

% Plot the distribution curves for the original data with markers
plot(t1, genuine_density, '-s','Color', 		[0.1 0.8 0.1], 'DisplayName', gen_legend_str, 'MarkerSize',25, 'MarkerIndices',1:15:length(t3),'MarkerEdgeColor','k','MarkerFaceColor',[0.1 0.8 0.1],'LineWidth', 5);
hold on;
plot(t2, imposter_density, '-o', 'Color', "m", 'DisplayName', imp_legend_str, 'MarkerSize',25, 'MarkerIndices',1:15:length(t4), 'MarkerEdgeColor','k','MarkerFaceColor','m','LineWidth', 5);

% Plot the distribution curves for the additional data with markers
plot(t3, genuine_density2, '-s', 'Color', 'r', 'DisplayName', gen_legend_str2, 'MarkerSize',25, 'MarkerIndices',1:15:length(t3), 'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth', 5);
plot(t4, imposter_density2, '-o', 'Color', "b", 'DisplayName', imp_legend_str2, 'MarkerSize',25, 'MarkerIndices',1:15:length(t4), 'MarkerEdgeColor','k','MarkerFaceColor','b','LineWidth', 5);

% Add title and labels
xlabel('Score', 'Interpreter', 'latex');
ylabel('Density');
% 
% %     % Generate legend strings for the original data
% gen_legend_str = sprintf('Intra-class $d_H(\\hat{c}_t,\\hat{c}''_t)/k$ (mean=%.5f, var=%.5f)', gen_mean, gen_var);
% imp_legend_str = sprintf('Inter-class $d_H(\\hat{c}_t,\\hat{c}''_t)/k$ (mean=%.5f, var=%.5f)', imp_mean, imp_var);
% 
% % %     % Generate legend strings for the additional data
% gen_legend_str2 = sprintf('Intra-class  $\\arccos(\\hat{c}_t\\cdot\\hat{c}''_t)/\\pi$ (mean=%.5f, var=%.5f)', gen_mean2, gen_var2);
% imp_legend_str2 = sprintf('Inter-class  $\\arccos(\\hat{c}_t\\cdot\\hat{c}''_t)/\\pi$ (mean=%.5f, var=%.5f)', imp_mean2, imp_var2);
% 


% Set x and y limits dynamically based on the maximum density
xlim([0 limx]);
ylim([0 max_density + 1]);

% Show the legend and plot
legend({gen_legend_str, imp_legend_str, gen_legend_str2, imp_legend_str2}, 'Interpreter', 'latex');
hold off;
end
