clear all
close all
clc

% Nombre de points HF et LF utilis� pour l'entrainement
n_HF = [10 30 50 70 90 110 130];
n_LF = [40 80 120 160 200 240];

% Donn�es de validation
load DOE_borehole_500.mat

for i=1:length(n_HF)
    
    for j=1:length(n_LF)
        
        for k = 1 : 10
            
            rng(k)
            
            m_x = 8; % Nombre de param�tres
            m_y = 1; % Nombre d'objectifs
            m_g = 0; % Nombre de contraintes
            lb = [0.05 100 63070 990 63.1 700 1120 9855];  % Borne inf�rieure des param�tres
            ub = [0.15 50000 115600 1110 116 820 1680 12045];  % Borne sup�rieure des param�tres
            
            % Construction des probl�mes pour mod�le HF et LF
            prob_HF=Problem('borehole_HF',m_x,m_y,m_g,lb,ub,'parallel',true);
            prob_LF=Problem('borehole_LF',m_x,m_y,m_g,lb,ub,'parallel',true);
            
            % Construction du probl�me multifid�lit�
            prob = Problem_multifi(prob_LF,prob_HF);
            
            % Cr�ation d'un plan d'exp�rience de type Nested LHS et
            % �valuation des points
            prob.Sampling(n_LF(j),n_HF(i),'Nested');
            
            % Construction du Cokrigeage avec estimation par LOO des
            % hyperparam�tres
            cokrig_meta = Cokriging(prob,1,[],'corr_HF','corrgauss','corr_LF','corrgauss',...
                'estim_hyp_HF',@pseudoLikelihood,'estim_hyp_LF',@pseudoLikelihood);
            
            % Calcul erreur de pr�diction et extraction des hyperparam�tres
            RAAE_borehole(i,j,k)  = cokrig_meta.Raae(x_test,y_test);
            
            rho_cokrig(i,j,k) = cokrig_meta.rho;
            hyp_corbf_LF{i,j,k} = cokrig_meta.hyp_corr{1};
            hyp_corbf_HF{i,j,k} = cokrig_meta.hyp_corr{2};
            
        end
    end
end

save('cokrig_borehole_result_LOO','RAAE_borehole','rho_cokrig','hyp_corbf_LF','hyp_corbf_HF')
