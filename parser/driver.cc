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

void Driver::ajouterCarre(Forme::Proprietes const &p, int x1, int y1, int taille)
{
        _carres.push_back(Carre(p, x1, y1, taille));
}

void Driver::ajouterCercle(Forme::Proprietes const &p, int x1, int y1, int rayon)
{
        _cercles.push_back(Cercle(p, x1, y1, rayon));
}
void Driver::ajouterChemin(Forme::Proprietes const &p, int x, int y)
{
        _chemins.push_back(Chemin(p, x, y));
}
void Driver::ajouterEllipse(Forme::Proprietes const &p, int x1, int y1, int longueur, int hauteur)
{
        _ellipses.push_back(Ellipse(p, x1, y1, longueur, hauteur));
}
void Driver::ajouterLigne(Forme::Proprietes const &p, int x1, int y1, int x2, int y2)
{
        _lignes.push_back(Ligne(p, x1, y1, x2, y2));
}
void Driver::ajouterRectangle(Forme::Proprietes const &p, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
{
        _rectangles.push_back(Rectangle(p, x1, y1, x2, y2, x3, y3, x4, y4));
}
void Driver::ajouterTexte(Forme::Proprietes const &p, int x1, int y1, std::string const& texte, std::string const& police)
{
        _textes.push_back(Texte(p, x1, y1, texte, police));
}
void Driver::ajouterTriangle(Forme::Proprietes const &p, int x1, int y1, int longueur, int hauteur)
{
        _triangles.push_back(Triangle(p, x1, y1, longueur, hauteur));
}

void Driver::cheminContinuer(int x1, int y1)
{
        _chemins.end()->ajoutePoint(x1, y1);
}

