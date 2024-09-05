clear all
n = 100;
L = 12;
cc = 100;
N = 1;

for c = [cc]
    inp_vecs = cell(1, N);  % Cell array to store input vectors
    vecs = cell(1, N);      % Cell array to store output vectors

    % Generating random input vectors
    RandomfieldM = eye(length(inp_vecs{1}));  % Initialize RandomfieldM
    for iii = 1:N
        vecsii = []; vecsii2 = [];
        inp_vecs = generate_random_vector(2, 'normal', 0, 1)';
        inp_vecs2 = generate_random_vector(2, 'normal', 0, 1)';
        ii = 1; inI=inp_vecs(:);
        RandomfieldM=eye(length(inI));
        while ii <= L
            [yi, frmat] = Encoding_mat(inp_vecs, n, length(inp_vecs));
            inp_vecs = yi;
            RandomfieldM=frmat*RandomfieldM;

            yi = [ii * c; yi]; % Apply scaling
            yi = yi / norm(yi); % Normalize
            vecsii = [vecsii; (yi')]; % Store the output vectors

            yi2=RandomfieldM*inp_vecs2;
            yi2 = [ii * c; yi2]; % Apply scaling
            yi2 = yi2 / norm(yi2); % Normalize
            vecsii2 = [vecsii2; (yi2')]; % Store the output vectors
            ii = ii + 1;

            vecs{iii} = vecsii; vecs{iii+1} = vecsii2;


            % Plotting the trajectories
            colors = lines(2);  % Get N distinct colors for plotting
            figure()

            for i = 1: 2
                % Plotting the trajectory for each vector
                plot3(vecs{i}(:, 2), vecs{i}(:, 3), vecs{i}(:, 1),'--','linewidth', 2, 'color', colors(i, :));
                hold on;
                % Plotting the start and end points
                plot3(vecs{i}(1, 2), vecs{i}(1, 3), vecs{i}(1, 1), 'o', 'MarkerSize', 15, 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(i, :)); % Start point
                plot3(vecs{i}(end, 2), vecs{i}(end, 3), vecs{i}(end, 1), 's', 'MarkerSize', 15, 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(i, :)); % End point

                if size(vecsii,1)>1
                    % Plotting arrows along the trajectory
                    quiver3(vecs{i}(1:end-1, 2), vecs{i}(1:end-1, 3), vecs{i}(1:end-1, 1), ...
                        diff(vecs{i}(:, 2)), diff(vecs{i}(:, 3)), diff(vecs{i}(:, 1)), ...
                        'Color', colors(i, :), 'MaxHeadSize', 0.3, 'LineWidth', 1.5);

                end
            end
            grid on
            % %
%             xlabel('$\frac{\hat{i}_L}{\sqrt{(Lc)^{2}+\hat{i}^2_L+\hat{j}^2_L}}$', 'Interpreter', 'latex');
%             ylabel('$\frac{\hat{j}_L}{\sqrt{(Lc)^{2}+\hat{i}^2_L+\hat{j}^2_L}}$', 'Interpreter', 'latex');
%             zlabel('$\frac{Lc}{\sqrt{(Lc)^{2}+\hat{i}^2_L+\hat{j}^2_L}}$', 'Interpreter', 'latex');

            % Constructing legend labels
            legend_labels = cell(1, 2 * N);
            for i = 1:N
                legend_labels{(i - 1) * 2 + 1} = ['$x^{(', num2str(i), ')}_{0}$'];
                legend_labels{(i - 1) * 2 + 2} = ['$x^{(', num2str(i), ')}_{L}$'];
            end


            finp1=vecsii(size(vecsii,1),:);
            finp2=vecsii2(size(vecsii2,1),:);



% Constructing legend labels for final positions
legend_labels = cell(1, 2);
legend_labels{1} = sprintf('$\\frac{{w}_{L}}{\\|{w}_{L}\\|}$: (%.5f, %.5f, %.5f)', finp1(1), finp1(2), finp1(3));
legend_labels{2} = sprintf('$\\frac{{w}''_{L}}{\\|{w}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
legend_labels{3} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
legend_labels{4} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
legend_labels{5} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
legend_labels{6} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3)); legend_labels{7} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
% legend_labels{8} = sprintf('$\\frac{{x}''_{L}}{\\|{x}''_{L}\\|}$: (%.5f, %.5f, %.5f)', finp2(1), finp2(2), finp2(3));
% 
% 



legend(legend_labels, 'Location', 'best', 'Interpreter', 'latex');
            zlim([0,1]);
            xlim([-1,1]);
            ylim([-1,1]);

        end

    end

end






function [yfil,frmat]=Encoding_mat(x,n,t)
k=size(x,1);

rmat=randn(n,k);
% rmat=orth(rmat);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end




function [RandomfieldM,yfil] =main_alg(Ib,n,L)

xpos=[];  % bob first generate RandomfieldM= WL WL-1 ... LW1
ii=1; inI=Ib(:);
RandomfieldM=eye(length(inI));
while ii<=L
    [yfil,frmat]=Encoding_mat(inI,n,length(inI));

    %     yfil=yfil/norm(yfil);
    inI=yfil;
    RandomfieldM=frmat*RandomfieldM;
    ii=ii+1;
end
end








function random_vector = generate_random_vector(k, distribution_name, varargin)
% Generate random vector of dimension k from a specified distribution

% Check if distribution_name is valid
valid_distributions = {'normal', 'uniform', 'exponential', 'poisson', 'lognormal'};
if ~ismember(distribution_name, valid_distributions)
    error('Invalid distribution name. Choose from: normal, uniform, exponential, poisson, lognormal');
end

% Generate random vector
switch distribution_name
    case 'normal'
        mu = varargin{1}; % Mean
        sigma = varargin{2}; % Standard deviation
        random_vector = normrnd(mu, sigma, [1, k]);
    case 'uniform'
        lower_bound = varargin{1}; % Lower bound
        upper_bound = varargin{2}; % Upper bound
        random_vector = unifrnd(lower_bound, upper_bound, [1, k]);
    case 'exponential'
        lambda = varargin{1}; % Rate parameter
        random_vector = exprnd(lambda, [1, k]);
    case 'poisson'
        lambda = varargin{1}; % Mean rate
        random_vector = poissrnd(lambda, [1, k]);
    case 'lognormal'
        mu = varargin{1}; % Mean of the underlying normal distribution
        sigma = varargin{2}; % Standard deviation of the underlying normal distribution
        random_vector = lognrnd(mu, sigma, [1, k]);
end
end






function distance = euclidean_distance(v1, v2)
% Check if the vectors have the same dimensionality
assert(length(v1) == length(v2), 'Vectors must have the same dimensionality');

% Compute the squared differences of corresponding elements
squared_diff = (v1 - v2).^2;

% Compute the sum of squared differences
sum_squared_diff = sum(squared_diff);

% Compute the square root of the sum of squared differences
distance = sqrt(sum_squared_diff);
end




% Function to compute angles between consecutive intervals
function angles = computeAngles(vec)
angles = zeros(size(vec, 1) - 1, 1); % Initialize array to store angles

for i = 1:size(vec, 1) - 1
    % Compute dot product between consecutive vectors
    dot_product = dot(vec(i, :), vec(i + 1, :));

    % Compute magnitudes of consecutive vectors
    magnitude1 = norm(vec(i, :));
    magnitude2 = norm(vec(i + 1, :));

    % Compute angle (in radians) between consecutive vectors
    angles(i) = acos(dot_product / (magnitude1 * magnitude2));
end
end



function y = relu(x)
    y = max(0, x);
end


function y = leaky_relu(x, alpha)
    y = max(alpha * x, x);
end




function y = tanh(x)
    y = (exp(x) - exp(-x)) ./ (exp(x) + exp(-x));
end


function y = softmax(x)
    exps = exp(x);
    y = exps ./ sum(exps);
end
