#ifndef DRIVER_H
#define DRIVER_H

#include <string>
#include <vector>
#include "../formes/formes_inc.hh"
#include "../expressions/contexte.hh"

class Driver {
private:
    Contexte _variables;

    std::map<std::string, Forme*> _variables_formes;

    std::vector<Carre> _carres;
    std::vector<Cercle> _cercles;
    std::vector<Chemin> _chemins;
    std::vector<Ellipse> _ellipses;
    std::vector<Ligne> _lignes;
    std::vector<Rectangle> _rectangles;
    std::vector<Texte> _textes;
    std::vector<Triangle> _triangles;

public:
    Driver();
    ~Driver();

    const   Contexte& getContexte() const;
    double  getVariable(const std::string& name) const;
    void    setVariable(const std::string& name, double value);

    void ajouterCarre(Forme::Proprietes const &p, int x1, int y1, int taille);
    void ajouterCercle(Forme::Proprietes const &p, int x1, int y1, int rayon);
    void ajouterChemin(Forme::Proprietes const &p, int x, int y);
    void ajouterEllipse(Forme::Proprietes const &p, int x1, int y1, int longueur, int hauteur);
    void ajouterLigne(Forme::Proprietes const &p, int x1, int y1, int x2, int y2);
    void ajouterRectangle(Forme::Proprietes const &p, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);
    void ajouterTexte(Forme::Proprietes const &p, int x1, int y1, std::string const& texte, std::string const& police);
    void ajouterTriangle(Forme::Proprietes const &p, int x1, int y1, int longueur, int hauteur);

    void cheminContinuer(int x1, int y1);
};

#endif
