% plot training log curve

close all;
clear all;

train = importdata('nohup.log.train');
test = importdata('nohup.log.test');
train_data = train.data;
test_data = test.data;

train_iter = train_data(1:100:end,1);
train_loss = train_data(1:100:end,3);
test_iter = test_data(:,1);
test_loss = test_data(:,3);

subplot(1,2,1);
plot(train_iter,log(train_loss));
xlabel('train iter');
ylabel('log(train loss)');
title('train loss VS train iterate ')
hold on

subplot(1,2,2);
plot(test_iter,log(test_loss));
xlabel('test iter');
ylabel('log(test loss)');
title('test loss VS test iterate')
hold off



