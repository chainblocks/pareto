//
// Created by Alan Freitas on 08/09/20.
//

#include "python_instantiations.h"
#include <pareto_front/front.h>

namespace pareto {
    template class archive<double, 0, py::object, r_star_tree_tag>;
    template class archive<double, 1, py::object, r_star_tree_tag>;
    template class archive<double, 2, py::object, r_star_tree_tag>;
    template class archive<double, 3, py::object, r_star_tree_tag>;
    template class archive<double, 4, py::object, r_star_tree_tag>;
    template class archive<double, 5, py::object, r_star_tree_tag>;
    template class archive<double, 6, py::object, r_star_tree_tag>;
    template class archive<double, 7, py::object, r_star_tree_tag>;
    template class archive<double, 8, py::object, r_star_tree_tag>;
    template class archive<double, 9, py::object, r_star_tree_tag>;
    template class archive<double, 10, py::object, r_star_tree_tag>;
}