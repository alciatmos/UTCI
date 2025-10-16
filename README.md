Some scripts to estimate the Universal Thermal Climate Index (UTCI) following the methodology to used in the ERA5


UTCIdaily = UTCInwpdailydata(lon,lat,time,tas,wspd,hurs,rsds,rsus,rsdsdiff,rlds,rlus)

%Estimate the mean daily UTCI from daily nwp data.
%
%Output
%  UTCIdaily:  mean daily UTCI value
%
%Input
%  longitude:   longitude of hte location
%  latitude:    longitude of hte location
%  time:        time of the location in UTC. datenum format, check Matlab help
%  tas:	        air temperature in°C (range: -50 °C to +50 °C)
%  wspd:	      wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%  hurs:	      relative humidity in % (5% to 100%)
%  rsds:	      surface downelling shortwave radiation flux in air (W m**-2)
%  rsus:	      surface upwelling shortwave radiation flux in air  (W m**-2)
%  rsdsdiff:	  surface diffuse downwellling shortwave radiation flux in air (W m**-2)
%  rlds:	      downwelling longwave radiation at the surface from the atmosphere (W m**-2)
%  rlus:        surface upwelling longwave radiation flux in air (W m**-2)


[ttransit,H,delta] = SolarDay(longitude,latitude,time)
%Calculates the length of a Solar day, the sun declination and its transit time at a location and date.
%
%Output
%  ttransit:    time of transit (UTC), in datenum format
%  H:           duration of the solar day, in hours
%  delta:       declination of the sun at its transit
%
%Input
%  longitude:   in degrees; from -180E to 180E
%  latitude:    in degrees; from -90 to 90N
%  time:        the date in datenum format and in UTC


MRT = MRT(L_dn,L_up,Istar,S_up,S_dn_df,gamma)
%Estimation of the Mean Radiant Temperature (MRT).
%Claudia Di Napoli, Robin J. Hogan, Florian Pappenberger, 2020:
%Mean radiant temperature from global-scale numerical weather prediction models
%https://doi.org/10.1007/s00484-020-01900-5
%International Journal of Biometeorology (2020) 64:12
%
%Output
%  MRT:         mean radiant temperature, in °C
%
%Input
%  LR_dn:       downwelling longwave radiation at the surface from the atmosphere
%  LR_up:       downwelling longwave radiation at the surface from the ground
%  S_up:        surface reflected solar radiation flux
%  Istar:       direct shortwave radiation 
%  S_dn_df:     diffuse shortwave radiation 
%  gamma:       the complementary angle to the solar zenith angle (in degrees)

Matlab scripts for working with the Universal Thermal Index (UTCI)


Tutci = UTCI(Ta,MRT,wspd,rh)
%UTCI estimated from the look-up tables (ESM-4)
%Bröde, P., Fiala, D., Błażejczyk, K. et al., 2012:
%Deriving the operational procedure for the Universal Thermal Climate Index (UTCI).
%Int J Biometeorol 56, 481–494 (2012).
%https://doi.org/10.1007/s00484-011-0454-1
%
%Output
%  Tutci:       Universal Thermal Comfort Index, in °C
%
%Input
%  Ta:          temperature in°C (range: -50 °C to +50 °C)
%  MRT:         mean radiant temperature (Tr) in °C
%  wspd:        wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%  rh:          relative humidity in % (5% to 100%)
%
%Note: Lookup tables are in UTCI.mat

Tutci = UTCInwp(tas,wspd,hurs,rsds,rsus,costheta,rsdsdiff,rlds,rlus)
%UTCI derived from variables typically found in nwp models
%
%Output
%  Tutci:       Universal Thermal Comfort Index, in °C
%
%Input
%  tas:         air temperature in°C (range: -50 °C to +50 °C)
%  wspd:	      wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%  hurs:	      relative humidity in % (5% to 100%)
%  rsds:	      surface downelling shortwave radiation flux in air (W m**-2)
%  rsus:	      surface upwelling shortwave radiation flux in air  (W m**-2)
%  costheta:    cosine of the average daytime cosine of the solar zenith angle
%  rsdsdiff:	  surface diffuse downwellling shortwave radiation flux in air (W m**-2)
%  rlds:	      downwelling longwave radiation at the surface from the atmosphere (W m**-2)
%  rlus:	      surface upwelling longwave radiation flux in air (W m**-2)
%
%Note: to estimate costheta for custom time intervals use equation 12 of (Napoli, 2020)
%Note to self: Need to add a function to get this variable...


Methodology for computing the UTCI.pptx
%Some slide on what equations are being solved


%----------------------------------------------------
%When using CMIP6 daily data, the mean UTCI can be obtained from:
UTCI_cmpi6 = UTCInwpdailydata(__)

UTCInwpdailydata(__)
  --> calls SolarDay(__)
  --> calculates costheta = costheta(latitude,H)
  --> calls UTCInwp(__)
              --> calls MRT(__)
              --> calls UTCI(__)
