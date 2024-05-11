f = @(x) x.^3 + 27;  

figure;
x_vals = linspace(-15, 5, 100);
y_vals = f(x_vals);
plot(x_vals, y_vals);
grid on;
xlabel('x');
ylabel('f(x)');
title('Function Graph');


upper_value = input('Enter upper bound value: ');

lower_value = input('Enter lower bound value: ');

error = input('Enter minimum error: ');

iter = input('Enter number of iterations: ');


% False-Position method
[value_list, error_list] = falsePosition(f, upper_value, lower_value, error, iter);

fprintf('Roots: ');
disp(value_list);
fprintf('Error History(%%): ');
disp(error_list);


function [value_list, error_list] = falsePosition(f, upper_value, lower_value, error, iter)
    value_list = [];
    error_list = [];
    lower_value_list = [];
    upper_value_list = [];
    lower_value_list(1) = lower_value;
    upper_value_list(1) = upper_value;
    
    for i = 1:iter
        xr = upper_value - (f(upper_value) * (lower_value - upper_value)) / (f(lower_value) - f(upper_value));
        value_list(i) = xr;
        
        if f(xr) * f(upper_value) < 0
            lower_value = xr;
            lower_value_list(i+1) = xr;
            error_list(i) = abs((xr - lower_value_list(i)) / xr)*100;
        else
            upper_value = xr;
            upper_value_list(i+1) = xr;
            error_list(i) = abs((xr - upper_value_list(i)) / xr)*100;
        end
        
    end

    hold on;
    if error_list(end) <= error
        plot(value_list(end), f(value_list(end)), 'rx'); 
    else
        disp('You cannot reach minimum error with this iteration number.');
        plot(value_list(end), f(value_list(end)), 'rx');
    end
    title('Root Graph');
    

    figure;
    for i = 1:iter
            plot(error_list(i), i, 'ro');
            grid on;
            xlabel('Error');
            ylabel('Iteration');
            hold on;
    end
end
