voltage = [21.2, 19.5, 20.1, 18.3, 17.7, 15.0, 21.9, 24.7, 23.1, 20.2, 16.3, 22.8, 18.4, 23.5, 21.1];

% min
minimum = min(voltage);
fprintf("Minimum value is %.2f volts \n", minimum)

% max
maximum = max(voltage);
fprintf("Maximum value is %.2f volts \n", maximum)

% average
avg = mean(voltage);
fprintf("Average value is %.2f volts \n", avg)

% standard deviation
standard_deviation = std(voltage);
fprintf("Standard deviation is %.2f \n", standard_deviation)

% median
median = median(voltage);
fprintf("Median value is %.2f volts \n", median)

% no of values above average
above_avg = find(voltage > avg);
no_above_avg = length(above_avg);
fprintf("Number of values above average is %.2f \n", no_above_avg)

% values above average
values_above_average = voltage(above_avg);
fprintf("Values above average are \n")
disp(values_above_average)

% ploting raw data
figure, plot(voltage)
title("voltages")
xlabel("index")
ylabel("volts")

% histogram plot
figure, histogram(voltage)
title("Volts vs Frequency")
xlabel("volts")
ylabel("frequency")
