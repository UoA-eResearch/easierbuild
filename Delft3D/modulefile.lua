help([==[

Description
===========
Delft3D is a world leading 3D modeling suite to investigate hydrodynamics, sediment transport and morphology and water quality for fluvial, estuarine and coastal environments.

More information
================
 - Homepage: http://oss.deltares.nl/web/delft3d
]==])

whatis([==[Delft3D is a world leading 3D modeling suite to investigate hydrodynamics, sediment transport and morphology and water quality for fluvial, estuarine and coastal environments. - Homepage: http://oss.deltares.nl/web/delft3d]==])
whatis([==[Homepage: http://oss.deltares.nl/web/delft3d]==])
whatis([==[URL: http://oss.deltares.nl/web/delft3d]==])

local root = "/mnt/Delft3D/65802"

conflict("Delft3D")

if not ( isloaded("PETSc/3.8.3-foss-2017b-downloaded-deps") ) then
    load("PETSc/3.8.3-foss-2017b-downloaded-deps")
end

if not ( isloaded("METIS/5.1.0-foss-2017b") ) then
    load("METIS/5.1.0-foss-2017b")
end

if not ( isloaded("netCDF-Fortran/4.4.4-foss-2017b-HDF5-1.8.19") ) then
    load("netCDF-Fortran/4.4.4-foss-2017b-HDF5-1.8.19")
end

prepend_path("LD_LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("LIBRARY_PATH", pathJoin(root, "lib"))
prepend_path("PATH", pathJoin(root, "bin"))
setenv("EBROOTDELFT3D", root)
setenv("EBVERSIONDELFT3D", "65802")
