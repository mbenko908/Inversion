#test program to use k-means to separate in clusters the filament eruption data 

# Martin this is what I am importing for what I needed for Hazel, K-means, ans some plots


# import all the necessary packages
import numpy as np
import matplotlib.pyplot as pl
import matplotlib.gridspec as gridspec
from matplotlib.colors import ListedColormap, LinearSegmentedColormap
import matplotlib.colors
import h5py
import scipy.io #library to read idl type format  
import math
import pickle

from sklearn.cluster import KMeans, MiniBatchKMeans
#from sklearn.decomposition import PCA

from matplotlib import cm

##################################################################

# You should read your data and reshape it into I(x*y, Lambda)
fa = h5py.File('stokess_3d.h5', 'r')

x1, x2 = 0, 339#30, 160
x = x2 - x1

y1, y2= 120, 370 #90, 220
y = y2 - y1

lam1, lam2 = 240, 500
lam = lam2 - lam1 
#################################################################
a = np.zeros([y, x , lam, 4])

#for j in range(4):
a[:] = fa['stokes'][y1:y2, x1:x2, lam1:lam2, :]
	
fa.close()

a_out = a.reshape((x*y, lam, 4))

# reshape the matrix from 3D to 2D
#I = I3.reshape((I3.shape[0]*I3.shape[1]), I3.shape[2])
#Q4 = Q3.reshape((Q3.shape[0]*I3.shape[1]), Q3.shape[2])
#U4 = U3.reshape((U3.shape[0]*I3.shape[1]), U3.shape[2])
#V4 = V3.reshape((V3.shape[0]*I3.shape[1]), V3.shape[2])
I = a_out[:, :, 0]
Q = a_out[:, :, 1]
U = a_out[:, :, 2]
V = a_out[:, :, 3]

for i in range(x*y):
	I[i, :] = I[i, :] - min(I[i, :])
	I[i, :] = I[i, :]/ max(I[i, :])

#def norma(data):
#	for i in range(y):
#		for j in range(x):
#			norm_max = max(data[i, j, 0])
#			norm_min = min(data[i, j, 0])


##############################################
#appying the elbow method
#To check how many clusters are needed
#lista = [10,20,30,40,50, 70, 80, 100, 120, 150, 200, 250, 300, 350, 400, 450, 600, 700]
#distortions = []
##for i in range(1, 61):
#for j, i in enumerate(lista[13:]):
  
    # Number of clusters
#        km = KMeans(n_clusters=i, init='k-means++',
#        n_init=300, max_iter=300
#        )
#        km.fit(I)

#        distortions.append(km.inertia_)

# plot
#pl.plot(lista, distortions, marker='o')
#pl.xlabel('number of clusters')
#pl.ylabel('distortion')
#pl.show()
##############################################
# apply it for I, Q, U, or V. What you think is best for the clusterting
# number of clusters
b1, b2 = 6, 6
k = b1*b2 # Number of clusters in Sainz Dalda et al. 2019 is 60 because harwarde and CPUs

# Run MiniBatchKMeans
km_p =  MiniBatchKMeans(n_clusters=k, init='k-means++', 
        n_init=300)   # number of iterations

# Fitting the input data
km_fit_p = km_p.fit(I)

# Centroid values (result)
centroids_p = km_p.cluster_centers_

# Run Kmeans
km = KMeans(n_clusters=k, init=centroids_p,
        max_iter=300)

# Fitting the input data
km_fit = km.fit(I)

# Getting the cluster labels (0, 1, 2, ....) coords of the pixel 1D 
labels = km.predict(I)
# Transform to 2D (reshape)
labels = labels.reshape(y, x)

# Centroid values (mean profile of each cluster)
centroids = km.cluster_centers_

# plot every centroid profile (k clusters)
#for i in range(0, k-1):

#    f, ax = pl.subplots()
#    ax.plot(wav2, centroids[i, :], label="Spectra cluster number "+str(i).format(0),
#            color='b', linestyle='-', marker='o', markersize=3.0, markerfacecolor='b')
#    ax.legend( loc='lower right')
#    ax.set_xlabel('Wavelength   [$\AA$]') # if I want to put it in AA is [$\AA$]
#    ax.set_ylabel('Centroids I/Ic ')
#    #ax.set_title('Spectra cluster number '+str(i))
#    pl.savefig('plots/' + "spectra_cluster_" + str(i) +".png", format="PNG")
#    pl.show()
pl.imshow(labels)
pl.xlabel(' x, step of slit [pixel] ') 
pl.ylabel(' y,  $\;\longleftarrow$ direction to the limb [pixel]')
pl.savefig("labels"+str(b1*b2)+".png", format="PNG", dpi=200)
pl.show()

fig, ax = pl.subplots(b1,b2, figsize=(30,15))
t=int()
for i in range(b1):
	for j in range(b2):
		#plot profiles in cluster
		t= t+1
		lab = labels == i*b2+j
		for k in range(y):
			for l in range(x):
				if lab[k, l] == 1:
					ax[i, j].plot(a[k, l, :, 0], color="gray")
				else: 
					pass

		ax[i,j].plot(centroids[i*b2+j], color = "red")
		ax[i,j].set_title(str(t))
pl.savefig("spectral_cluster"+str(b1*b2)+".png", format="PNG", dpi=200)
pl.show()



#prof_max = np.zeros((lam, k))
#prof_min = np.zeros((lam, k))
#for i in range(k):
#	lab = labels == i
#	#for j in range(y):
	#	for l in range(x):
#		if lab[j, l] == 1:
#				b = a[j, l, :, 0] 
#				for m in range(lam):
#					prof_max[m, i] = max(b[m])
#					prof_min[m, i] = min(b[m])
#			else: 
#				pass		

#fig, ax = pl.subplots(b1,b2)
#t=int()
#for i in range(b1):
#	for j in range(b2):
#		#plot profiles in cluster
#		t= t+1
#		ax[i, j].plot(prof_max[:,i*b2+j], color="gray")
#		ax[i, j].plot(prof_min[:,i*b2+j], color="gray")
		
#		ax[i,j].plot(centroids[i*b2+j], color = "red")
#		ax[i,j].set_title(str(t))

#pl.show()