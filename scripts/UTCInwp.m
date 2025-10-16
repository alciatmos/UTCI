%Estimate the UTCI nwp data.
%
%
%   tas:	    air temperature in°C (range: -50 °C to +50 °C)
%   wspd:	    wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%   hurs:	    relative humidity in % (5% to 100%)
%   rsds:	    surface downelling shortwave radiation flux in air (W m**-2)
%   rsus:	    surface upwelling shortwave radiation flux in air  (W m**-2)
%   costheta:   cosine of the average daytime cosine of the solar zenith angle
%   rsdsdiff:	surface diffuse downwellling shortwave radiation flux in air (W m**-2)
%   rlds:	    downwelling longwave radiation at the surface from the atmosphere (W m**-2)
%   rlus:	    surface upwelling longwave radiation flux in air (W m**-2)


function Tutci = UTCInwp(tas,wspd,hurs,rsds,rsus,costheta,rsdsdiff,rlds,rlus)

%Get the MRT temperature
%Equation 13
Istar = rsds./costheta;
%When there is no solar radiation.
Istar(costheta == 0) = 0;

%Equation 16
gamma = 90 - acosd(costheta);
%gamma(costheta == 0) = 90;

%Eqn 14.
Tr = MRT(rlds,rlus,Istar,rsus,rsdsdiff,gamma);
%--------------------------------------------------------------------------

%Get the UTCI from lookuptables.
%Available at ESM-4 of https://doi.org/10.1007/s00484-011-0454-1
Tutci = UTCI(tas,Tr,wspd,hurs);

end