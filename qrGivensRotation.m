close all;

A = randi(20,20)

[Q,R] = qrGivens(A)

createQRVideo(A)

function createQRVideo(A)
    % Compute the QR decomposition of A using the Givens rotation method
    % [Q,R] = qrGivens(A);
    
    % Set up the video writer object
    writerObj = VideoWriter('QR_Givens.mp4');
    open(writerObj);
    
    [m,n] = size(A);
    Q = eye(m);
    R = A;
    G = eye(m) 
    secsPerImage = 5;
    set(gca, 'XTick', 1:(n+1), 'YTick', 1:(m+1), ...  % Change some axes properties
         'XLim', [1 n+1], 'YLim', [1 m+1], ...
         'GridLineStyle', '-', 'XGrid', 'on', 'YGrid', 'on');
    colormap('parula');
    % Loop through each frame of the video
    for iCol = 1:n
        for j = m:-1:(iCol + 1)
            % Create the image for this frame
            G = eye(m);
            [c, s] = givensRotation(R(j - 1, iCol),R(j,iCol))
            G([j-1, j],[j-1, j]) = [c -s; s c]
            subplot(1,2,1)
            imagesc((1:n)+0.5, (1:m)+0.5,(round(abs(G),2)>0));
            
            subplot(1,2,2)
            imagesc((1:n)+0.5, (1:m)+0.5,(round(abs(R),2)>0));
             
            % Capture the frame and write it to the video file
            frame = getframe();
            for iFrame = 1:secsPerImage
                writeVideo(writerObj, frame);
            end
            
            % Update the matrices Q and R
            R = G*R
            Q = Q*G'
            
        end 
        subplot(1,2,1)
        imagesc((1:n)+0.5, (1:m)+0.5,(round(abs(G),2)>0));
        subplot(1,2,2)
        imagesc((1:n)+0.5, (1:m)+0.5,(round(abs(R),2)>0));
    end
     set(gca, 'XTick', 1:(n+1), 'YTick', 1:(m+1), ...  % Change some axes properties
         'XLim', [1 n+1], 'YLim', [1 m+1], ...
         'GridLineStyle', '-', 'XGrid', 'on', 'YGrid', 'on');
     colormap('parula');
    % Close the video writer object
    close(writerObj);
end
 
%% qrGivensRotations
% Functions calculate
% Algorithm 5.2.2 , p. 227, Golub & Van Loan, Matrix Computations, 3rd edition
function [Q,R] = qrGivens(A)
    [m,n] = size(A);
    Q = eye(m);
    R = A;
    G = eye(m);
    
    for iCol = 1:n
        for j = m:-1:(iCol + 1)
            G = eye(m)
            [c, s] = givensRotation(R(j - 1, iCol),R(j,iCol))
            G([j-1, j],[j-1, j]) = [c -s; s c]
            R = G*R
            Q = Q*G'
        end 
    end
end

