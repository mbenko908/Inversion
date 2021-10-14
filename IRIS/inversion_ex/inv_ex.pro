path_to_IRIS_l2 = '/mnt/RAIDofsH/mbenko/raster_IRIS'
raster_files = file_search(path_to_IRIS_l2+'/*iris_l2*raster*fits')

iris2model = iris2(raster_files[24], level=2)

END
sel = show_iris2model(iris2model)

;data_iris = get_info_irisl2(raster_files[25], factor_and_data=1, mgii_only=1) 
;help, data_iris   
