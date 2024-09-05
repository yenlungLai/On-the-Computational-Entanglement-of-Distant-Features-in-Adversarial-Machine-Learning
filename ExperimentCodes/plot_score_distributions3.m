function plot_score_distributions22(genuine_scores, imposter_scores, genuine_scores2, imposter_scores2, genuine_scores3, imposter_scores3)
bw = 0.03; limx = 1;

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


% Calculate mean and variance for the additional genuine and imposter scores
gen_mean3 = mean(genuine_scores3);
gen_var3 = var(genuine_scores3);
imp_mean3 = mean(imposter_scores3);
imp_var3 = var(imposter_scores3);


% Generate x values for the plot
x = linspace(0, limx, 200);

% Perform kernel density estimation for the original data
[genuine_density, t1] = ksdensity(genuine_scores, x, 'Bandwidth', bw);
[imposter_density, t2] = ksdensity(imposter_scores, x, 'Bandwidth', bw);

% Perform kernel density estimation for the additional data
[genuine_density2, t3] = ksdensity(genuine_scores2, x, 'Bandwidth', bw);
[imposter_density2, t4] = ksdensity(imposter_scores2, x, 'Bandwidth', bw);


% Perform kernel density estimation for the additional data
[genuine_density3, t5] = ksdensity(genuine_scores3, x, 'Bandwidth', bw);
[imposter_density3, t6] = ksdensity(imposter_scores3, x, 'Bandwidth', bw);

% Calculate maximum density across all densities
max_density = max([max(genuine_density), max(imposter_density), max(genuine_density2), max(imposter_density2),max(genuine_density3), max(imposter_density3)]);

% Generate legend strings for the original data
gen_legend_str = sprintf('Intra-class $d_H(\\mathrm{sign} (y),\\mathrm{sign}(y''))^2/m$ (mean=%.5f, var=%.5f)', gen_mean, gen_var);
imp_legend_str = sprintf('Inter-class $d_H(\\mathrm{sign} (y),\\mathrm{sign}(y''))^2/m$ (mean=%.5f, var=%.5f)', imp_mean, imp_var);

% Generate legend strings for the additional data
gen_legend_str2 = sprintf('Intra-class  ${\\arccos (y \\cdot y'')}/{\\pi}$ (mean=%.5f, var=%.5f)', gen_mean2, gen_var2);
imp_legend_str2 = sprintf('Inter-class  ${\\arccos (y \\cdot y'')}/{\\pi}$ (mean=%.5f, var=%.5f)', imp_mean2, imp_var2);
% Generate legend strings for the additional data
gen_legend_str3 = sprintf('Intra-class  $||{y-y''}||^{2}_2/4$ (mean=%.5f, var=%.5f)', gen_mean3, gen_var3);
imp_legend_str3 = sprintf('Inter-class  $||{y-y''}||^{2}_2/4$ (mean=%.5f, var=%.5f)', imp_mean3, imp_var3);


% Plot the distribution curves for the original data with markers
plot(t1, genuine_density, '-s','Color', 			"#D95319", 'DisplayName', gen_legend_str, 'MarkerSize',20, 'MarkerIndices',1:15:length(t1),'MarkerEdgeColor',	"#D95319",'LineWidth', 4.5);
hold on;
plot(t2, imposter_density, '-o', 'Color', "m", 'DisplayName', imp_legend_str, 'MarkerSize',20, 'MarkerIndices',1:15:length(t2), 'MarkerEdgeColor','m','LineWidth', 4.5);

% Plot the distribution curves for the additional data with markers
plot(t3, genuine_density2, '-s', 'Color', 'r', 'DisplayName', gen_legend_str2, 'MarkerSize',20, 'MarkerIndices',1:15:length(t3), 'MarkerEdgeColor','r','LineWidth', 4.5);
plot(t4, imposter_density2, '-o', 'Color', "b", 'DisplayName', imp_legend_str2, 'MarkerSize',20, 'MarkerIndices',1:15:length(t4), 'MarkerEdgeColor','b','LineWidth', 4.5);


% Plot the distribution curves for the additional data with markers
plot(t5, genuine_density3, '-s', 'Color', "#EDB120", 'DisplayName', gen_legend_str3, 'MarkerSize',20, 'MarkerIndices',1:15:length(t5), 'MarkerEdgeColor',"#EDB120",'LineWidth', 4.5);
plot(t6, imposter_density3, '-o', 'Color', "#4DBEEE", 'DisplayName', imp_legend_str3, 'MarkerSize',20, 'MarkerIndices',1:15:length(t6), 'MarkerEdgeColor',"#4DBEEE",'LineWidth', 4.5);

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
legend({gen_legend_str, imp_legend_str, gen_legend_str2, imp_legend_str2,gen_legend_str3, imp_legend_str3}, 'Interpreter', 'latex');
hold off;
end
