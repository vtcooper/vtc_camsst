Vince Cooper notes:

example_inout has some files I fetched from Yue Dong's scripts / Cecile Hannay.

This shows what a file should look like, formatting and varnames etc, before you bcgen diddle it.

sstice_files has the inputs i have used and the outputs i have made for use in CAM.
I use the prep_prediddle.ipynb in this folder to get data formatted to plug into bcgen.

gamil_init is some github i forked to try to use its bcgen but it didnt work for me.

ydong_bcgen has the bcgen folder that I have working. README in there has my personal
steps to use bcgen. "active_bcgen" is a misnomer... i tried to work it there but should
really just delete it. caution to all.

---- Email with directions to do this sent on 11/18/24 ------
If you want to give it a go yourself:
1) You do need to regrid the B files from the POP grid to the atmosphere grid. You can use CDO or python’s xESMF or NCL for this, and just use the example F input as the target grid in the regridding operation. There is some older documentation (that I can’t find right now) that used to mention that regridding was the first step. The old documentation had an ncl script for the regridding. You do need to interpolate over the continents so there are SST and ICE values everywhere and no NaNs. The model won’t use the values over land but it won’t work if there are nans.

2) You need to make some corrections to the SST/ice concentration so they are consistent enough to make CAM happy (reference is Hurrell et al. 2008):
The old directions in NCL are:
    ; Corrections for data consistency
    ; 1) If SST < -1.8 or ice frac >= 90%, SST = -1.8
    SST = where(SST.le.-1.8, -1.8, SST)
    SST = where(SEAICE.gt.90., -1.8, SST)

    ; 2) min ice frac is 0%, max ice_frac is 100%
    SEAICE = where(SEAICE.lt.0., 0., SEAICE)
    SEAICE = where(SEAICE.gt.100., 100., SEAICE)

    ; 3) Hurrell et al correction to SST (if 0.15 < ice frac < 0.9)
    SST_max = 9.328*(0.729-(SEAICE/100.)^3)-1.8
    SST = where((SEAICE.gt.15.).and.(SEAICE.lt.90.).and.(SST.gt.SST_max), SST_max, SST)

    ; 4) No sea ice if SST > 4.97
    SEAICE = where(SST.gt.4.97, 0., SEAICE)

    ; 5) Hurrell et al correction to ice frac (if -1.8 < SST < 4.97)
    ice_max = 100.*(0.729-(SST+1.8)/9.328)^(1./3.)
    SEAICE = where((SST.gt.-1.8).and.(SST.lt.4.97).and.(SEAICE.gt.ice_max), ice_max, SEAICE)


3) You need to run the bcgen script to do the time diddling that translates monthly means into mid-month values that the model can read and interpolate. This is essential because if you don’t do it, the output from the model will not match the desired input file. 
To run this script, the data does need to be in some special format. I saved an example file here (although it is on 1 degree grid) so I could mimic its formatting when I prep my files for bcgen: 
/glade/work/vcooper/p2c2/vtc_camsst/example_inout/sstice_b.e21.BSSP370cmip6.f09_g17.CMIP6-SSP3-7.0.001_201501-210012_0.9x1.25_pre.nc

If you are on NCAR computers, the directions and necessary files to run the bcgen script are here:
/glade/u/home/vcooper/modelcode/cesm2_1_5/components/cam/tools/icesst/
You do need to compile bcgen yourself in order to run it, but I think the directions to do so are in that folder.

When you are ready to do the F run, I suggest adding the following line to the user_nl_cam file so that you can check whether the SST and ice concentration look right. Otherwise CAM won’t output the SST, it will only output TS:
fincl1 ='SST','ICEFRAC’ 

FYI in my recent CAM6 run, I have noticed that CAM6 seems to be outputting some different SST values under sea ice compared to the values I prescribed as input. This did not happen with CAM4/5, and it doesn’t seem to be an issue, but just thought Id mention in case you find the same thing.


