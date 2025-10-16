%function compute the MRT.
%Equation 14 of:
%Claudia Di Napoli1,2 & Robin J. Hogan1 & Florian Pappenberger, 2020: Mean radiant temperature from global-scale numerical weather prediction models
%https://doi.org/10.1007/s00484-020-01900-5
%International Journal of Biometeorology (2020) 64:12

%LR_dn is the downwelling longwave radiation at the surface from the atmosphere
%LR_up is the downwelling longwave radiation at the surface from the ground
%S_up is the surface reflected solar radiation flux
%Istar direct shortwave radiation 
%S_dn_df diffuse shortwave radiation 
%gamma is the complementary angle to the solar zenith angle (in degrees)

function MRT = MRT(L_dn,L_up,Istar,S_up,S_dn_df,gamma)

%Constants
%Inverse of the Steffan Boltzmann constant
rsigma = 1/(5.67*10^(-8));  %5.67 × 10−8 W/m2K4

%Solid angle 
fa = 0.5;

%Effective shortwave absorptance of the body surface (clothing and skin).
alpha_ir = 0.7;
%emmisivity of the clothed human body.
eps_p = 0.97;
k = alpha_ir/eps_p;

%A surface projection angle. Eq 15 of https://doi.org/10.1007/s00484-020-01900-5
fp = 0.308*cosd(gamma.*(0.998 - (gamma.^2)/50000));
%Jendritzky, G., Menz, H., Schirmer, H., and Schmidt-Kessen, W., 1990:
%Methodik zur raumbezogenen Bewertung der thermischen Komponente im Bioklima des Menschen (Fortgeschriebenes KlimaMichel-Modell)
%[Methodology for the spatial evaluation of the thermal component in the bioclimate of humans (updated KlimaMichel model)]. Beitr Akad Raumforsch Landesplan, 114. 

%Calculation of the Mean Radiant Temperature. Eqn 14
MRT = ( ...
       rsigma.*(...
                fa.*(L_dn + L_up) + ...
                k.*(fp.*Istar + fa.*S_up+ fa.*S_dn_df) ...
               ) ...
      ).^0.25;