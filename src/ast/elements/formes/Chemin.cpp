#include "Chemin.h"

void Chemin::ajoutePoint(int x, int y) {
    _points.push_back(Point {x, y});
}
