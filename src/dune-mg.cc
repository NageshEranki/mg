// -*- tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 2 -*-
// vi: set et ts=4 sw=2 sts=2:

#ifdef HAVE_CONFIG_H
# include "config.h"
#endif
//C++ includes
#include <iostream>
#include <vector>
#include <stdio.h>
//dune-common includes
#include <dune/common/parallel/mpihelper.hh> // An initializer of MPI
#include <dune/common/exceptions.hh> // We use exceptions
//dune-grid includes
#include <dune/grid/common/gridinfo.hh>
#include <dune/grid/geometrygrid.hh>
#include <dune/grid/geometrygrid/coordfunction.hh>
#include <dune/grid/common/mcmgmapper.hh>
#include <dune/grid/io/file/gmshreader.hh>
#include <dune/grid/io/file/vtk/vtkwriter.hh>
//dune-pdelab includes
#include <dune/pdelab/boilerplate/pdelab.hh>
#include<dune/pdelab/function/callableadapter.hh>
//Custom deformation function includes
#include "defct.hh"

int main(int argc, char** argv)
{
  try{
    // Maybe initialize MPI
    Dune::MPIHelper& helper = Dune::MPIHelper::instance(argc, argv);

    const int dim = 2;

    //Instantiate YaspGrid object and corresponding leaf grid view.
    typedef Dune::YaspGrid<dim> Grid;
    typedef Grid::LeafGridView GV;
    Grid hostgrid({4.0,4.0},{2,2});
    GV gv = hostgrid.leafGridView();

    //Instantiate Deformation function.
    typedef DeformationFunction<GV,dim> Defct;
    Defct defct(gv);

    //Instantiate GeometryGrid object to wrap YaspGrid and corresponding leaf grid view.
    typedef Dune::GeometryGrid<Grid,Defct> GeoGrid;
    GeoGrid geogrid(hostgrid,defct);
    typedef typename GeoGrid::LeafGridView GeoGV;
    GeoGV geogv = geogrid.leafGridView();

    //Define and instantiate custom grid function. "const auto&" is very important.
    auto xlambda = [](const auto& x){return 2;};//Dune::FieldVector<double,dim>(x);};
    auto x = Dune::PDELab::makeGridFunctionFromCallable(geogv,xlambda);

    auto stationaryVTKWriter_u = std::make_shared<Dune::SubsamplingVTKWriter<typename GeoGrid::LeafGridView>>(geogv,0);

    std::string basename_u;
    basename_u =  "output";
    basename_u += "_u";

    Dune::VTKSequenceWriter<GeoGV> vtkwriter_u(stationaryVTKWriter_u,basename_u,"","");

    vtkwriter_u.addVertexData(std::make_shared<Dune::PDELab::VTKGridFunctionAdapter<decltype(x)> >(x,"x_h"));

    int counter = 0;
    double time = 0.0;

    vtkwriter_u.write(time,Dune::VTK::appendedraw);

    do
    {
      defct.move(time,0.05);
      time += 0.1;
      counter += 1;
      vtkwriter_u.write(time,Dune::VTK::appendedraw);
    }while(time < 1);
    return 0;
  }
  catch (Dune::Exception &e){
    std::cerr << "Dune reported error: " << e << std::endl;
  }
  catch (...){
    std::cerr << "Unknown exception thrown!" << std::endl;
  }
}
