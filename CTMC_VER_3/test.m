tspan = 0.0:0.1:10;
[t,w] = ode45(@ode, tspan, [-0.5;-0.5]);
plot(w(:,1),w(:,2))
hold on
quiver(w(:,1),w(:,2),gradient(w(:,1)),gradient(w(:,2)))

function dx = ode(t,x)
    dx = [x(2) ; - x(2) - 4*x(1)];
end