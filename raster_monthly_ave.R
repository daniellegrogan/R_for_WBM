# raster_monthly_ave.R
# Function to time average months over multiple raster bricks
# Function is useful for making monthly climatologies of WBM output (or other raster data)
# NB: assumes the input file has a multiple of 12 layers

# Danielle S Grogan
# Last updated 2020-04-21


raster_monthly_ave = function(brk.data,        # a raster brick or raster stack
                              out.dir = NA,    # character string; dirctory to which to write output. If NA, then no file is written
                              out.nm,          # character string; file name for output
                              r = 1,           # 1 or 0; 1 will return result as brick, 0 will not
                              varname = NA,    # character string: varname attribute in output file
                              varunit = NA,    # character string: varunit attribute in output file
                              longname= NA,    # character string: longname attribute in output file
                              overwrite = 0){  # 1 or 0: 1 will over-write, 0 will not        
  
  # make indices for aggregating
  ind = rep(seq(1:12), nlayers(brk.data)/12)
  
  # aggregate
  if(is.na(out.dir)){
    brk.agg = stackApply(brk.data, indices = ind, fun = mean)
  }else{
    filename = file.path(out.dir, out.nm)
    if((overwrite == 0 & !file.exists(filename)) | overwrite == 1){
      if(!file.exists(filename)){
        brk.agg = stackApply(brk.data, indices = ind, fun = mean,
                             filename = file.path(out.dir, out.nm), 
                             varname = varname,
                             varunit = varunit, 
                             longname = longname,
                             overwrite = T)
      }
    }
    
  }
  
  if(r == 1){
    return(brk.agg)
  }
}       

