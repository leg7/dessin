#pragma once

#include "expression.hh"
#include <vector>

class DeclarationForme: public Expression {
public:
    enum class Type {
        Rectangle,
        Carre,
        Triangle,
        Cercle,
        Ellipse,
        Ligne,
        Chemin,
        Texte
    };

    using ListeParametres = std::vector<ExpressionPtr>;

    struct Couleur {
        ExpressionPtr rouge;
        ExpressionPtr vert;
        ExpressionPtr bleu;
    };

public:


private:
    ListeParametres _params;
    Couleur _couleur;
    Couleur _remplissage;
    ExpressionPtr _rotation;
    ExpressionPtr _opacite;
    ExpressionPtr _epaisseur;
};
