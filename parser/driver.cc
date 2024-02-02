#include "driver.hh"
#include <iostream>

Driver::Driver() {}
Driver::~Driver() {}

/*
const Contexte& Driver::getContexte() const {
    //TODO Retourne le contexte pour qu'il soit accessible en dehors de la classe Driver
}

double Driver::getVariable(const std::string & name) const {
    //TODO Retourne la valeur de la variable name
}

void Driver::setVariable(const std::string & name, double value) {
    //TODO Affecte une valeur à une variable avec l'utilisation du contexte variables
}
*/

void Driver::ajouterCarre(int x1, int y1, int taille)
{
        _carres.push_back(Carre(x1, y1, taille));
}

void Driver::ajouterCercle(int x1, int y1, int rayon)
{
        _cercles.push_back(Cercle(x1, y1, rayon));
}
void Driver::ajouterChemin(int x, int y)
{
        _chemins.push_back(Chemin(x, y));
}
void Driver::ajouterEllipse(int x1, int y1, int longueur, int hauteur)
{
        _ellipses.push_back(Ellipse(x1, y1, longueur, hauteur));
}
void Driver::ajouterLigne(int x1, int y1, int x2, int y2)
{
        _lignes.push_back(Ligne(x1, y1, x2, y2));
}
void Driver::ajouterRectangle(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
{
        _rectangles.push_back(Rectangle(x1, y1, x2, y2, x3, y3, x4, y4));
}
void Driver::ajouterTexte(int x1, int y1, std::string const& texte, std::string const& police)
{
        _textes.push_back(Texte(x1, y1, texte, police));
}
void Driver::ajouterTriangle(int x1, int y1, int longueur, int hauteur)
{
        _triangles.push_back(Triangle(x1, y1, longueur, hauteur));
}

void Driver::cheminContinuer(int x1, int y1)
{
        _chemins.end()->ajoutePoint(x1, y1);
}

