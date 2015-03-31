Scipion downloads and installs a lot of dependency packages

I experienced problems with 
* a pre-installed older version of zlib => changes to SConscript
* matplotlib didn't build properly

This build leverages an existing install of Xmipp
