% Parameters
clear all
learning_rate = 1000;  D=1;
iterations = 5;
x0 = 0.11; % Initial point
y0 = 0.1; % Initial point
x = 1*D; % Target point
y = 1*D; % Target point


% Initialize weight matrix W
W = rand(2, 2);

% Pre-allocate trajectory array
trajectory = zeros(iterations, 2);


% Initialize a figure for plotting
figure;
hold on;

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




% Compute and display the final transformed point

% Initialize 1000 new random points and compute L2 norm differences
num_points = 5000;

for ii=1:iterations
    W=Wt{ii};
    disscore=[];
     x0_new1 = randn() * 10; % Random initial point with some spread
     y0_new1 = randn() * 10;
    final_transformed_vector =  [x; y];

    for i = 1:num_points
        % Generate a random new initial point
          x0_new = randn() * 10; % Random initial point with some spread
          y0_new = randn() * 10;

        
        % Transform the new point using the trained weight matrix
        transformed_vector_new = W * [x0_new; y0_new];
    fprintf(' transformed_vector_new: (%.2f, %.2f)\n', transformed_vector_new(1), final_transformed_vector(2));

        % Compute and record the L2 norm difference
        l2norm = norm(transformed_vector_new/norm(transformed_vector_new) - final_transformed_vector/norm(final_transformed_vector))/2;
        
        disscore = [disscore; real(l2norm)];
    end
    %      disscore_d=[disscore_d disscore];
    plotconverge(disscore, colors(ii, :), sprintf('Itaration (epochs) = %d', ii));
end




% Add title, labels, and legend
% title('Angle Distance Scores for Different L Values');
xlabel('$\mathcal{L}(\theta,w^*_L,w''_L)$','Interpreter', 'latex');
ylabel('Frequency');
legend('show');
hold off;

