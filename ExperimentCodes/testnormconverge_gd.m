% Parameters
clear all
learning_rate = 0.01;  D=10000;
iterations = 5;
x0 = 0.1; % Initial point
y0 = 0.1; % Initial point
x = 1*D; % Target point
y = 1*D; % Target point

% Initialize weight matrix W
W = rand(2, 2);

% Pre-allocate trajectory array
trajectory = zeros(iterations, 2);



colors = [
    [0 0.4470 0.7410]; % Dark Blue
    [0.8500 0.3250 0.0980]; % Green
    [0.9290 0.6940 0.1250]; % Red
    [0.4940 0.1840 0.5560]; % Cyan
    [0.4660 0.6740 0.1880]; % Orange
    [0.3010 0.7450 0.9330]; % Purple
    [0.6350 0.0780 0.1840]  % Light Green
    ];






% Gradient Descent
for iter = 1:iterations
    % Compute the transformation
    transformed_vector = W * [x0; y0];

    % Compute the gradient of the loss function
    % Loss function: || W * [x0; y0] - [x; y] ||^2
    error_vector = transformed_vector - [x; y];

    % Compute the gradient of the loss with respect to W
    gradient = 2 * (error_vector * [x0; y0]'); % (2x2) * (2x1) gives (2x2)

    % Update the weight matrix W
    W = W - learning_rate * gradient;

    Wt{iter}=W;
end

% Display the final weight matrix
disp('Final weight matrix W:');
disp(W);





% Initialize 1000 new random points and compute L2 norm differences
num_points = 5000;
disscore_d=[];

for i = 1:num_points
    % Generate a random new initial point
    x0_new = randn() * 10; % Random initial point with some spread
    y0_new = randn() * 10;
      x0_new1 = randn() * 10; % Random initial point with some spread
     y0_new1 = randn() * 10;
    final_transformed_vector =  [x; y];
    fprintf('Final transformed point: (%.2f, %.2f)\n', final_transformed_vector(1), final_transformed_vector(2));

    disscore = [];
    %     acos(dot([x0_new; y0_new], final_transformed_vector) / (norm([x0_new; y0_new]) * norm(final_transformed_vector))) / pi;

    for ii=1:iterations
        W=Wt{ii};
        % Compute and display the final transformed point
        final_transformed_vector = W * [x0_new1; y0_new1];
        fprintf('Final transformed point: (%.2f, %.2f)\n', final_transformed_vector(1), final_transformed_vector(2));

        % Transform the new point using the trained weight matrix
        transformed_vector_new = W * [x0_new; y0_new];

        % Compute and record the L2 norm difference
        l2norm = norm(transformed_vector_new/norm(transformed_vector_new) - final_transformed_vector/norm(final_transformed_vector))/2;
        disscore = [disscore; real(l2norm)];
    end
    disscore_d=[disscore_d disscore];
    %       plotconverge(disscore, colors(idx, :), sprintf('$L$ = %d', L));
end



% Determine the size of the data matrix
[r, c] = size(disscore_d); % r is the number of rows, c is the number of columns
% Set x-axis limit from 1 to L


% Create a new figure
figure;
hold on; % Allow multiple plots on the same figure

% Plot each column with different colors or markers
for i = 1:c
    plot(1:r, disscore_d(:, i), '-'); % Plot each column without a legend entry
end
% Set custom x-ticks from 0 to 3, corresponding to data points 1 to 4

% xticks(1:iterations);
% xticklabels({'0', '1', '2', '3','4','5','6','7','8','9','10','11','12','13','14','15'});
ylim([0, 1]);
xlim([1, iterations]);
ylabel('$\mathcal{L}(\theta,w^*_L,w''_L)$','Interpreter', 'latex');
xlabel('Iteration (epoch)','Interpreter', 'latex');

hold off; % Release the hold for the plot
