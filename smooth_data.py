import numpy as np
import matplotlib.pyplot as pl
import h5py
from scipy.signal import savgol_filter
#######################################
fa = h5py.File('data_create.h5', 'r')
#fa['stokes']

stokes_3d = np.zeros([4, 477, 340, 900])
stokes_3d[:] = fa['stokes'][:]
for i in range(477):
	for j in range(340):
		a = stokes_3d[0, i, j, :]
		b = savgol_filter(a, 13, 3)

        stokes_3d[0, i, j, :] = b[:]
 

f = h5py.File('stokess_3d.h5', 'w')
db_stokes = f.create_dataset('stokes', stokes_3d.shape, dtype=np.float64)
db_wave = f.create_dataset('wavelength', fa['wavelength'].shape, dtype=np.float64)
db_stokes[:] = stokes_3d
db_wave[:]=fa['wavelength']
f.close()