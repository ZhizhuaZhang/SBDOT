function [] = Check_pb( obj )
    % CHECK_PB Verify that high and low fidelity Problem have the same
    % parameters

    assert( obj.prob_LF.m_x == obj.prob_HF.m_x, ...
        'SBDOT:Problem_multify:dimension_input', ...
        'Input space dimension is different between HF and LF problem' );
    obj.m_x = obj.prob_LF.m_x;

    assert( obj.prob_LF.m_y == obj.prob_HF.m_y, ...
        'SBDOT:Problem_multify:dimension_objective', ...
        'Output space dimension for objective is different between HF and LF problem' );
    obj.m_y = obj.prob_LF.m_y;
    
    assert( obj.prob_LF.m_g == obj.prob_HF.m_g, ...
        'SBDOT:Problem_multify:dimension_constraint', ...
        'Output space dimension for constraint is different between HF and LF problem' );
    obj.m_g = obj.prob_LF.m_g;
    
    assert( all( obj.prob_LF.lb == obj.prob_HF.lb ), ...
        'SBDOT:Problem_multify:lb_difference', ...
        'Lower bound of input space is different between HF and LF problem' );
    obj.lb = obj.prob_LF.lb;
    
    assert( all( obj.prob_LF.ub == obj.prob_HF.ub ), ...
        'SBDOT:Problem_multify:ub_difference', ...
        'Upper bound of input space is different between HF and LF problem' );
    obj.ub = obj.prob_LF.ub;
    
end

