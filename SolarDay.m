%Calculates the length of a Solar day for a specific location at a time of
%the year and the sun declination at its transit.

%[J,H,delta] = SolarDayLength(lon,lat,Date)
%
%ttransit is the datenum date for the sun transit. In UTC time
%H is the length of the solar day
%delta is the declination of the sun at its transit
%
%lon: longitude, in degrees; from -180E to 180E
%lat: lattude, in degrees; from -90 to 90N
%time: the date in datenum format. Dates should be given in UTC time
%
%lon,lat,Date must have the same size
%
%The Julian date of the sunrise and sunset is trise = ttransit - H/2;
%                                             tsunset = ttransit + H/2;
%
%Example:
%
%Calculate the length of a day for each latitude and each day of the year
%for the longitude = 0°E
%tt = datenum('2015-01-01'):datenum('2015-12-31');
%lat = -80:80;
%
%[latg,ttg] = meshgrid(lat,tt);
%long = latg*0;
%[J,H,delta] = SolarDay(long,latg,ttg);
%
%figure
%contour(ttg,latg,H,'LevelList',0:16)
%title('duration of lighttime at different latitudes')

function [ttransit,H,delta] = SolarDay(longitude,latitude,time)

J0 = 2451545;
dd = datetime(time,'ConvertFrom','datenum','Format','uuuu-MM-dd');
Jd = ceil(juliandate(dd) - J0 + 0.0008);

Jstar = Jd - longitude/360;

%Solar mean anomaly
M = mod(357.5291 + 0.98560028*Jstar,360);
%Equation of the center
C = 1.9148*sind(M) + 0.0200*sind(2*M) + 0.0003*sind(3*M);

%Ecliptic longitude
lambda = mod(M + C + 180 + 102.9372,360);

%Equation of time
%b = (n-1)*360*635;
%EoT = 229.2*(0.000075 + 0.001868*cosd(b) - 0.032077*sind(b) - 0.0014615*cosd(2*b) - 0.04089*sind(2*b));

%Solar transit (solar noon)
Jtransit = J0 + Jstar + 0.0053*sind(M) - 0.0069*sind(2*lambda);
ttransit = datenum(datetime(Jtransit,'convertfrom','juliandate'));

%Declination of the Sun
delta = asind(sind(lambda)*sind(23.4397));

%Angle of sunrise/sunset
omega = acosd( ...
              max(min(-tand(latitude).*tand(delta),1),-1) ...
             );

%Duration of the day
H = 2*omega/15; %in Hours. To convert to degrees multiply by 360/24=1/15;

% H in angles
%H = 2*omega

%Jrise = Jtransit - H/2;
%Jset = Jtransit + omega/360;