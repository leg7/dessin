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

    const Forme * getForme(std::string const& nom) const;
    Forme * getForme(std::string const& nom);
    void setForme(std::string const& nom, Forme * forme);
    void setForme(std::string const& nom, std::string const& nom2);

    void ajouterCarre(int x1, int y1, int taille);
    void ajouterCercle(int x1, int y1, int rayon);
    void ajouterChemin(int x, int y);
    void ajouterEllipse(int x1, int y1, int longueur, int hauteur);
    void ajouterLigne(int x1, int y1, int x2, int y2);
    void ajouterRectangle(int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4);
    void ajouterTexte(int x1, int y1, std::string const& texte, std::string const& police);
    void ajouterTriangle(int x1, int y1, int longueur, int hauteur);

    void cheminContinuer(int x1, int y1);
};

#endif
