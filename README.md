# Universal Thermal Climate Index (UTCI)

Matlab Scripts to estimate the Universal Thermal Climate Index (UTCI) following the same methodology used in the ERA5 UTCI.

## \scripts contents

### 1. `UTCIdaily = UTCInwpdailydata(lon, lat, time, tas, wspd, hurs, rsds, rsus, rsdsdiff, rlds, rlus)`
Estimate the mean daily UTCI from daily NWP data.

**Output:**  
- `UTCIdaily`: mean daily UTCI value

**Inputs:**
- `longitude`: longitude of the location
- `latitude`: latitude of the location
- `time`: time of the location in UTC, datenum format (see Matlab help)
- `tas`: air temperature in °C (range: -50 °C to +50 °C)
- `wspd`: wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
- `hurs`: relative humidity in % (5% to 100%)
- `rsds`: surface downwelling shortwave radiation flux in air (W m⁻²)
- `rsus`: surface upwelling shortwave radiation flux in air (W m⁻²)
- `rsdsdiff`: surface diffuse downwelling shortwave radiation flux in air (W m⁻²)
- `rlds`: downwelling longwave radiation at the surface from the atmosphere (W m⁻²)
- `rlus`: surface upwelling longwave radiation flux in air (W m⁻²)

---

### 2. `[ttransit, H, delta] = SolarDay(longitude, latitude, time)`
Calculates the length of a solar day, the sun declination, and its transit time at a location and date.

**Outputs:**  
- `ttransit`: time of transit (UTC), in datenum format  
- `H`: duration of the solar day, in hours  
- `delta`: declination of the sun at its transit

**Inputs:**
- `longitude`: in degrees; from -180E to 180E
- `latitude`: in degrees; from -90 to 90N
- `time`: the date in datenum format and in UTC

---

### 3. `MRT = MRT(L_dn, L_up, Istar, S_up, S_dn_df, gamma)`
Estimation of the Mean Radiant Temperature (MRT).  
Reference: Claudia Di Napoli, Robin J. Hogan, Florian Pappenberger (2020), "Mean radiant temperature from global-scale numerical weather prediction models"  
[https://doi.org/10.1007/s00484-020-01900-5](https://doi.org/10.1007/s00484-020-01900-5)

**Output:**  
- `MRT`: mean radiant temperature, in °C

**Inputs:**
- `LR_dn`: downwelling longwave radiation at the surface from the atmosphere
- `LR_up`: upwelling longwave radiation at the surface from the ground
- `S_up`: surface reflected solar radiation flux
- `Istar`: direct shortwave radiation
- `S_dn_df`: diffuse shortwave radiation
- `gamma`: complementary angle to the solar zenith angle (in degrees)

---


### 5. `Tutci = UTCInwp(tas, wspd, hurs, rsds, rsus, costheta, rsdsdiff, rlds, rlus)`
UTCI derived from variables typically found in NWP models.

**Output:**  
- `Tutci`: Universal Thermal Comfort Index, in °C

**Inputs:**
- `tas`: air temperature in °C (range: -50 °C to +50 °C)
- `wspd`: wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
- `hurs`: relative humidity in % (5% to 100%)
- `rsds`: surface downwelling shortwave radiation flux in air (W m⁻²)
- `rsus`: surface upwelling shortwave radiation flux in air (W m⁻²)
- `costheta`: cosine of the average daytime cosine of the solar zenith angle
- `rsdsdiff`: surface diffuse downwelling shortwave radiation flux in air (W m⁻²)
- `rlds`: downwelling longwave radiation at the surface from the atmosphere (W m⁻²)
- `rlus`: surface upwelling longwave radiation flux in air (W m⁻²)

**Notes:**
- To estimate `costheta` for custom time intervals, use equation 12 of Napoli (2020).
- Need to add a function to get this variable.

---

### 4. `Tutci = UTCI(Ta, MRT, wspd, rh)`
UTCI estimated from the look-up tables (ESM-4)  
Reference: Bröde, P., Fiala, D., Błażejczyk, K. et al. (2012), "Deriving the operational procedure for the Universal Thermal Climate Index (UTCI)."  
[https://doi.org/10.1007/s00484-011-0454-1](https://doi.org/10.1007/s00484-011-0454-1)

**Output:**  
- `Tutci`: Universal Thermal Comfort Index, in °C

**Inputs:**
- `Ta`: temperature in °C (range: -50 °C to +50 °C)
- `MRT`: mean radiant temperature (Tr) in °C
- `wspd`: wind speed in m/s measured 10 m above ground level (0.5 m/s to 30.3 m/s)
- `rh`: relative humidity in % (5% to 100%)

**Note:** Lookup tables are in `UTCI_lut.mat`.

---

## Methodology

Methodology for computing the UTCI is available in `UTCI.pptx` (contains slides on the equations being solved).

---

## CMIP6 Daily Data

When using CMIP6 daily data, the mean daily UTCI can be obtained from:

```matlab
UTCI_cmpi6 = UTCInwpdailydata(__)
```

---

## Function Call Sequence

```
UTCInwpdailydata(__) 
  └─> SolarDay(__) 
  └─> calculates costheta = costheta(latitude, H)
  └─> calls UTCInwp(__) 
        └─> calls MRT(__) 
        └─> calls UTCI(__)
```

---
