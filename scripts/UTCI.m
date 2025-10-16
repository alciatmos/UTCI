%Function to compute the UTCI using the lookuptables (ESM-4) of
%Bröde, P., Fiala, D., Błażejczyk, K. et al., 2012:
%Deriving the operational procedure for the Universal Thermal Climate Index (UTCI).
%Int J Biometeorol 56, 481–494 (2012).
%https://doi.org/10.1007/s00484-011-0454-1
%
%Tutci = UTCI(Ta,MRT,wndspeed,rh)
%
%    Ta:     temperature in°C (range: -50 °C to +50 °C)
%    MRT:	mean radiant temperature (Tr) in °C
%    wspd:	wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%    rh:	relative humidity in % (5% to 100%)


function Tutci = UTCI(Ta,MRT,wspd,rh)

%The difference between mean radiant temperature (Tr) and air temperature in °C (-30 °C to +70 °C)
DT = max(min(MRT - Ta,-30),70);

%Load the UTCI lookuptable
UTCIf = load('UTCI.mat');
UTCIoffset = @(T,DT,wspd,rh) interpn(UTCIf.Tg,UTCIf.DTg,UTCIf.spdg,UTCIf.rhg,UTCIf.UTCIq,T,DT,wspd,rh);

Tutci = Ta + UTCIoffset(Ta,DT,wspd,rh);