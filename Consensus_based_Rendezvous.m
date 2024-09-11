clear
clc
close all

% Initial parameters
N = 10; % Number of agents
T = 50; % Number of temporal iterations
epsilon = 0.5; % Maximum distance to consider 2 neighbouring agents
positions = rand(N, 2); % Initialisation of x and y agents positions
A = zeros(N); % Adjacency matrix initialisation
rho = 0.1; % Update factor rho, where 0 < rho < 1
new_positions = zeros(N,2); % Initialisation of new positions

% Cycle for each time instant
for t = 1:T
    % Determine at each time instant the adjacency matrix where a_ij = 1 if two agents are neighbours
    for i = 1:N
        for j = 1:N
            dist_ij = norm(positions(i,:) - positions(j,:)); % Calculation of Euclidean distance
            if dist_ij <= epsilon
                A(i,j) = 1;
            end
        end
    end
    
    % Iteration on all agents
    for i = 1:N
        neighbors = find(A(i, :)); % Identifies neighbours
        lambda = ones(size(neighbors)); % Unit weights, equal in size to the number of neighbours of agent i
        lambda = lambda / sum(lambda); % Normalisation of weights
        
        % Calculation of consensus position for each agent i
        consensus_position = lambda * positions(neighbors, :);
        
        % Calculation of new updated position
        new_positions(i, :) = positions(i, :) + rho * (consensus_position - positions(i, :));
    end
    
    % Update agent positions
    positions = new_positions;
    
    % Display of updated agent positions
    clf; % Cleaning the figure 
    hold on;
    % Plots the agents at each instant i
    plot(positions(:, 1), positions(:, 2), 'o', 'MarkerFaceColor', 'b');
    % Draws links between neighbouring agents at each instant i
    for i = 1:N 
        for j = find(A(i, :))
        plot([positions(i, 1), positions(j, 1)], [positions(i, 2), positions(j, 2)], 'k');
        end
    end
    axis([0 1 0 1]);
    title(['Evolution of Agent Positions (Time ' num2str(t) ')']);
    xlabel('X');
    ylabel('Y');
    pause(0.1);
end