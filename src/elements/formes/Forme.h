#pragma once

#include <memory>
#include <string>

#include "../Couleur.h"
#include "../Element.h"

// TODO: Maybe get rid of the struct and make these object attr
class Forme: public Element {
public:
    struct Proprietes {
        Couleur couleur;
        Couleur remplissage;
        uint8_t opacite;
        uint16_t rotation;
        uint16_t epaisseur;
    };

public:
    Forme(Proprietes const& prop): _prop(prop) {}
    virtual std::string to_svg() const = 0;
    virtual double toDouble() const noexcept override { return 1.0; }

private:
    Proprietes _prop;
};

using FormePtr = std::shared_ptr<Forme>;
