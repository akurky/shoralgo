function [s] = ShorAlgorithmFast( m, r )

% starting qith m = 119, r = 5 (because why not?)
% prime factors of 119 is 7*17 (for later reference)

    % 21-qubit matrix (2^13 = 8192, 2^8 = 256)
    q = zeros(2^13, 2^8);
    
    for a = 1: 2^13
        q(a,1) = 1/sqrt(2^13);
    end
    
    for a = 1: 2^13
        b = expmod(r,a,m);
        if b >= 1 && b <= 2^8
            q(a,1) = 0;
            q(a,b) = 1/sqrt(2^13);
        end
    end
    
    % Apply the Fast Fourier Transform
    % Note: Matlab's fft function computes the FFT of each column
    % However, this represents the first tensor of our (13x8)-qubit
    % Therefore, we need to transpose the original 21-qubit, then
    % apply the fft, and then take the transpose back
    
    %Q = (fft(q'))';
    qnorm = q/norm(q);        
    meas_prob = rand();
    
    
    for k = 1:1e3
        probnorm2 = sum(abs(qnorm).^2);
        % Collapse second tensor factor (8-qubit) first
        for n = 1 : 2^8
            if (meas_prob > probnorm2(n))
                meas_prob = meas_prob - probnorm2(n);
                if(n == 2^8)
                    u = n;
                    break
                end
            else 
                u = n;
                break;
            end
        end
        
        Q13 = (fft(q(:,u)'))';
        probnorm2 = (Q13/norm(Q13)).^2;
        % Collapse 13-qubit first
        meas_prob = rand();
        for n = 1 : 2^13
            if (meas_prob > probnorm2(n))
                meas_prob = meas_prob - probnorm2(n);
                if(n == 2^13)
                    c = n-1;
                    break
                end
            else 
                c = n-1;
                break;
            end
        end

        dist = 1;
        for z = round(m-3*sqrt(m)):round(m+1-2*sqrt(m))
            close_int = z*c/(2^13);
            dist_z = abs(close_int-round(close_int));
            if (dist_z<dist)
                dist = dist_z;
                s(k) = z;
            end
        end
    end    
    
    
end

