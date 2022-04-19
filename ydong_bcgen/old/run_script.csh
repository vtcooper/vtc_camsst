## setting

module add pgi
setenv USER_FC pgf90
sed -i s/20/12/g regrid/precision.f90
gmake


## bcgen
cd bcgen
./bcgen -i /glade/scratch/hannay/sst-ice/sstice_150001-151012_before_bcgen.nc  -c /glade/scratch/hannay/sst-ice/ssticetemp_1500-1510_clim.nc  -t /glade/scratch/hannay/sst-ice/ssticetemp_1500-1510_ts.nc < ../namelist_1500-1510

./bcgen -i /glade/scratch/hannay/sst-ice/sstice_040201-151012_before_bcgen.nc  -c /glade/scratch/hannay/sst-ice/sstice_0402-1510_clim.nc  -t /glade/scratch/hannay/sst-ice/sstice_0402-1510_ts.nc < ../namelist_0402-1510
