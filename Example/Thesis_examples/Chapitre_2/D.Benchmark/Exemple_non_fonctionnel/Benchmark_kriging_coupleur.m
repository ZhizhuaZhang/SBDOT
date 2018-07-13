clear all
close all
clc

rng(1) % Graine de l'al�a

% Diff�rentes fonction de corr�lation � tester
corr_tested = {'corrmatern52','correxp','corrgauss','corrmatern32'};
% Deux m�thodes d'estimation � tester
likelihood_tested = {@marginalLikelihood , @pseudoLikelihood};

col_num = 0;

for i = 1 : 4 % corr
    
    for k = 1 : 2 % m�thode d'estimation
        
        col_num = col_num + 1;
        
        for j = 1:9 % DOE
            
            % Il y a 9 plans d'exp�rience pour moyenner les r�sultats            
            load(['DOE_coupler_lambda_',num2str(j),'.mat'])
            
            % Cr�ation du probl�me et ajout des donn�es charg�es
            problem=Problem(@(x)Coupleur(x),5,1,0,lb,ub);
            problem.Add_data(x,y,[]);
            
            % Construction du krigeage sur la sortie du mod�le
            krig=Kriging(problem,1,[],...
                'estim_hyp',likelihood_tested{k},'corr',corr_tested{i});
            
            % Donn�es de validation
            load('DOE_coupler_lambda_10.mat')
            
            % Calcul de mesure d'erreur de pr�diction sur les donn�es de
            % validation
            RAAE(j,col_num)  = krig.Raae(x,y(:,1));
            RMAE(j,col_num)  = krig.Rmae(x,y(:,1));
            hyp_corr_temp(j,:) = krig.hyp_corr; 
            hyp_corr{col_num}  = hyp_corr_temp;
            
        end
    end
end

% Sauvegarde des r�sultats
save('Results_lambda_kriging','RAAE','RMAE','hyp_corr','corr_tested')
