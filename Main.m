clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the first image
%X = double(imread('barbara_contaminated.png'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the second image
X = double(imread('cameraman_contaminated.png'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Origin = X; % represent the original picture
load Omega  % I1(Omega), I2(Omega) are not contaminated

% omega complement, 
% I1(OmegaComplement), I2(OmegaComplement) are contaminated
OmegaComplement = setdiff([1:256^2],Omega); 

% show the original picture
figure;
imshow(Origin,[]);

% max iteration number 
maxIterations = 256;
% initialize iteration number to 0
iteration = 1;
% relative error (initialized to infinity to start the while loop)
relativeError = inf;
% set tolenrance to 10^(-8)
tol = 1e-8;

% initial value
r = 0.75; 
Q = swt2(X,1,1);
lambda = ones(256,256);
mu= ones(256,256,9);
diff = zeros(maxIterations,1); % use to store the history difference to plot

while relativeError > tol
    oldX = X;
    oldNorm = customNorm(Q);
    
    %%% update X 
    % tempX is the new temperory image we get, and since we only need to
    % change the part which is contaminated
    % (the restraint is R_omega(X) = R_omega(f)) where f is the original image
    % so we appiled the equation in the second line below
    tempX = (iswt2((r*Q-mu),1,1))/(r);
    X(OmegaComplement) = tempX(OmegaComplement);
    
    %%% update Q
    Q = updateQ(swt2(X,1,1)+1/(r)*mu, r);
    
    %%% update lambda
    lambda = lambda + X- oldX;
    
    %%% update mu
    mu = mu + swt2(X,1,1) - Q;
    
    % update error
    newNorm = customNorm(Q);
    relativeError = abs( (newNorm-oldNorm)/max(1,oldNorm));
    diff(iteration) = relativeError;
    
    % reach the maximum iterations, then break the loop
    if iteration == maxIterations
        break
    end
    iteration = iteration + 1;
end

% plot the convergence of relative error
iterations = linspace(1, iteration, iteration);
diffs = diff(1:iteration);
figure;
plot( iterations', diffs, 'r-');
title('Relative Error convergence')
xlabel('iteration'); ylabel('relative error');

% show the final result image
figure;
imshow(X,[]);
