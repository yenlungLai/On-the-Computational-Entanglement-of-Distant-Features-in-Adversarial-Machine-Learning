function plotconverge(genuine_scores, color, legend_str)
    % Set bandwidth for kernel density estimation and x-axis limits
    bw = 0.03;
    limx = 1;

    % Calculate mean and variance for the genuine scores
    gen_mean = mean(genuine_scores);
    gen_var = var(genuine_scores);

    % Generate x values for the plot
    x = linspace(0, limx, 200);

    % Perform kernel density estimation for the genuine scores
    [genuine_density, t1] = ksdensity(genuine_scores, x, 'Bandwidth', bw);

    % Calculate maximum density to dynamically set the y-axis limit
    max_density = max(genuine_density);

    % Plot the distribution curve for the genuine scores
    plot(t1, genuine_density, '-','Color', color, 'DisplayName', legend_str, ...
         'LineWidth', 3);

    % Set x and y limits dynamically based on the maximum density
    xlim([0 limx]);
    ylim([0 max_density + 5]);

    % Add title, labels, and legend
    xlabel('Score', 'Interpreter', 'latex');
    ylabel('Density');
    legend('show', 'Interpreter', 'latex');

    % Finalize the plot
    hold on;
end
