% Given a flow link, calculate the coefficient of head loss, or the
% coefficient of v^2/2g for the modified Bernoulli equation. This
% coefficient is given by f*L/D + K, and includes both major and 3K-method
% minor head losses
function c = head_loss_coefficient(link)
f = friction_factor(link.diameter, link.velocity);
c = f * link.length / link.diameter + link.K;
end