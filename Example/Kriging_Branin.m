%%% Build a Kriging model of the Branin function

clear all
close all
clc

% Set random seed for reproductibility
rng(1)

% Define problem structure
m_x = 2;      % Number of parameters
m_y = 1;      % Number of objectives
m_g = 1;      % Number of constraint
lb = [-5 0];  % Lower bound 
ub = [10 15]; % Upper bound 

% Create Problem object with optionnal parallel input as true
prob = Problem( 'Branin', m_x, m_y, m_g, lb, ub , 'parallel', true);

% Evaluate the model on 20 points created with LHS
prob.Get_design( 20 ,'LHS' )

%%
% Create Kriging
krig = Kriging ( prob , 1 , [] );

% Plot output depending on the input_1 and input_2
krig.Plot( [1,2], [] );

% Plot output depending on the input_1 , with input_2 = 5
krig.Plot( 1, 5 );

% Compute RMSE with test points
x_test = stk_sampling_maximinlhs( 100, 2, [lb; ub], 200);
x_test = x_test.data;
y_test = Branin( x_test );
rmse = krig.Rmse( x_test, y_test );

%%
% Create Kriging for regression
krig_reg = Kriging ( prob , 1 , [] ,'reg', true );

% Plot output depending on the input_1 and input_2
krig_reg.Plot( [1,2], [] );

%%
% Create Kriging for regression with hyperparameters user defined
krig_reg_set = Kriging ( prob , 1 , [] ,'reg', true , 'hyp_reg', 1e-1 ,'hyp_corr', [10 0.1] );

% Plot output depending on the input_1 and input_2
krig_reg_set.Plot( [1,2], [] );




% ==========================================================================
%
%    This file is part of SBDOT.
%
%    SBDOT is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    SBDOT is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with SBDOT.  If not, see <http://www.gnu.org/licenses/>.
%
%    Use of SBDOT is free for personal, non-profit, pure academic research
%    and educational purposes. Restrictions apply on commercial or funded
%    research use. Please read the IMPORTANT_LICENCE_NOTICE file.
%
% ==========================================================================


