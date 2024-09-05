% Parameters
vectorLength = 256; % Length of the vector
n = 16384; % Example value, replace with your actual value
k = 256; % Example value, replace with your actual value

% % Initialize a figure for plotting
% figure;
% hold on;

colors = [
    [0 0.4470 0.7410]; % Dark Blue
    [0.8500 0.3250 0.0980]; % Green
    [0.9290 0.6940 0.1250]; % Red
    [0.4940 0.1840 0.5560]; % Cyan
    [0.4660 0.6740 0.1880]; % Orange
    [0.3010 0.7450 0.9330]; % Purple
    [0.6350 0.0780 0.1840]  % Light Green
    ];
% Loop through each L value
L_values = 15;
for idx = 1:length(L_values)
    L = L_values(idx);
    % Initialize v1 from Gaussian distribution
    v1 = randn(vectorLength, 1)'; % v1 from Gaussian distribution

    % Step 2: Initial transformation setup
    H = eye(vectorLength); % Identity matrix of size 'vectorLength'
    invec = v1;

    % Step 3: Perform the iterative transformation
    for i = 1:L
        [cstar, reducedMat] = Encoding(invec', n, k); % Call Encoding function
        invec = cstar';
        H = reducedMat * H;
        Hmatt{i}=H;
        v1_transformedd{i} = cstar;
    end


    % Initialize array to store distance scores


    disscore_d=[];
    for ii = 1:5000
        % v2 from Gaussian distribution
        v2 = randn(vectorLength, 1)';

        disscore=[];
        for jj= 1:L
            H= Hmatt{jj}; v1_transformed=v1_transformedd{jj} ;



            % Step 4: Normalize cstar and the transformed v2
            v2_transformed = H * (v2') ;
            % Step 5: Calculate the angle distance
            angledis = acos(dot(v2_transformed, v1_transformed) / (norm(v2_transformed) * norm(v1_transformed))) / pi;

            % Append the distance score
            disscore = [disscore; angledis];
        end
        disscore_d=[disscore_d disscore];
    end

    % Plot the results for the current L value
    %     plotconverge(disscore, colors(idx, :), sprintf('$L$ = %d', L));
end

% Add title, labels, and legend
% title('Angle Distance Scores for Different L Values');
% xlabel('$\mathcal{L}(\theta,w_L,w''_L)$','Interpreter', 'latex');
% ylabel('Frequency');
% legend('show');
% hold off;

data=disscore_d;

% Determine the size of the data matrix
[r, c] = size(data); % r is the number of rows, c is the number of columns
% Set x-axis limit from 1 to L


% Create a new figure
figure;
hold on; % Allow multiple plots on the same figure

% Plot each column with different colors or markers
for i = 1:c
    plot(1:r, data(:, i), '-'); % Plot each column without a legend entry
end
xlim([1, L]);
ylabel('$\mathcal{L}(\theta,w_L,w''_L)$','Interpreter', 'latex');
xlabel('$L$','Interpreter', 'latex');

hold off; % Release the hold for the plot






















% Encoding function
function [yfil, frmat] = Encoding(x, n, t)
k = length(x);
rmat = randn(n, k);
y = rmat * x;
absy = abs(y);
[~, sortedindex] = sort(absy, 'descend');
topindex = sortedindex(1:t);
frmat = rmat(topindex, :);
yfil = y(topindex);
end
