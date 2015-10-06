function op_train_pipe_with_mask(in, mask, gt_out)
    global config mem;
    
    % forward pass
    config.misc.training = 1;
    mem.GT_output = gt_out;
    config.pipeline_forward{1}(in);
    config.pipeline_forward{2}(mask);
    for m = 3:length(config.pipeline_forward)
        config.pipeline_forward{m}();
    end
    config.misc.current_layer = config.misc.current_layer - 1;
    % backprop
    for m = 1:length(config.pipeline_backprop)
        config.pipeline_backprop{m}();
    end
    config.misc.current_layer = 1;
end

