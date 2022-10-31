Vince Cooper (10 Oct 2022)

Includes boundary conditions as follows. All files include both the monthly means (as 
"...prediddle") and the mid-month values that the model will interpolate for SST/SIC.

All values have been infilled to modern-day sea level and ice sheets.

-Baseline: LGMR Late Holocene (mean of 0-4ka) from Osman et al. (2021)
-LGM: LGMR LGM (mean of 19-23 ka) from Osman et al. (2021)
	--anomalies are added to Baseline (SST)
	--SIC is used directly
-2xCO2: LongRunMIP (Rugenstein et al. 2019) mean of 6 models;
	--anomalies are computed as:  (mean of final 200 years of
	  each 2xCO2 simulation) less (mean of final 200 years of
	  each control simulation) [for SST]
	--SST anomalies are added to Baseline
	--SIC is used directly as multi-model mean of final 200
	  years of each 2xCO2 simulation
	--Note: some are 1pct2x and others are abrupt2xCO2, but
	  each are run to near-equilibrium
	--Note: only MIROC included monthly SST (rather than 
	  annual), so the SST climatology for each model is
	  scaled to match MIROC's seasonal cycle. All models
	  include monthly SIC.
--LGM by 0.5 K: same as above by SST anomalies have been multiplied by
	a scale factor to reduce global annual mean anomaly to 0.5 K
	--sea ice is held constant at Baseline
--2xCO2(lrmip) by 0.5 K: same as LGM 0.5 K


Details below of model years used for composing the 2xCO2 boundary condition:
CESM 104
a2x: 2300-2500 
control: 800-1000

CNRM CM61
a2x: 550-750
Control: 1800-2000

HadCM3L
a2x: 500-700
control: 500-700
(Something weird happens in year ~800 of control)
“HadCM3L has a jump of about 80W/m2 in surface heat fluxes 
constructed by atmospheric variables hfls, hfss, rls, 
rsds, rsus after 800 years of control.“

MPI ESM 12
a2x: 800-1000
control: 1300-1500

MIROC 32
1pct2x: 1803-2003
control: 481-681

GFDL ESM2M:
1pct2x: 4300-4500
control: 1140-1340




