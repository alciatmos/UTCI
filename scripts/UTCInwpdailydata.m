%Estimate the UTCI from daily nwp data.
%
%
%   longitude:  longitude of hte location
%   latitude:   longitude of hte location
%   time:       time of the location in UTC. datenum format, check Matlab help
%   tas:	    air temperature in°C (range: -50 °C to +50 °C)
%   wspd:	    wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
%   hurs:	    relative humidity in % (5% to 100%)
%   rsds:	    surface downelling shortwave radiation flux in air (W m**-2)
%   rsus:	    surface upwelling shortwave radiation flux in air  (W m**-2)
%   rsdsdiff:	surface diffuse downwellling shortwave radiation flux in air (W m**-2)
%   rlds:	    downwelling longwave radiation at the surface from the atmosphere (W m**-2)
%   rlus:	    surface upwelling longwave radiation flux in air (W m**-2)

function UTCIdaily = UTCInwpdailydata(lon,lat,time,tas,wspd,hurs,rsds,rsus,rsdsdiff,rlds,rlus)

costhetadaily = meanzenithangle();

%Check that the data is within the boundaries of the loopkup tables
wspd = min(max(wspd,0.5),30.3);
hurs = min(max(hurs,5),100);
tas =  min(max(tas,-50),50);

UTCIdaily = UTCInwp(tas,wspd,hurs,rsds,rsus,costhetadaily,rsdsdiff,rlds,rlus);


    %Following https://doi.org/10.1007/s00484-020-01900-5 to get MRT-----------
    %Equation 6 integrated over the duration of a day (from -omega to +omega: 2*sind(omega)) instead from hmin to hmax which yields to eqn 12
    function costheta = meanzenithangle()
        
        [~,H,delta] = SolarDay(lon,lat,time);

        %htransit = (J-floor(J))*360;
        %Duration of half a day in hour angle (in degrees).
        H = H*pi/24;
        omega = H/2;
        costheta = sind(delta)*sind(lat) + 2/H*cosd(delta)*cosd(lat)*sin(omega);
        %For regions close to the poles
        costheta(H==0) = 0;
    end

end
