#include "Chemin.h"

void Chemin::ajoutePoint(double x, double y) {
    _points.push_back(Point {x, y});
}
