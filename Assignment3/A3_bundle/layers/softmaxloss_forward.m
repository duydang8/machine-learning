function L = softmaxloss_forward(x, labels)
    % Inputs:
    %    x - Features. See the reshape command below. It is reshaped as for
    %        the fully connected layer.
    %    labels -  It is a vector with the correct labels. For
    %        instance if we have a batch of two where the first example is
    %        class 4 and the second example is class 7, labels is [4 7].
    %
    % Outputs:
    %    L - The computed loss. You should average over the batch elements.
    %        The loss for a single example is given is the assignment. Compute
    %        that value for all elements in the batch and then average.
    labels = vec(labels);
    sz = size(x);
    batch = sz(end);
    features = prod(sz(1:end-1));

    assert(batch == numel(labels), 'Wrong number of labels given');
    % We reshape x in the same way as for the fully connected layer
    x = reshape(x, [features, batch]);
    % for numerical reasons. Convince yourself that the result is the same.
    x = bsxfun(@minus, x, min(x, [], 1));

    % Compute the softmax probabilities
    y = exp(x) ./ sum(exp(x));
    idx = sub2ind(size(y),labels',1:batch);
    % Compute the loss for each example in the batch
    L_i = -log(y(idx));
    % Compute the average loss over the batch
    L = mean(L_i);
end
