function [corr_mat, f_mat, zero_mat] = Corrlinear ( obj, diff_mat, theta )
% CORRLINEAR 
%   Linear radial function
%   - diff_mat is the matrix of squared manhattan distance
%   - theta is the correlation length parameter
%
%   - corr_mat is the correlation matrix
%   - f_mat is the polynomial matrix
%   - zero mat is the zero matrix
%   Those variables are used in the system to solve for obtaining RBF parameters
%

dist_theta = obj.Norm_theta( diff_mat, theta) ;

corr_mat = dist_theta;

f_mat = ones(obj.prob.n_x,1);

zero_mat = 0;

end





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


