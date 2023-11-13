[v, u] = generateOrthogonalVectors(1);



n=5; k=3; nter=200;


figure; % Create a new figure
hold on; % Hold the plot
ii=1;

% Determine the color for the start markers
start_u_color = 'r'; % Red for w
start_v_color = 'b'; % Blue for w'

% Plot starting points
start_u = plot3(u(1), u(2), u(3), 'o', 'MarkerSize', 8, 'MarkerFaceColor', start_u_color, 'MarkerEdgeColor', start_u_color, 'LineWidth', 2, 'DisplayName', '$\hat{c}$  Start'); % Plot u start marker
start_v = plot3(v(1), v(2), v(3), 'o', 'MarkerSize', 8, 'MarkerFaceColor', start_v_color, 'MarkerEdgeColor', start_v_color, 'LineWidth', 2, 'DisplayName', '$\hat{c}''$ Start'); % Plot v start marker

% Create variables to store old values
old_u = u;
old_v = v;



% entanglement take place here
% we apply encoding directly on u and v for each encoding time step
    
while ii < nter
  
    % Encoding for u
    [reduced_codeword,reduced_matrix]=Encoding(u',n,k);
    fu1=reduced_codeword';
    u=fu1;

    % Encoding for v
    fu2=reduced_matrix*(v');
    fu2=fu2';
    v=fu2;

    ii=ii+1;
 

    u = u/norm(u);  % Normalize the vector
    v = v/norm(v);  % Normalize the vector



    % Plot updated vectors
    % Draw lines from old points to new points
    plot3([old_u(1), u(1)], [old_u(2), u(2)], [old_u(3), u(3)], 'Color', start_u_color, 'LineWidth', 1); % Red for u
    plot3([old_v(1), v(1)], [old_v(2), v(2)], [old_v(3), v(3)], 'Color', start_v_color, 'LineWidth', 1); % Blue for v

    % Store current points as old points for the next iteration
    old_u = u;
    old_v = v;
end

grid on; % Turn the grid on
xlabel('X'); % Label X-axis
ylabel('Y'); % Label Y-axis
zlabel('Z'); % Label Z-axis

view(45, 45);
su=sign(u);
sv=sign(v);
sum(su~=sv)/length(su);



% Dummy lines for legend
dummy_u = line([NaN], [NaN], 'Color', 'r', 'LineWidth', 1, 'DisplayName', '$\hat{c}$ Path');
dummy_v = line([NaN], [NaN], 'Color', 'b', 'LineWidth', 1, 'DisplayName', '$\hat{c}''$ Path');

% Plot end points
end_u = plot3(u(1), u(2), u(3), 'ks', 'MarkerSize',15, 'MarkerFaceColor', 'none', 'LineWidth', 2, 'DisplayName', '$\hat{c}$ End'); % Plot v1 end as black square
end_v = plot3(v(1), v(2), v(3), 'kd', 'MarkerSize',15, 'MarkerFaceColor', 'none', 'LineWidth', 2, 'DisplayName', '$\hat{c}''$ End'); % Plot v2 end as black diamond

legend([start_u, start_v, dummy_u, dummy_v, end_u, end_v],'Interpreter', 'latex'); % This will automatically grab the 'DisplayName' properties of your plot objects
hold off; % Release the plot




function [yfil,frmat]=Encoding(x,n,t)
k=length(x);

rmat=randn(n,k);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');
% [sorted_data, sortedindex ]= sort(absy, 'ascend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end




function [targetVec, vecs] = generateVectorsLessThan90Degrees(m)
    % Initializations
    targetVec = randn(1, 3);  % Generate target vector in 3D
    targetVec = targetVec / norm(targetVec);  % Normalize the vector

    vecs = zeros(m, 3);  % Preallocate matrix for efficiency

    for i = 1:m
        % Generate a random angle in radians greater than 90 degrees and less than 180
        angle =rand()*pi/2;
        
        % Create a random rotation axis by crossing the target vector with a random vector
        randomVec = randn(1, 3);
        rotationAxis = cross(targetVec, randomVec);
        rotationAxis = rotationAxis / norm(rotationAxis);  % Normalize the rotation axis
        
        % Generate the rotation matrix using Rodrigues' rotation formula
        K = [0 -rotationAxis(3) rotationAxis(2);
             rotationAxis(3) 0 -rotationAxis(1);
             -rotationAxis(2) rotationAxis(1) 0];
        R = eye(3) + sin(angle)*K + (1 - cos(angle))*(K^2);
        
        % Rotate target vector using the rotation matrix
        rotatedVec = (R * targetVec')';
        
        % Store the rotated vector in the matrix
        vecs(i, :) = rotatedVec;
    end
end


function [targetVec, vecs] = generateVectorsMoreThan90Degrees(m)
    % Initializations
    targetVec = randn(1, 3);  % Generate target vector in 3D
    targetVec = targetVec / norm(targetVec);  % Normalize the vector

    vecs = zeros(m, 3);  % Preallocate matrix for efficiency

    for i = 1:m
        % Generate a random angle in radians greater than 90 degrees and less than 180
        angle = pi/2 + rand()*pi/2;
        
        % Create a random rotation axis by crossing the target vector with a random vector
        randomVec = randn(1, 3);
        rotationAxis = cross(targetVec, randomVec);
        rotationAxis = rotationAxis / norm(rotationAxis);  % Normalize the rotation axis
        
        % Generate the rotation matrix using Rodrigues' rotation formula
        K = [0 -rotationAxis(3) rotationAxis(2);
             rotationAxis(3) 0 -rotationAxis(1);
             -rotationAxis(2) rotationAxis(1) 0];
        R = eye(3) + sin(angle)*K + (1 - cos(angle))*(K^2);
        
        % Rotate target vector using the rotation matrix
        rotatedVec = (R * targetVec')';
        
        % Store the rotated vector in the matrix
        vecs(i, :) = rotatedVec;
    end
end





function [targetVec, vecs] = generateOrthogonalVectors(m)

    targetVec = randn(1, 3);  % Generate target vector

    vecs = zeros(m, 3);  % Preallocate matrix for efficiency

    orthVec = [-targetVec(3), targetVec(2),targetVec(1)];  % Create a vector orthogonal to targetVec
    orthVec = orthVec / norm(orthVec);  % Normalize the vector

    for i = 1:m
        vecs(i, :) = orthVec;  % Store the vector in the matrix
    end


end


