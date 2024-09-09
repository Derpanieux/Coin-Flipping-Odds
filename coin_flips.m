num_trials = 1000000000;
start_target = 7;
end_target = 7;
max_dist = (2^(end_target+3));
distribution_count = zeros(end_target, max_dist);
for target = start_target:end_target
    for i = 1:num_trials
        consecutive = 0;
        total = 0;
        while consecutive < target
            if rand < 0.5
                consecutive = consecutive + 1;
            else
                consecutive = 0;
            end
            total = total + 1;
        end
        if total < max_dist
            distribution_count(target, total) = distribution_count(target, total) + 1;
        end
        if mod(((i*100) / num_trials), 5) == 0
            percent = (i*100) / num_trials
        end
    end
end
distribution_cum = zeros(end_target, max_dist);
for i = 1:end_target
    for j = 2:max_dist
        distribution_count(i, j) = distribution_count(i, j) / num_trials;
        distribution_cum(i, j) = distribution_cum(i, j-1) + distribution_count(i, j);
    end
end
figure(1)
fitter = transpose(distribution_count(7, 8:max_dist));
range = transpose(8:max_dist);
f = fit(range, fitter, 'exp1')
plot(1:max_dist, distribution_count)
hold on
plot(f)
hold off
figure(2)
plot(1:max_dist, distribution_cum)