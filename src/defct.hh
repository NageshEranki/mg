//***********************************************************************
//***********************************************************************
// Discrete function to deform the underlying grid
//***********************************************************************
//***********************************************************************

template <class GV,int dim>
class DeformationFunction: public Dune::DiscreteCoordFunction< double, GV::dimension, DeformationFunction<GV,dim> >
{
    //friend class DiscreteCoordFunction< ct, dimR, Impl >;
    // static const int dim = GV::dimension;
    static const int dimworld = dim;
    typedef DeformationFunction<GV,dim> This;
    typedef Dune::DiscreteCoordFunction< double, GV::dimension, This > Base;
    typedef Dune::FieldVector<double,dimworld> RType;

public:

    DeformationFunction(const GV& gv_): gv(gv_)
    {

        std::cout << "Entered constructor of deformation object: " << std::endl;

        // defining data structures for the deformation
        deformedPosition.resize(dimworld*gv.size(dim));  // coordinate vector over all vertices

        // iterate over all faces

        typedef typename GV::Grid::ctype Coord;
        typedef typename GV::template Codim<0>::Iterator ElementIterator;

        for (ElementIterator eit = gv.template begin<0>(); eit!= gv.template end<0>(); ++eit)
        {
            /*
            * Construct deformation field
            */

            int numberOfCorners = eit->geometry().corners();

            Dune::FieldVector<double,dim> global;
            const typename GV::IndexSet& indexSet = gv.indexSet();
            int idx = indexSet.index(*eit);
            double volume = eit->geometry().volume();

            for (int corner=0; corner < numberOfCorners; corner++)
            {
                int sub_idx = indexSet.subIndex(*eit, corner,dim);
                global = eit->geometry().corner(corner);

                for (int i=0; i< dimworld; i++)
                {
                    deformedPosition[sub_idx*dimworld + i] = global[i];
                }
            }
        }

        time = 0.0;
    }


  // function that must be provided by the class Dune::DiscreteCoordFunction

  // called with hostEntity, where hostEntity is a vertex
  void evaluate ( const typename GV::template Codim<dim>::Entity& hostEntity, unsigned int corner, Dune::FieldVector<double,dimworld> &y ) const
  {

    const typename GV::IndexSet& indexSet = gv.indexSet();
    int idx = indexSet.index(hostEntity);

    for (int i=0; i< dimworld; i++)
    {
        y[i] = deformedPosition[idx*dimworld + i];
    }

  }


  // called with hostEntity, where hostEntity is a face
  void evaluate ( const typename GV::template Codim<0>::Entity& hostEntity, unsigned int corner, Dune::FieldVector<double,dimworld> &y ) const
  {

    const typename GV::IndexSet& indexSet = gv.indexSet();
    int idx = indexSet.subIndex(hostEntity, corner,dim);

    for (int i=0; i< dimworld; i++)
    {
        y[i] = deformedPosition[idx*dimworld + i];
    }

  }

  /*
   * This ist the definition of the velocity, which describes the movement of each vertex of the grid,
   * meaning that V = dx/dt.
   *
   */

  RType velocity (Dune::FieldVector<double,dimworld> global) const
  {
    Dune::FieldVector<double,dimworld> v(0.0);

    if (time < 0.75)
    {
      v[0] = global[0]*2.0;
      v[1] = global[1]*2.0;
    }
    return v;
  }

  /*
   * The function move updates the coordinates of each grid vertex
   */

  void move(const double t, const double dt)
  {

    time = t;

    typedef typename GV::template Codim<dim>::Iterator ElementIterator;

    const typename GV::IndexSet& indexSet = gv.indexSet();

    for (ElementIterator eit = gv.template begin<dim>();
       eit!=gv.template end<dim>(); ++eit)
    {
      int idx = indexSet.index(*eit);

      Dune::FieldVector<double,dimworld>  global = eit->geometry().corner(0);
      Dune::FieldVector<double,dimworld> v = velocity (global);

      for (int i=0; i< dimworld; i++)
      {
        deformedPosition[idx*dimworld +i] += v[i]*dt;
      }
    }
  }


  std::vector<double> deformedPosition;

private:
  double time;
  const GV& gv;

};
